# -*- coding: utf-8 -*-
"""
Created on Sat Jun  1 20:23:36 2019

@author: Lara13
"""

#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@author: @olicoli, edited @lartod
"""
import os
import matplotlib.pyplot as plt
import nibabel as nib
#from nilearn.image.resampling import coord_transform
from nilearn import plotting
data_dir = 'C:\Users\Lara13\Desktop\MRI_paper\data_vis';
background_img = 'MNI152_T1_2mm.nii.gz' #whole brain ,
stat_image = 'thresh_zstat1.nii.gz';        
coords = [22,-56,24]  # MNI      
        #cmaps = [jet,'bwr']
anat = os.path.join(data_dir,stat_image)   

display2 = plotting.plot_stat_map(anat, threshold = 0, black_bg=True, colorbar=True,draw_cross=False, cut_coords=coords, annotate=True)
display2.add_contours(anat, levels=[0.1], colors='black', alpha=1, linewidths=2.)    
display2.savefig(os.path.join(data_dir, 'congruency.pdf')) # group figure    
       