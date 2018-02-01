#Author: Ismael Martinez

import numpy as np
from sklearn import datasets
from joblib import Parallel, delayed

#Function S(x, lambda)
#Purpose: Calculate the S_lambda function
#In: x (np array) lambda (scalr)
#Out: S (np array size 2)
def S(beta, lambda_constant):
    if lambda_constant < 0:
        lambda_constant = -lambda_constant
    if beta > lambda_constant:
        S_beta = beta - lambda_constant
    elif beta >= -lambda_constant and beta <= lambda_constant:
        S_beta = 0
    else: #beta > lambda_constant
            S_beta = beta + lambda_constant
    return S_beta

#Function J(beta, lambda_1, lambda_2, X, y)
#Purpose: Given a parameter vector beta and constants lambda_1 and lambda_2, calculate the objective function
#In: beta (np array), lambda_1 (constant), lambda_2 (constant), X (np 2D array), y (np array)
#Out: J (scalar)
def J(beta, lambda_1, lambda_2, X, y):
    #Calculate function pieces
    c = 1./(1 + lambda_2)
    var_row = np.var(X, axis=1) #var of each row i
    I = np.identity(var_row.shape[0])
    W = np.multiply(1./var_row, I)
    X_T = np.transpose(X)
    A = np.matmul(X_T, np.matmul(W, X))*c
    # Calculate J
    J = np.matmul(np.matmul(beta, A), beta)
    J -= 2*np.matmul(np.matmul(y, np.matmul(W, X)), beta)
    #J += lambda_1 * np.linalg.norm(beta, 1)

    return J

#Function dJ(beta, lambda_1, lambda_2, X, y)
#Purpose: Given a parameter vector beta and constants lambda_1 and lambda_2, calculate the derivative of the obj function
#In: beta (np array), lambda_1 (constant), lambda_2 (constant), X (np 2D array), y (np array)
#Out: dJ (scalar)
def dJ(beta, lambda_2, X, y):
    #Calculate function pieces
    c = 1./(1 + lambda_2)
    var_row = np.var(X, axis=1) #var of each row i
    I = np.identity(var_row.shape[0])
    W = np.multiply(1./var_row, I)
    X_T = np.transpose(X)
    A = np.matmul(X_T, np.matmul(W, X))*c
    #Calculate dJ
    dJ = np.transpose(A) + A
    dJ = np.matmul(beta, dJ)
    dJ -= 2*np.matmul(y, np.matmul(W, X))
    return dJ

#Function proximalGradientDescent
#Purpose: Run the Proximal GD algorithm until we reach a certain threshold eps
#In: beta (np array), lambda_1 (scalar), lambda_2 (scalar), X (np 2D array), y (np array), alpha (scalar), eps (scalar)
#Out: beta* (np array)
def proximalGradientDescent(beta, lambda_1, lambda_2, X, y, alpha, eps):
    i = 1
    while(True):
        prev_beta = beta
        pJ = dJ(prev_beta, lambda_2, X, y)
        beta_pJ = prev_beta + alpha * pJ
        beta = Parallel(n_jobs=2)(delayed(S)(beta_pJ[i], lambda_1) for i in range(10))
        print(beta)
        if all(abs(beta - prev_beta) < eps):
            break
    return beta #beta*

#import Boston dataset
bostonData = datasets.load_boston()

#learning rate alpha
alpha = 0.01
eps = 0.1
betaLength = bostonData.data.shape[1]

#Set parameters
beta = np.random.rand(betaLength)
lambda_1 = 5
lambda_2 = 50
X = bostonData.data
y = bostonData.target

#Proximal Gradient Descent
import ProximalGradientDescent as pgd
beta_s = pgd.proximalGradientDescent(beta, lambda_1, lambda_2, X, y, alpha, eps)
print(beta_s)
