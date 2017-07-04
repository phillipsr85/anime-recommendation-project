
import matplotlib
import numpy as np

import pandas as pd
import matplotlib.pyplot as plt
import re
import seaborn as sns


anime = pd.read_csv("C:\\Users\\rpeezy\\Documents\\Big Data Semester 1\\capstone\\anime ratings\\anime.csv")

anime.head()


anime["rating"] = anime["rating"].astype(float)
anime["rating"].fillna(anime["rating"].median(),inplace = True)

#type
pd.get_dummies(anime[["type"]]).head()

#members-convert string to float
anime["members"] = anime["members"].astype(float)

##feature selection
anime_features = pd.concat([anime["genre"].str.get_dummies(sep=","),pd.get_dummies(anime[["type"]]),anime[["rating"]],anime[["members"]],anime["episodes"]],axis=1)

anime["name"] = anime["name"].map(lambda name:re.sub('[^A-Za-z0-9]+', " ", name))

anime_features.head()


anime_features.columns

##in 18
from sklearn.preprocessing import MaxAbsScaler


## Stuck here ValueError: could not convert string to float: 'Unknown'
max_abs_scaler = MaxAbsScaler()
anime_features = max_abs_scaler.fit_transform(anime_features)