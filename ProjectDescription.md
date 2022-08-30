# HousePricePredictionProject

#After, I do some data visualization and exploration, and find which variables are most correlated which I want to use on my model
#I also find outliers which I take out of my data
#I then do multiple linear regression, with a train test split and k-fold validation, and do some plotting to show the accuracy of my model
#backwards elimination
#I also look at my test data to do some predictions

Buisness problem: The problem I will be trying to tackle is predicting the sale price of a house based on various different features. The challenge with this dataset, is the amount of features in a given house, and the fact that not every house has features that another house might have, so there is bound to be missing data. In addition, I will want to finalize my model with the most correlated features of the house to make my model as accurate as I can. 

Plan of attack: In order to tackle this problem, I will first need to clean my dataset, and ensure that there are no missing values by either removing or filling in null values. After, I will visualize my dataset using ggplot and find correlations and trends in the dataset. After concluding this, I will use important features to create a multiple linear regression model and find the highest accuracy model.

Importing libraries: The libraries I used for this project were ggplot2, DataExplorer, ggfortify, car, caret, caTools, dplyr, and GGally. 

Inspecting the dataset: After importing the Ames Housing dataset, I found the dataset to have 2930 different houses, with 81 different features that concluded with a final sale price. I found numerous different features including basement qualities, garage qualities, the amount of land covered by the house, and many more. 

Cleaning the data: Using a feature from DataExplorer, I was able to create a table of all the missing data with the percentage missing for each feature. First, before dealing the missing data, I removed the columns Order and PID, which did not have any effect on the data as they were both specific to each house. After this, I started with the lowest percentage of missing data, which I hoped to be able to fill in. When the feature was numeric, I filled in the null values with a 0, and when the feature was a character, I filled it in with "None". This continued with the lower percentage of missing data, until I got to the higher percentages, with 20% or higher of the data being missing for a specific feature. The features Alley, Fence, Pool.QC, and Misc.Feature were all extremely high, so I decided to remove them from the dataset as they probably would not contribute much to the model. The final two features, Fireplaec and Lot.Frontage, were in the middle with about 20-40% missing data, and I felt that I could not remove them from the dataset. I was able to fill in Fireplace with "None", as it simply dealt with if a house had a fireplace or not. For Lot.Frontage, I was able to take the average of Lot.Frontage and fill out the rest of the null values based off of that. After doing so there were no more missing values in the dataset. 

Visualizing the data: My next step was to visualize the data, and I was able to use the dplyr library to select the numeric features from the dataset. After doing so, I used the GGally library to create a table with the correlations between the features. After viewing this table, I decided to take a further look at some of the features with ggplot, and looked at year built, overall quality, living area, and sale price. I was noticing a correlation between living area and sale price, and I created a scatterplot between the two and found a linear correlation. I also found some extreme outliers in the data, and before moving on to my model, I removed three outliers from my dataset. 

Data preprocessing: Using the numeric values, I split the dataset into a training set and a test set, with an 0.8 split ratio. 

Model and cross validation: Using repeated cross valudation, I created a multiple linear regression model for my training set.

Examining the model: After running my model, I ran a summary of my model to examine it further. I found an 0.86 multiple R squared value, and a RSE of 0.16. The model was working well, and I also ran some predictions and plotted the model compared to the data. I also plotted some extra graphs which showed residuals vs fitted, Normal Q-Q, and a scale-location plot. However I felt as though I could improve my model. 

Backwards elimination: In order to adjust my model, I looked at the summary of my first model and looked at how significant each of the features was. *** meant it was highly significant, so I therefore took all features that were highly significant and eliminated the non significant features. Using my significant features, I created my second model with the same method as my first model, and ran it again. This time, I got an 0.88 multiple R squared value, and a RSE of 0.15. This model was an improvement, and I again ran prediction as well as the same visual plots to understand my model some more.

Final model: My final model was the second multiple linear regression model I created with backwards elimination, which I saved at the end. 
