#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Feb 14 10:58:04 2022

@author: alblle
"""
import numpy as np

def spectral_reordering(B):
    #B is a correaltion matrix
    
    #add one to make all postive entries
    C=B+1
    
    #compute Q
    Q=-C#init Q
    Q=Q-np.diag(np.diag(Q)) #zeros in diagonal
    tmp=np.sum(Q,axis=0)
    Q=Q-np.diag(tmp)
    
    #compute t
    tmp2=1./np.sqrt(np.sum(C,axis=0))
    t=np.diag(tmp2)
    
    #compute D
    D=np.dot(np.dot(t,Q),t)
    
    #eigevalue decomposition
    D, W=np.linalg.eig(D)
    v=W[:,1]
    
    #scale v
    v2=np.dot(t,v)
    
    #find the searched permutation p
    orderedv2=np.sort(v2)#,order='ascend')
    permutation=np.argsort(v2)
    
    #Reorder B ;)
    orderedB=B[permutation,:]
    orderedB=orderedB[:,permutation]
    
    return orderedB, permutation