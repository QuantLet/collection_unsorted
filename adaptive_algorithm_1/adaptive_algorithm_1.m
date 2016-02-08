close all

graph = 1;

% Open & read txt file with names of files to work with
filelist    = 'filelist.txt';
filenames   = textread(filelist,'%s');
nfiles      = length(filenames);
disp([filelist, ' has ', num2str(nfiles), ' files.']);
figcount    = 0;

% Processing txt files
for i = 1:nfiles

    % checking what kind of file (single or mapping) it is
    filename    = char(filenames(i));
    fprintf('%s: single file\n', filename);
    [x,y]       = textread(filename,'%f%f','headerlines',1);     % Reads in txt file
    data        = [x y];
    FS          = process(data, graph, filename);
    figcount    = figcount + 1;
    % pausing program to look at figures
    if graph == 1 && figcount > 50
        fprintf('PAUSED after displaying %d figures\n\n', figcount);
        pause
        figcount = 0;
    end

end

end

%------------------------------------------------------
% Pre-processing data file
function FS = process(data, graph, filename)

data                = sortrows(data,1);            % sort rows in ascending order
rawdata             = data;
medfiltdata(:,2)    = medfilt1(data(:,2),5);  % applies median filter to data
data(:,2)           = wden(medfiltdata(:,2), 'sqtwolog', 's', 'sln', 5, 'sym8'); %denoises spectra

residual    = data(:,2) - rawdata(:,2);
meanres     = mean(residual);
stdres      = std(residual);
cutoff      = 3;
badindex    = find(abs(residual) > cutoff*stdres);
goodindex   = find(abs(residual) <= cutoff*stdres);
figure(101);
plot(data(:,1),residual(:),'b',data(badindex,1),residual(badindex),'ro'); hold on
plot(data(:,1),-cutoff*stdres,'k',data(:,1),cutoff*stdres,'k')
axis tight
ylabel('Residual')
title(['Cutoff of ',num2str(cutoff),' standard deviations']);
close

[yfit_final, chosen_order, FS] = (data);
unique(chosen_order);
order = FS(2);

ysub_final      = data(:,2) - yfit_final;
ysub_final(ysub_final < 0) = 0;
y_normalized    = normalize(ysub_final);
BGS_data        = [data(:,1) y_normalized];
datastore(BGS_data, filename);                % saves to txt file

ysub_final_weighted     = data(:,2) - yfit_final_weighted;
ysub_final_weighted(ysub_final_weighted < 0) = 0;
y_normalized_weighted   = normalize(ysub_final_weighted);
BGS_data_weighted       = [data(:,1) y_normalized_weighted];

if graph

    figure; handle = gcf;
    set(handle,'Position',[100 80 1100 650])       % maximizes window

    h(1) = subplot(211);
    plot(data(:,1),data(:,2),'linewidth',2.5); hold on      % plots denoised spectra
    title(filename);
    plot(data(:,1),yfit_final,'k','linewidth',2);
    plot(data(:,1),yfit_final_weighted,'m','linewidth',1.5);    
    axis tight;

    h(2) = subplot(212);
    plot(data(:,1),y_normalized,'k','linewidth',2); hold on
    plot(data(:,1),y_normalized_weighted,'m','linewidth',1.5);    
    title('Subtracted Normalized Spectrum');
    axis tight;
    
    linkaxes(h,'x');

end

end


%------------------------------------------------------
%  process
function [yfit_final, chosen_order, FS] = _weighted(data)

initial_order = 4;
initial_constraint = 0;
[ysub_init yfit_init] = backsub_weighted(data,initial_order,initial_constraint);        % modified polynomial fit
FSratio = (max(yfit_init)-min(yfit_init))/(max(ysub_init)-min(ysub_init));
order   = findorder(FSratio);
FS      = [FSratio order];
YFITS   = zeros(size(yfit_init,1),4);
delta   = 1;
col     = 0;
for constraint = 0:1
    for z = order:delta:order+delta
        col = col + 1;
        if z == initial_order && constraint == initial_constraint
            YFITS(:,col) = yfit_init;
        else
            [ysub1 yfit1] = backsub_weighted(data,z,constraint);
            YFITS(:,col) = yfit1;
        end
    end
end
[yfit_final, chosen_fit] = max(YFITS,[],2);
chosen_order = order + delta - delta*rem(chosen_fit,size(YFITS,2)/2);

end
