library(stargazer)

rpgData<-read.csv(file.choose(), header=TRUE)

linModel<-lm(rpgR~rpgD+user+con+amsale+amR+anime+gdp+gdpperson+mobile, rpgData)
summary(linModel)
summary(linModel, robust=T)

library(stargazer)
stargazer(as.data.frame(rpgData), type="latex")

# Regression Results
stargazer(linModel, type="html", title="Table 3. Regression Results", report = "vcsp*", notes="",out="MyTable2.htm")

plot(rpgR~rpgD+user+con+amsale+amR+anime+gdp+gdpperson+mobile, rpgData)
abline(linModel)


# Scatterplot Matrix
pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
      main = "Scatterplot Matrix")


rpgData<-read.csv(file.choose(), header=TRUE)

# function to add correlation
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...) { 
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- cor(x, y)
  txt <- format(c(r, 0.123456789), digits=digits)[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.cor * abs(r))
}

# scatterplot matrix with custom panel function
scatterplotMatrix<-pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
      main = "Variable Scatterplot Matrix (graphing)",
      lower.panel = panel.cor, # lower.panel = correlation coefficients
      upper.panel = panel.smooth) # upper.panel = panel.smooth to add a loess smoothed line



# function for the lower panel to display r-squared and p-values
panel.rsquared.pvalue <- function(x, y, digits = 4, prefix="", cex.txt = , ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  r <- cor(x, y)
  r2 <- r^2
  test <- cor.test(x, y)
  p <- test$p.value
  txt<-format(c("R^2 = ", format(r2, digits = digits), "\np = ", format(p, digits = digits)))[1]
  txt <- paste0(prefix, txt)
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.5, txt, cex = 0.5 * cex.cor * abs(r))
}

# scatterplot matrix with the r^ and p-value
scatterplotMatrix <- pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
                           main = "Scatterplot Matrix (R-squared, and P-values)",
                           lower.panel = panel.cor,
                           upper.panel = panel.rsquared.pvalue)





# Install the package if you haven't already
install.packages("scatterplot3d")

# Load the package
library(scatterplot3d)

# Create a 3D scatter plot
scatterplot3d(rpgData$amR, rpgData$rpgR, rpgData$rpgD, main="3D Scatterplot", 
              xlab="Anime Revenue", ylab="RPG Revenue", zlab="RPG Download")

# Create a 3D scatter plot
scatterplot3d(rpgData$acon, rpgData$rpgR, rpgData$rpgD, main="3D Scatterplot", 
              xlab="Anime/Manga Conventions", ylab="RPG Revenue", zlab="RPG Download")

linModel_rpgR_1<-lm(rpgR~user+con+amsale+amR+anime+gdp+gdpperson+mobile, rpgData)
summary(linModel_rpgR_1)

linModel_rpgD_1<-lm(rpgD~user+con+amsale+amR+anime+gdp+gdpperson+mobile, rpgData)
summary(linModel_rpgD_1)


library(plm)
# Assuming your data frame is named 'data'
# Convert the data frame to a pdata.frame with country and time indexes
pdata <- pdata.frame(rpgData, index = c("country", "year"))


# Suppose `data` is your data frame with 'country' and 'continent' columns

# First, load the necessary libraries
library(dplyr)

# Then group by continent and summarize the countries
continent_countries <- rpgData %>%
  group_by(continent) %>%
  summarize(Countries = toString(unique(country)))

# Print the results
print(continent_countries)


# Load the necessary library
library(knitr)
library(kableExtra)

# Assuming 'continent_countries' is your data frame with the columns 'continent' and 'Countries'
# Print the results as an HTML table
html_table <- kable(continent_countries, format = "html", table.attr = "style='width:100%'") %>% 
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"))

# Display the HTML table
html_table












