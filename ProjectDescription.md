# HousePricePredictionProject

#First I deal with the missing data
#After, I do some data visualization and exploration, and find which variables are most correlated which I want to use on my model
#I also find outliers which I take out of my data
#I then do multiple linear regression, with a train test split and k-fold validation, and do some plotting to show the accuracy of my model
#backwards elimination
#I also look at my test data to do some predictions

Buisness problem: The problem I will be trying to tackle is predicting the sale price of a house based on various different features. The challenge with this dataset, is the amount of features in a given house, and the fact that not every house has features that another house might have, so there is bound to be missing data. In addition, I will want to finalize my model with the most correlated features of the house to make my model as accurate as I can. 

Plan of attack: In order to tackle this problem, I will first need to clean my dataset, and ensure that there are no missing values by either removing or filling in null values. After, I will visualize my dataset using ggplot and find correlations and trends in the dataset. After concluding this, I will use important features to create a multiple linear regression model and find the highest accuracy model.

Importing libraries: The libraries I used for this project were ggplot2, DataExplorer, ggfortify, car, caret, caTools, dplyr, and GGally. 

Inspecting the dataset: After importing the Ames Housing dataset, I found the dataset to have 2930 different houses, with 81 different features that concluded with a final sale price. I found numerous different features including basement qualities, garage qualities, the amount of land covered by the house, and many more. 

Cleaning the data:

Visualizing the data:

Data preprocessing:

Model and cross validation:

Examining the model:

Backwards elimination:

Final model:
