dataset = read.csv("/Users/ethanaquino/Desktop/AmesHousing.csv")

library(ggplot2)
library(DataExplorer)
library(ggfortify)
library(car)
library(caret)
library(caTools)
library(dplyr)
library(GGally)

#Cleaning data

plot(x=dataset$Gr.Liv.Area, y=dataset$SalePrice, main="Scatterplot")

plot_missing(dataset, missing_only = TRUE)

dataset = subset(dataset, select = -c(PID))
dataset = subset(dataset, select = -c(Order))

missing_garage =  dataset[is.na(dataset$Garage.Area),]
missing_bsmt = dataset[is.na(dataset$Bsmt.Half.Bath),]

dataset = dataset[-c(2237),]

plot_missing(dataset, missing_only = TRUE)

dataset$BsmtFin.SF.1[is.na(dataset$BsmtFin.SF.1)] = 0
dataset$BsmtFin.SF.2[is.na(dataset$BsmtFin.SF.2)] = 0
dataset$Bsmt.Unf.SF[is.na(dataset$Bsmt.Unf.SF)] = 0
dataset$Total.Bsmt.SF[is.na(dataset$Total.Bsmt.SF)] = 0
dataset$Bsmt.Full.Bath[is.na(dataset$Bsmt.Full.Bath)] = 0
dataset$Bsmt.Half.Bath[is.na(dataset$Bsmt.Half.Bath)] = 0

dataset$Bsmt.Qual[is.na(dataset$Bsmt.Qual)] = "None"
dataset$Bsmt.Cond[is.na(dataset$Bsmt.Cond)] = "None"
dataset$Bsmt.Exposure[is.na(dataset$Bsmt.Exposure)] = "None"
dataset$BsmtFin.Type.1[is.na(dataset$BsmtFin.Type.1)] = "None"
dataset$BsmtFin.Type.2[is.na(dataset$BsmtFin.Type.2)] = "None"

plot_missing(dataset, missing_only = TRUE)

dataset$Mas.Vnr.Area[is.na(dataset$Mas.Vnr.Area)] = 0

plot_missing(dataset, missing_only = TRUE)

dataset$Garage.Yr.Blt[is.na(dataset$Garage.Yr.Blt)] = 0
dataset$Garage.Qual[is.na(dataset$Garage.Qual)] = "None"
dataset$Garage.Cond[is.na(dataset$Garage.Cond)] = "None"
dataset$Garage.Type[is.na(dataset$Garage.Type)] = "None"
dataset$Garage.Finish[is.na(dataset$Garage.Finish)] = "None"

plot_missing(dataset, missing_only = TRUE)

dataset = subset(dataset, select = -c(Pool.QC))
dataset = subset(dataset, select = -c(Misc.Feature))
dataset = subset(dataset, select = -c(Alley))
dataset = subset(dataset, select = -c(Fence))

plot_missing(dataset, missing_only = TRUE)

dataset$Fireplace.Qu[is.na(dataset$Fireplace.Qu)] = "None"

plot_missing(dataset, missing_only = TRUE)

dataset$Lot.Frontage

dataset$Lot.Frontage = ifelse(is.na(dataset$Lot.Frontage),
                     ave(dataset$Lot.Frontage, FUN=function(x) mean(x,na.rm = TRUE)),
                     dataset$Lot.Frontage)

dataset$Lot.Frontage
plot_missing(dataset, missing_only = TRUE)

#Data Visualization

summary(dataset)

numeric = dataset %>% select(where(is.numeric))
ggcorr(numeric)

ggplot(numeric,
       aes(x=Year.Built)) + geom_bar() + 
  labs(title = "Years houses were built", x="Year", y="Number of houses")

ggplot(numeric,
       aes(x=Overall.Qual)) + geom_bar() + 
  labs(title = "House condition", x="Scale 1-10", y="Number of houses")

ggplot(numeric,
       aes(x=Gr.Liv.Area)) + geom_histogram(bins=50, color="blue") + 
  labs(title = "House condition", x="Scale 1-10", y="Number of houses")

ggplot(dataset,
       aes(x=SalePrice)) + geom_histogram(binwidth = 10000, color = "blue") +
       labs(title = "Distribution of house prices", x = "Price", y = "Frequency")

summary(dataset$SalePrice)

plot(x=dataset$Gr.Liv.Area, y=dataset$SalePrice, main="Scatterplot")

dataset[(dataset$Gr.Liv.Area > 4000) & dataset$SalePrice < 400000,]
dataset = dataset[-c(1499, 2181, 2182),]

refined_numeric = numeric %>% select(SalePrice, MS.SubClass, Lot.Area, Overall.Qual, Overall.Cond, Year.Built, Year.Remod.Add, Mas.Vnr.Area, BsmtFin.SF.1, BsmtFin.SF.2, Bsmt.Unf.SF, X1st.Flr.SF, X2nd.Flr.SF, Bedroom.AbvGr, Kitchen.AbvGr, TotRms.AbvGrd, Garage.Yr.Blt, Garage.Area, Screen.Porch)
ggcorr(refined_numeric)

#Model

split = sample.split(Y = numeric$SalePrice,
                     SplitRatio = 0.8)
training_set = subset(numeric, split == TRUE)
test_set = subset(numeric, split == FALSE)

train_control = trainControl(method="repeatedcv", number=10, repeats = 3)
grid = expand.grid(.fL=c(0), .usekernel=c(FALSE))
model = lm(SalePrice ~ ., data=training_set, trControl=train_control, method="nb", tuneGrid=grid)
print(model)

summary(model)
summary(model)$coefficient
sigma(model)/mean(numeric$SalePrice)

y_pred = predict(model, newdata = test_set)
y_pred

avPlots(model)
autoplot(model, which = 1:3, nrow = 3, ncol = 1)


model2 = lm(SalePrice ~ Gr.Liv.Area + MS.SubClass + Lot.Area + Overall.Qual + Overall.Cond + Year.Built + Year.Remod.Add + Mas.Vnr.Area + BsmtFin.SF.1 + BsmtFin.SF.2 + Bsmt.Unf.SF + X1st.Flr.SF + X2nd.Flr.SF + Bedroom.AbvGr + Kitchen.AbvGr + TotRms.AbvGrd + Garage.Yr.Blt + Garage.Area + Screen.Porch, data=training_set, trControl=train_control, method="nb", tuneGrid=grid)

summary(model2)
sigma(model2)/mean(training_set$SalePrice)
y_pred = predict(model2, newdata = test_set)
y_pred

avPlots(model2)
autoplot(model2, which = 1:3, nrow = 3, ncol = 1)

save(model2, file = "/Users/Desktop/HousingProject.rda")


