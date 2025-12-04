
library(stargazer)
# Convert the data frame to a pdata.frame object
ndata <- pdata.frame(rpgData, index = c("country", "year"))


model_1_1<-lm(rpgR~0+user + con + amsale + amR + anime + gdp + 
            gdpperson + mobile + country + year, pdata)
summary(model_1_1)

model_1_2<-lm(rpgD~0+user + con + amsale + amR + anime + gdp + 
                gdpperson + mobile + country + year, pdata)
summary(model_1_2)



model_2_1<-lm(rpgR~0+user + con + amsale + amR + exp(anime) + gdp + 
                gdpperson + mobile + country + year, pdata)
summary(model_2_1)


model_2_2<-lm(rpgD~0+user + exp(con) + amsale + amR + anime + gdp + 
                gdpperson + mobile + country + year, pdata)
summary(model_2_2)

stargazer(model_1_1, model_2_1, model_1_2, model_2_2, type = "latex",
          title="Linear and Exponential Regression Results", 
          covariate.labels = c("Active Mobile Users (Mn people)", "Anime/Manga Conventions (unit)", "exp(anime/manga conventions)", "Anime/Manga Sales (Th)",
                               "Anime/Manga Revenue (Mn USD)", "exp(anime accessibility)", "Anime Accessibility (unit)", "GDP (Bn USD)", 
                               "GDP per Captia (USD)", "Mobile Cellular (Mn subscriptions)", "Country", "Year"),
          dep.var.labels = c("RPG Revenue (Mn USD)", "RPG Download (Mn)"),
          column.labels = c("Model 1.1", "Model 2.1", "Model 1.2", "Model 2.2"),
          column.separate = c(1,1),
          omit = c("country", "year"), # Exclude the country and year if they are dummy variables for fixed effects
          star.cutoffs = c(0.05, 0.01, 0.001), # Significance levels
          digits = 4, # Number of digits to show
          intercept.bottom = FALSE,
          add.lines = list(c("Entity Fixed Effects", "Yes", "Yes", "Yes", "Yes"),
                           c("Time Fixed Effects", "Yes", "Yes", "Yes", "Yes")),
          notes.align = "r",
          notes = "Statistically Significance Levels: * 90%, ** 95%, *** 99%",
          notes.label = "Notes:")# Show intercept at the top (though your models do not have an intercept))



library(coefplot)

# Omitting dummy variables for country and year
# You would need to know the exact names of these dummy variables in your model.
# Let's assume they are named as country1, country2, ..., year1, year2, ...
# and you want to exclude them.
coefs_1<-coef(summary(model_2_1))
dummy_vars_1 <- grepl("country|year", rownames(coefs_1))
coefs_to_plot_1 <- coefs_1[!dummy_vars_1, ]

# Now plot using coefplot but with selected coefficients
coefplot(model_2_1, coefficients = rownames(coefs_to_plot_1), title = "Coefficients for Model 2.1 RPG Revenue with Exponential Anime Accessibility")

# For model_2_1
coefplot(model_2_1, title = "Coefficients for model_2_1")

# For model_2_2
coefplot(model_2_2, title = "Coefficients for model_2_2")





# Diagnostic plots for model_2_1
par(mfrow = c(2, 2))
plot(model_2_1)

# Resetting plot area
par(mfrow = c(1, 1))

# Diagnostic plots for model_2_2
par(mfrow = c(2, 2))
plot(model_2_2)

# Resetting plot area
par(mfrow = c(1, 1))



# Predicted vs. Actual for model_2_1
pdata$predicted_rpgR <- predict(model_2_1)
plot(pdata$rpgR, pdata$predicted_rpgR, main = "Predicted vs Actual for model_2_1", xlab = "Actual", ylab = "Predicted")
abline(0, 1)

# Predicted vs. Actual for model_2_2
pdata$predicted_rpgD <- predict(model_2_2)
plot(pdata$rpgD, pdata$predicted_rpgD, main = "Predicted vs Actual for model_2_2", xlab = "Actual", ylab = "Predicted")
abline(0, 1)





# Get the summaries
summary_2_1 <- summary(model_2_1)
summary_2_2 <- summary(model_2_2)

summary_2_1
summary_2_2


library(stargazer)

library(lmtest)
library(sandwich)

# Calculate robust standard errors
robust_se_model_2_1 <- coeftest(model_2_1, vcov.=vcovHC(model_2_1, type="HC1"))
robust_se_model_2_2 <- coeftest(model_2_2, vcov.=vcovHC(model_2_2, type="HC1"))

