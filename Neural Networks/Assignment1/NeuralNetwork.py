import numpy as np
import activation as act


class NeuralNetwork:
    #In: n_inputs (pos integer), n_hidden (pos integer), n_outputs (pos integer)
    def __init__(self, n_inputs, n_hidden, n_outputs, hidAct = 'sigmoid', outAct = 'sigmoid'):
        self.inputToHiddenWeights = np.random.rand(n_hidden, n_inputs)
        self.inputBias = np.random.rand(n_hidden)
        self.hiddenToOutputWeights = np.random.rand(n_outputs, n_hidden)
        self.hiddenBias = np.random.rand(n_outputs)
        self.hidAct = hidAct
        self.outAct = outAct

    #Purpose: For a single row of data, calculate the output of one feed forward pass
    #In: data (np array)
    def FeedForward(self, data):
        z2 = self.inputToHiddenWeights.dot(data) + self.inputBias
        a2 = act.activation(self.hidAct, z2)
        z3 = self.hiddenToOutputWeights.dot(a2) + self.hiddenBias
        a3 = act.activation(self.outAct, z3)
        out = 0.5
        if a3 < 0.5:
            out = -0.5
        return np.array([a3, z3, a2, z2, data, out])

    #Purpose: For a single row of data, calculate the derivatives
    def BackPropogation(self, data, target):
        #Cost is MSE
        out = self.FeedForward(data)
        [a3, z3, a2, z2, a1, y_hat] = out

        delta3 = (y_hat - target)*act.deriv(self.outAct, z3)
        delta2 = np.transpose(self.hiddenToOutputWeights).dot(delta3) * act.deriv(self.outAct, z2)

        dW3 = a2*delta3
        db3 = delta3
        dW2 = np.transpose(a1).dot(delta2)
        db2 = delta2
        return [dW2, db2, dW3, db3]

    #Purpose: For a given Neural Network with a dataset, train the network with SGD
    #In: data (2D np array) target (np array) alpha (float learning rate) eps (float)
    def train(self, data, target, alpha, eps):
        W_now = self.inputToHiddenWeights
        W_next = W_now + 1
        while np.abs((W_next - W_now).sum()) > eps:
            for i in range(data.shape[0]):
                W_now = self.inputToHiddenWeights
                [dW2, db2, dW3, db3] = self.BackPropogation(data[i], target[i])
                self.inputToHiddenWeights -= alpha*dW2
                self.hiddenToOutputWeights -= alpha*dW3
                self.inputBias -= alpha*db2
                self.hiddenBias -= alpha*db3
                W_next = self.inputToHiddenWeights

        return [self.inputToHiddenWeights, self.hiddenToOutputWeights]


