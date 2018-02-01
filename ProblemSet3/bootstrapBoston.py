#Author: Ismael Martinez

import numpy as np
from sklearn import datasets
from joblib import Parallel, delayed

def bootstrapSample(data, size):
    idx = int(np.floor(np.random.rand()*size))
    element = data[idx]
    return element

def main():
    #import Boston dataset
    bostonData = datasets.load_boston()

    #Take a bootstrap sample
    size = bostonData.data.shape[0]
    bootstrapData = Parallel(n_jobs=2)(delayed(bootstrapSample)(bostonData.data, size) for i in range(size))
    variance = np.var(bootstrapData, axis=0) #Variance
    std = np.sqrt(variance)
    print(std)

if __name__ == "__main__":
    main()