%addpath 'C:\Program Files\MATLAB\R2019b\spm12'


%%% MAKING THE DIRECTORES %%%

folderdir = 'D:/Neuroimaging_Daina/';

CT_dir=dir([folderdir, 'CT*']);
PT_dir=dir([folderdir, 'PT*']);


%%% LOOP FOR DATA %%%

for i = -24:length(PT_dir)
    subjectno = num2str(PT_dir(i).name);

    CT_dirstruct1(i).i = dir([PT_dir(i).folder,filesep, subjectno, filesep,'fMRI_contextMoCoSeries*', filesep, 'f*.nii']);
    CT_dirstruct2(i).i = dir([PT_dir(i).folder,filesep, subjectno, filesep,'T1_00*', filesep, 's*.nii']);
    CT_dirstruct3(i).i = dir([PT_dir(i).folder,filesep, subjectno, filesep,'T1_00*', filesep, 'y*.nii']);
    CT_dirstruct4(i).i = dir([PT_dir(i).folder,filesep, subjectno, filesep,'T1_00*', filesep, 'mrs*.nii']);

 
    
   
    f_filepaths =struct([]);
    
    for j=1:length(CT_dirstruct1(i).i)
        f_filepaths(j).j=[CT_dirstruct1(i).i(j).folder, filesep, CT_dirstruct1(i).i(j).name];
    end
        %f_filepaths={f_filepaths.j}; % bc we convert it to a cell array here, it
        %won't use it again when the loop starts from the beginning bc it needs
        %a struct to be able to index with a dot (I think)

    f_filepaths={f_filepaths.j};
    f_filepaths=f_filepaths';
        
    
    s_folders=cellstr({CT_dirstruct2(i).i(1).folder});
    s_names=cellstr({CT_dirstruct2(i).i(1).name});
    s_filepaths=cellstr(append(s_folders, "\", s_names));

    y_folders=cellstr({CT_dirstruct3(i).i(1).folder});
    y_names=cellstr({CT_dirstruct3(i).i(1).name});
    y_filepaths=cellstr(append(y_folders, "\", y_names));

    mrs_folders=cellstr({CT_dirstruct4(i).i(1).folder});
    mrs_names=cellstr({CT_dirstruct4(i).i(1).name});
    mrs_filepaths=cellstr(append(mrs_folders, "\", mrs_names));

    disp(f_filepaths(1));
    disp(s_folders);
    clear matlabbatch
    matlabbatch{1}.spm.spatial.realign.estwrite.data = {f_filepaths};
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [0 1];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
    matlabbatch{2}.spm.spatial.coreg.estwrite.ref(1) = cfg_dep('Realign: Estimate & Reslice: Mean Image', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rmean'));
    matlabbatch{2}.spm.spatial.coreg.estwrite.source = s_filepaths;
    matlabbatch{2}.spm.spatial.coreg.estwrite.other = {''};
    matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.cost_fun = 'nmi';
    matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.sep = [4 2];
    matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{2}.spm.spatial.coreg.estwrite.eoptions.fwhm = [7 7];
    matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.interp = 4;
    matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.mask = 0;
    matlabbatch{2}.spm.spatial.coreg.estwrite.roptions.prefix = 'r';
    matlabbatch{3}.spm.spatial.preproc.channel.vols(1) = cfg_dep('Coregister: Estimate & Reslice: Resliced Images', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','rfiles'));
    matlabbatch{3}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{3}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{3}.spm.spatial.preproc.channel.write = [0 1];
    matlabbatch{3}.spm.spatial.preproc.tissue(1).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,1'};
    matlabbatch{3}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{3}.spm.spatial.preproc.tissue(1).native = [1 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(1).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(2).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,2'};
    matlabbatch{3}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{3}.spm.spatial.preproc.tissue(2).native = [1 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(2).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(3).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,3'};
    matlabbatch{3}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{3}.spm.spatial.preproc.tissue(3).native = [1 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(3).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(4).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,4'};
    matlabbatch{3}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{3}.spm.spatial.preproc.tissue(4).native = [1 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(4).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(5).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,5'};
    matlabbatch{3}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{3}.spm.spatial.preproc.tissue(5).native = [1 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(5).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(6).tpm = {'C:\Users\biank\Documents\Skole\fMRI_project\spm12\tpm\TPM.nii,6'};
    matlabbatch{3}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{3}.spm.spatial.preproc.tissue(6).native = [0 0];
    matlabbatch{3}.spm.spatial.preproc.tissue(6).warped = [0 0];
    matlabbatch{3}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{3}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{3}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{3}.spm.spatial.preproc.warp.affreg = 'mni';
    matlabbatch{3}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{3}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{3}.spm.spatial.preproc.warp.write = [0 1];
    matlabbatch{4}.spm.spatial.normalise.write.subj.def = y_filepaths;
    matlabbatch{4}.spm.spatial.normalise.write.subj.resample = f_filepaths;
    matlabbatch{4}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                              78 76 85];
    matlabbatch{4}.spm.spatial.normalise.write.woptions.vox = [3 3 3];
    matlabbatch{4}.spm.spatial.normalise.write.woptions.interp = 4;
    matlabbatch{4}.spm.spatial.normalise.write.woptions.prefix = 'w';
    matlabbatch{5}.spm.spatial.normalise.write.subj.def = y_filepaths;
    matlabbatch{5}.spm.spatial.normalise.write.subj.resample = mrs_filepaths;
    matlabbatch{5}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                              78 76 85];
    matlabbatch{5}.spm.spatial.normalise.write.woptions.vox = [1 1 1];
    matlabbatch{5}.spm.spatial.normalise.write.woptions.interp = 4;
    matlabbatch{5}.spm.spatial.normalise.write.woptions.prefix = 'w';
    matlabbatch{6}.spm.spatial.smooth.data(1) = cfg_dep('Normalise: Write: Normalised Images (Subj 1)', substruct('.','val', '{}',{4}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('()',{1}, '.','files'));
    matlabbatch{6}.spm.spatial.smooth.fwhm = [8 8 8];
    matlabbatch{6}.spm.spatial.smooth.dtype = 0;
    matlabbatch{6}.spm.spatial.smooth.im = 0;
    matlabbatch{6}.spm.spatial.smooth.prefix = 's';

    spm_jobman('run',matlabbatch);

end

