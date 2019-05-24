%% first 4D functional ones
clear all; close all; clc; 
cur_dir =   '/home/predatt/lartod/fMRI/FaceGender/DATA/FSL_analysis/data';
cd(cur_dir)
subjects = {'SUB06', 'SUB08', 'SUB11', 'SUB20', 'SUB21', 'SUB22'}; 
runs = {'RUN1','RUN2','RUN3','RUN4','RUN5','RUN6','RUN7','RUN8','RUN9',...
    'RUN10','RUN11','RUN12'};

for i = 2:size(subjects,2)
    for j = 1:size(runs, 2)
        cur_subj = fullfile(cur_dir, subjects{i}, 'func', runs{j});        
        cd(cur_subj)
        %4d it
        !fslmerge -t func f*.nii
        !gunzip func.nii.gz
        %remove series of .niiś
        delete(cur_subj, 'f1*.nii')
    end
end

%% reorient functionals    
for subj = 1:size(subjects,2)
    for run = 1:size(runs,2)
        cur_func = fullfile(subj_path, subjects{subj},'func', runs{run},'func.nii');
        func_reor = fullfile(subj_path, subjects{subj},'func', runs{run},'func_reor.nii');
        func_reor_GZ = fullfile(subj_path, subjects{subj},'func',runs{run}, 'func_reor.nii.gz');

        %take func>reorient
        [s, w] = unix(['fslreorient2std ' cur_func ' ' func_reor]);
        [s, w] = unix(['gunzip ' func_reor_GZ]);
        %!gunzip func_reor.nii.gz

        %change the TR (from 1 to 1.76)
        %!fslmerge -tr func_reor.nii func_reor.nii 1.76
        [s,w] = unix(['fslmerge ' ' ' '-tr' ' ' func_reor ' ' func_reor ' ' '1.76']);
        %!gunzip func_reor.nii.gz 
        %delete .nii.gz
        delete(func_reor);
        [s, w] = unix(['gunzip ' func_reor_GZ]);
    end
end

%% reorient structurals
struct_path =     '/home/predatt/lartod/fMRI/FaceGender/DATA/FSL_analysis/data/';

for subj = 1:size(subjects,2)
    cur_struct = fullfile(struct_path,subjects{subj}, 'struct','s*.nii');
    struct_reor = fullfile(struct_path,subjects{subj}, 'struct','s_reor.nii');
    struct_reor_BET = fullfile(struct_path,subjects{subj}, 'struct','s_reor_BET.nii');
    struct_reor_BET_GZ = fullfile(struct_path,subjects{subj}, 'struct','s_reor_BET.nii.gz');
    
    [s, w] = unix(['fslreorient2std  ' cur_struct ' ' struct_reor]);
    %BET
    [s, w] = unix(['bet ' struct_reor ' ' struct_reor_BET ' ' '-R']);
    [s, w] = unix(['gunzip ' struct_reor_BET_GZ]);
end