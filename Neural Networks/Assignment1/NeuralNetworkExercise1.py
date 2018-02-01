import NeuralNetwork as NN
import pandas as pd

NeuralNetwork = NN.NeuralNetwork(2, 2, 1, 'tanh', 'tanh')
full_data = pd.read_csv('sample.csv')
data = full_data.values[:, 0:2]
target = full_data.values[:, 2]

NeuralNetwork.train(data, target, 0.1, 0.01)

for i in range(len(data)):
    print(NeuralNetwork.FeedForward(data[i])[-1])

