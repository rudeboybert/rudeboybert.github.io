# For my final I worked with Allstate Claims severity data

#load packages
library(tidyverse)
library(stringr)
library(broom)
library(glmnet)
library(plotly)

#----load data----
#I have never uploaded files to GitHub before so I hope this works.

# Unzip this train.csv.zip first
train<- read_csv("Files/train.csv")
test<- read_csv("Files/test.csv")
sample_sub <- read_csv("Files/sample_submission.csv")

#to make it run faster I randomly sampled some of the train set
#you can omit this if you want
train <- train %>%
  sample_frac(0.7)

#create dummy var (useful for modeling)
train1 <- train %>%
  mutate(dummy_var = 1)
test <- test %>%
  mutate(dummy_var = 1)


#-----Exploratory Data Analysis ----
#exploratory data analysis
glimpse(train)
#there are 132 variables - 116 categorical and 14 continuous, pluss loss and ID
cont_train<- train %>%
  select(loss, id, contains("cont"))
cat_train <- train %>%
  select(loss, id, contains ("cat"))
logloss<- log(train$loss)
#helpful when looking at boxplots

#some graphs (spoiler alert I picked variables that I learned were important)
ggplot(cont_train, aes(x=cont2, y=loss)) +
  geom_point()
#cont2 is actually discrete and loss seems pos correlated

boxplot(logloss~ cat80, data=cat_train,
        xlab="j", ylab="loss")

boxplot(logloss~ cat12, data = cat_train,
        xlab="j", ylab="loss")

boxplot(logloss~ cat81, data=cat_train,
        xlab="j", ylab="loss")

boxplot(logloss~ cat72, data=cat_train,
        xlab="j", ylab="loss")


#----Final Model CV ----
#After some exhaustive variable exploration (See files in extra), I decided on the below variables

#select variables
train2<- train1 %>%
  select(id,loss, dummy_var, cat1, cont2, cont3, cat7, cat12, cat23, cat36,
         cat57, cat72, cat80,  cat81, cat87, cat100)

#make model
model_formula <- train2 %>%
  # Take all predictor variable names and separate them with + signs:
  names() %>%
  setdiff(c("id", "loss", "dummy_var")) %>%
  stringr::str_c(collapse=" + ") %>%
  # Add outcome variable and ~ sign and convert to formula
  stringr::str_c("dummy_var ~ ", .)
model_formula
model_formula <- as.formula(model_formula)

X <- model.matrix(model_formula, data = train2)[, -1]
y <- train2$loss

lambda_values <- 10^seq(from = 2, to = 4, length = 200)
#BIG CHANGE to ridge regression
model_BIG <- glmnet(X, y, alpha = 0, lambda = lambda_values)

#look at the model
model_BIG %>%
  tidy() %>%
  tbl_df() %>%
  # lambda's on x-axis are better viewed on a log-scale:
  mutate(log_lambda = log(lambda)) %>%
  # We're not interested in the intercept estimate beta_0_hat
  filter(term != "(Intercept)") %>%
  ggplot(aes(x=log_lambda, y=estimate, col=term)) +
  geom_line()
ggplotly()

#cross validate
cvfit <- cv.glmnet(X, y, alpha = 0, lambda=lambda_values, nfolds = 10)

#optimal lambda
cvfit %>%
  glance()
lambda_star <- cvfit %>%
  glance() %>%
  .[["lambda.min"]]
lambda_star


#CV model
#sometimes I got errors on this but if you re-assign the folds and run it again it works fine
# I wish I understood why this happened too
n_folds<- 5
train2 <- train2 %>%
  sample_frac(1) %>%
  mutate(fold = rep(1:n_folds, length=n())) %>%
  arrange(fold)
results<- numeric(length(n_folds))

for(i in 1:n_folds){

  #create folds
  pseudo_train <- train2 %>%
    filter(fold != i)
  pseudo_test <- train2 %>%
    filter(fold == i)

  #pseudo_train model
  model_formula <- pseudo_train %>%
    # Take all predictor variable names and separate them with + signs:
    names() %>%
    setdiff(c("id", "loss", "dummy_var", "fold")) %>%
    stringr::str_c(collapse=" + ") %>%
    # Add outcome variable and ~ sign and convert to formula
    stringr::str_c("dummy_var ~ ", .)
  model_formula
  model_formula <- as.formula(model_formula)

  X <- model.matrix(model_formula, data = pseudo_train)[, -1]
  y <- pseudo_train$loss

  model_BIG <- glmnet(X, y, alpha = 0, lambda = lambda_star)

  #create predictions
  X_new <- model.matrix(model_formula, data = pseudo_test)[, -1]
  predictions <- model_BIG %>%
    predict(newx=X_new, s= lambda_star)
  pseudo_test <-pseudo_test %>%
    mutate(pred = as.vector(predictions))
  results[i]<- sum(abs(pseudo_test$loss-pseudo_test$pred)) / length(pseudo_test$loss)
}

mean(results)
# I get a CV result of 1440.22 (see extras for my comments on this result)

# --- Predictions---
test_X <- model.matrix(model_formula, data = test)[, -1]

predictions <- model_BIG %>%
  predict(newx= test_X, s = lambda_star)

# Write submissions to CSV
sample_sub %>%
  mutate(loss = as.vector(predictions)) %>%
  write_csv("Files/final_submission.csv")
#submitted on 5/16 for a formal score of 1423.3
