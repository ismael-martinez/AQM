import numpy as np
import math

def sigmoid(x):
    return 1 / (1 + math.exp(-x))


def relu(x):
    if x < 0:
        return 0
    else:
        return x


def tanh(x):
    return np.tanh(x)


# Purpose: Define the activation function used by an activation node
# In: ActivationType (string), x (float)
def activation(activationType, x):
    if activationType == 'sigmoid':
        return sigmoid(x)
    elif activationType == 'relu':
        return relu(x)
    elif activationType == 'tanh':
        return tanh(x)
    else:
        return "%s not an activation type" % activationType

def deriv(activationType, x):
    if activationType == 'sigmoid':
        return sigmoid(x)*(1 - sigmoid(x))
    elif activationType == 'tanh':
        return tanh(x)**2
