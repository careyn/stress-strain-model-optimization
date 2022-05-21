import os
import pandas as pd

listings = []

for file in os.listdir(f'{os.getcwd()}/models/'):
    if file.endswith('.csv') or file.endswith('.xlsx'):
        listings.append(file)
        print(file)
    
test = pd.read_csv(f'{os.getcwd()}/models/{listings[0]}', names=['strain1', 'strain2', 'gamme', 'time_0', 'time', 'load'])
test.drop([0,1], inplace=True)

print(test.strain1.array[-1])