stargazer(model_1_1, model_1_2, type = "latex",
          title="Table 3. Linear Regression Results", 
          out="MyTable3.6.htm",
          covariate.labels = c("Active Mobile Users (Mn people)", "Anime/Manga Conventions (unit)", "Anime/Manga Sales (Th)",
                               "Anime/Manga Revenue (Mn USD)", "Anime Accessibility (unit)", "GDP (Bn USD)", 
                               "GDP per Captia (USD)", "Mobile Cellular (Mn subscriptions)",  "Country", "Year"),
          column.labels = c("Model 1.1", "Model 1.2"),
          column.separate = c(1,1),
          omit = c("country", "year"), # Exclude the country and year if they are dummy variables for fixed effects
          star.cutoffs = c(0.05, 0.01, 0.001), # Significance levels
          digits = 4, # Number of digits to show
          intercept.bottom = FALSE,
          add.lines = list(c("Entity Fixed Effects", "Yes", "Yes"),
                           c("Time Fixed Effects", "Yes", "Yes")),
          notes.align = "r",
          notes = "Statistically Significance Levels: * 90%, ** 95%, *** 99%",
          notes.label = "Notes:")# Show intercept at the top (though your models do not have an intercept))

stargazer(model_2_1, model_2_2, type = "latex",
          title="Table 4. Exponential Regression Results", 
          out="MyTable3.5.htm",
          covariate.labels = c("Active Mobile Users (Mn people)", "Anime/Manga Conventions (unit)", "exp(anime/manga conventions)", "Anime/Manga Sales (Th)",
                               "Anime/Manga Revenue (Mn USD)", "exp(anime accessibility)", "Anime Accessibility (unit)", "GDP (Bn USD)", 
                               "GDP per Captia (USD)", "Mobile Cellular (Mn subscriptions)", "Country", "Year"),
          dep.var.labels = c("RPG Revenue (Mn USD)", "RPG Download (Mn)"),
          column.labels = c("Model 2.1", "Model 2.2"),
          column.separate = c(1,1),
          omit = c("country", "year"), # Exclude the country and year if they are dummy variables for fixed effects
          star.cutoffs = c(0.05, 0.01, 0.001), # Significance levels
          digits = 4, # Number of digits to show
          intercept.bottom = FALSE,
          add.lines = list(c("Entity Fixed Effects", "Yes", "Yes"),
                           c("Time Fixed Effects", "Yes", "Yes")),
          notes.align = "r",
          notes = "Statistically Significance Levels: * 90%, ** 95%, *** 99%",
          notes.label = "Notes:")# Show intercept at the top (though your models do not have an intercept))

stargazer(model_1_1, model_2_1, model_1_2, model_2_2, type = "latex",
          title="Linear and Exponential Regression Results", 
          out="MyTable3.5.htm",
          covariate.labels = c("Active Mobile Users (Mn people)", "Anime/Manga Conventions (unit)", "exp(anime/manga conventions)", "Anime/Manga Sales (Th)",
                               "Anime/Manga Revenue (Mn USD)", "exp(anime accessibility)", "Anime Accessibility (unit)", "GDP (Bn USD)", 
                               "GDP per Captia (USD)", "Mobile Cellular (Mn subscriptions)", "Country", "Year"),
          dep.var.labels = c("RPG Revenue (Mn USD)", "rpgR", "RPG Download (Mn)", "rpgD"),
          column.labels = c("Model 1.1", "Model 2.1", "Model 1.2", "Model 2.2"),
          column.separate = c(1,1),
          omit = c("country", "year"), # Exclude the country and year if they are dummy variables for fixed effects
          star.cutoffs = c(0.05, 0.01, 0.001), # Significance levels
          digits = 4, # Number of digits to show
          intercept.bottom = FALSE,
          add.lines = list(c("Entity Fixed Effects", "Yes", "Yes", "Yes", "Yes"),
                           c("Time Fixed Effects", "Yes", "Yes", "Yes", "Yes")),
          notes.align = "r",
          notes = "Statistically Significance Levels: * 90%, ** 95%, *** 99%",
          notes.label = "Notes:")# Show intercept at the top (though your models do not have an intercept))





stargazer(model_2_1, model_2_2, type = "latex",
          title="Table 5. Exponential Regression Comparison with Confidence Intervals", 
          out="MyTable3.4.htm",
          covariate.labels = c("Active Mobile Users (Mn people)", "Anime/Manga Conventions (unit)", "exp(anime/manga conventions)", "Anime/Manga Sales (Th)",
                               "Anime/Manga Revenue (Mn USD)", "exp(anime accessibility)", "Anime Accessibility (unit)", "GDP (Bn USD)", 
                               "GDP per Captia (USD)", "Mobile Cellular (Mn subscriptions)", "Country", "Year"),
          dep.var.labels = c("RPG Revenue (Mn USD)", "RPG Download (Mn)"),
          column.labels = c("Model 2.1", "Model 2.2"),
          column.separate = c(1,1),
          omit = c("country", "year"), # Exclude the country and year if they are dummy variables for fixed effects
          star.cutoffs = c(0.05, 0.01, 0.001), # Significance levels
          digits = 4, # Number of digits to show
          intercept.bottom = FALSE,
          add.lines = list(c("Entity Fixed Effects", "Yes", "Yes"),
                           c("Time Fixed Effects", "Yes", "Yes")),
          ci=TRUE,
          ci.level = 0.95,
          keep.stat = "rsq",
          notes.align = "r",
          notes = "Confidence Interval Level = 0.95",
          notes.label = "Notes:")# Show intercept at the top (though your models do not have an intercept))




