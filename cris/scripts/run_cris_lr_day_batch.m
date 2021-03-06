function run_cris_lr_day_batch()
set_process_dirs;
addpath(genpath(rtp_sw_dir));

% grab the slurm array index for this process
slurmindex = str2num(getenv('SLURM_ARRAY_TASK_ID'));

% File ~/cris-files-process.txt is a list of filepaths to the input
% files or this processing. For the initial runs, this was
% generated by a call to 'ls' while sitting in the directory
% /asl/data/cris/ccast/sdr60_hr/2015: 
%    ls -d1 $PWD >> ~/cris-days-to-process
%
% cris-days-to-process, then, contains lines like:
%    /asl/data/cris/ccast/sdr60_hr/2015/048
[status, inday] = system(sprintf('sed -n "%dp" %s | tr -d "\n"', ...
                                  slurmindex, cris_ccast_file_list));

% for the current day, get list of ccast mat files within the
% directory and then loop over those filenames and call create_cris
dayfiles = dir([inday '/*.mat']);

for i=1:numel(dayfiles)
    % separate out parts of file path. We want to keep the bulk of the
    % filename intact but change SDR -> rtp and change the extension to
    % rtp as well as we make the output file path
    infile = fullfile(inday, dayfiles(i).name);
    [path, name, ext] = fileparts(infile);
% $$$ C = strsplit(path, '/');
% $$$ t = numel(C);
% $$$ sYear = C{t-1};
% $$$ sDoy = C{t};
% $$$ outpath = fullfile(cris_ccast_rtp_out_dir, sYear, sDoy);
% $$$ mkdir(outpath);
% $$$ outfile = fullfile(outpath, strrep(name, 'SDR', 'rtp'));
    outfile = strrep(name, 'SDR', 'rtp');

    % call the processing function
    create_cris_ccast_lores_rtp(infile, outfile)
end
