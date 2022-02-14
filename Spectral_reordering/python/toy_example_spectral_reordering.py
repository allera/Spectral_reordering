#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 14 11:02:54 2022

@author: alblle
"""

from spectral_reordering import spectral_reordering
import numpy as np
import matplotlib.pyplot as plt

#$generate data
    
#%I generate timeseries (N voxels, t timesteps)
N=20 #% even!, corr matrix of size NxN
t=100 #% time samples

#%all voxels are dependent in two signals
signal1=np.random.normal(0,1,t)
signal2=np.random.normal(0,1,t)

#%half of voxels dependent on each of the two signals
#% and lambda is the dependence factor.
m= int(N/2)
lambd = 0.8

# #%I put data in x
data=np.zeros([int(N),t])

for i in range(m):
    if i==0:
        data[0,:]=signal1
    else:
        data[i,:]= ((1-lambd)* np.random.normal(0,1,t)) + (lambd *signal1)
   
for i in range(m):
    if i==0:
        data[m+i,:]=signal2
    else:
        data[m+i,:]= ((1-lambd)* np.random.normal(0,1,t)) + (lambd *signal2)
   

rand_perm=np.random.permutation(N)
mixed_data=data[rand_perm,:]
# %compute correlation
corrMatrix=np.corrcoef(data)
rand_perm_corrMatrix=np.corrcoef(mixed_data)
ordered_corrMatrix, permutation = spectral_reordering(corrMatrix)
# %Make a plot
fig, axs = plt.subplots(nrows=1,ncols=3)
axs[0].imshow(corrMatrix)
axs[0].set_title('Original')
axs[1].imshow(rand_perm_corrMatrix)
axs[1].set_title('Mixed')
axs[2].imshow(ordered_corrMatrix)
axs[2].set_title('Reordered')
plt.show()