residuals_2_1 <- residuals(model_2_1)
residuals_2_2 <- residuals(model_2_2)

pdata$fit_2_1 <- fitted(model_2_1)
pdata$fit_2_2 <- fitted(model_2_2)
pdata$resid_2_1 <- residuals_2_1
pdata$resid_2_2 <- residuals_2_2

library(ggplot2)

ggplot(pdata, aes(x = fit_2_1, y = resid_2_1, color = year)) +
  geom_point() +
  labs(title = "Figure 7. Model 2.1: Residuals vs Fitted by Year",
       x = "Fitted Values",
       y = "Residuals") +
  theme_minimal()

# Repeat for Model 2.2
ggplot(pdata, aes(x = fit_2_2, y = resid_2_2, color = continent)) +
  geom_point() +
  labs(title = "Figure 8. Model 2.2: Residuals vs Fitted by Continent",
       x = "Fitted Values",
       y = "Residuals") +
  theme_minimal()


coef_2_1 <- coef(model_2_1)
coef_2_2 <- coef(model_2_2)

# Create a data frame with the coefficients and country names
# Assume that the country coefficients are the last ones in your model
country_coefs <- data.frame(
  country = rownames(coef_2_1)[tail(seq_along(coef_2_1), n = length(unique(pdata$country)))],
  coef_2_1 = tail(coef_2_1, n = length(unique(pdata$country))),
  coef_2_2 = tail(coef_2_2, n = length(unique(pdata$country)))
)

ggplot(country_coefs, aes(x = country)) +
  geom_point(aes(y = coef_2_1, color = "Model 2.1")) +
  geom_point(aes(y = coef_2_2, color = "Model 2.2")) +
  labs(title = "Country Coefficients in Models 2.1 and 2.2",
       y = "Coefficient Estimate") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))


library(ggplot2)

# Assuming pdata is your data frame and model_2_1 is already fitted with pdata.
pdata$fitted_2_1 <- fitted(model_2_1)
pdata$fitted_2_2 <- fitted(model_2_2)

ggplot(pdata, aes(x = fitted_2_1, y = rpgR, color = year)) +
  geom_point() +
  labs(title = "Scatter plot of RPG Revenue by Year",
       x = "Fitted Values from Model 2.1",
       y = "RPG Revenue (rpgR)") +
  scale_color_discrete(name = "Year") +
  theme_minimal()

ggplot(pdata, aes(x = fitted_2_2, y = rpgR, color = year)) +
  geom_point() +
  labs(title = "Scatter plot of RPG Revenue by Year",
       x = "Fitted Values from Model 2.2",
       y = "RPG Download (rpgR)") +
  scale_color_discrete(name = "Year") +
  theme_minimal()



# Load necessary packages
library(ggplot2)


ggplot(pdata, aes(x = as.factor(year), y = rpgR, fill = continent)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(title= "RPG Revenue vs Year Histogram by Continent",
    x = "Year", y = "RPG Revenue (Mn USD)", fill = "Continent") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # This rotates the x-axis labels for better readability


ggplot(pdata, aes(x = as.factor(year), y = rpgD, fill = continent)) +
  geom_bar(stat = "identity", position = "stack") +
  theme_minimal() +
  labs(title= "RPG Download vs Year Histogram by Continent",
       x = "Year", y = "RPG Download (Mn)", fill = "Continent") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # This rotates the x-axis labels for better readability


# Assuming you've already fitted the model, e.g., model_2_1
# Install the 'car' package if not already installed
install.packages("car")

# Load the 'car' package
library(car)

# Calculate VIF values
vif_values <- vif(model_2_1)

# Show the VIF values
print(vif_values)


# Calculate the correlation matrix for the predictors
predictors <- pdata[, c("con", "amsale", "amR", "anime")]
cor_matrix <- cor(predictors, use = "complete.obs") # Handling missing values if any

# Print the correlation matrix
print(cor_matrix)

# Install the 'corrplot' package if not already installed
install.packages("corrplot")

# Load the 'corrplot' package
library(corrplot)

# Plot the correlation matrix
# Assuming you have already calculated the correlation matrix and stored it in 'cor_matrix'
# And the corrplot library has been loaded using library(corrplot)

# First plot the circles
corrplot(cor_matrix, method = "circle", addCoef.col="grey", tl.srt=0, type= "lower")

# Then overlay the numbers on top
corrplot(cor_matrix, method = "number", add = TRUE)

# Assuming 'your_data_frame' is your data frame and corrplot library is already loaded
corrplot(cor_matrix, method="circle", type="lower", 
         addgrid.col = NA, tl.col="black", tl.srt=0, 
         cl.pos='n', cl.cex=2, cl.ratio=0.1, 
         addCoef.col="grey",  # Specify color for the correlation coefficients
         addCoefasPercent=FALSE,
         number.cex=1.2)  # Control the font size of the numbers
mtext("Multicollinearity Observation", side=3, line=2, at=2, adj=-0.1, cex=1.5)





