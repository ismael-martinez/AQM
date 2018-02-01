#Author: Ismael Martinez

import numpy as np
from sklearn import datasets

#import Boston dataset
bostonData = datasets.load_boston()

#learning rate alpha
alpha = 0.001
eps = 0.1
betaLength = bostonData.data.shape[1]

#Set parameters
beta = np.random.rand(betaLength)
lambda_1 = 0.01
lambda_2 = 10
X = bostonData.data
y = bostonData.target

#Proximal Gradient Descent
import ProximalGradientDescent as pgd
beta_s = pgd.proximalGradientDescent(beta, lambda_1, lambda_2, X, y, alpha, eps)
print(beta_s)

#Subgradient Descent
import SubgradientDescent as sg
beta_g = sg.subGradientDescent(beta, lambda_1, lambda_2, X, y, alpha, eps)
print(beta_g)
