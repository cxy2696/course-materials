
library(ggplot2)

rpgData<-read.csv(file.choose(), header=TRUE)

# Scatterplot Matrix
pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
      main = "Scatterplot Matrix")

# when run the function, put mouse at the star of "function"
# function to add correlation
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...) { 
  usr <- par("usr"); on.exit(par(usr)) # current user coordinates and restore upon exit
  par(usr = c(0, 1, 0, 1)) # consistent text size
  r <- cor(x, y) # correlation coefficient
  txt <- format(c(r, 0.123456789), digits=digits)[1] # add correlation coefficient
  cex.cor <- 0.8/strwidth(txt) # text size to display
  txt <- paste0(prefix, txt) # add prefix, for this is nothing
  text(0.5, 0.5, txt, cex = cex.cor * abs(r)) # place text at the center, adjust the size proportional to its value
                                                  # larger for stronger correlation
}

# scatterplot matrix with custom panel function
Matri_1x<-pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
                         main = "Variable Matrix (graphing)",
                         lower.panel = panel.cor, # lower.panel = correlation coefficients
                         upper.panel = panel.smooth) # upper.panel = panel.smooth to add a line



# function for the lower panel to display r-squared and p-values
panel.rsquared.pvalue <- function(x, y, digits = 4, prefix = "", cex.txt = 1, ...) {
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  test <- cor.test(x, y)
  r2 <- test$estimate^2
  p <- test$p.value
  txt <- paste0("R^2 = ", format(r2, digits=digits), "\np = ", format(p, digits=digits))
  txt <- paste0(prefix, txt)
  cex.txt <- 0.8 / strwidth(txt)
  text(0.5, 0.5, txt, cex = cex.txt)
}



# scatterplot matrix with the r^ and p-value
Matrix_2 <- pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
                           main = "Varibale Matrix (R-squared, and P-values)",
                           lower.panel = panel.cor,
                           upper.panel = panel.rsquared.pvalue)

# scatterplot matrix with custom panel function
Matri_1x<-pairs(~ rpgR + rpgD + user + con + amsale + amR + anime + gdp + gdpperson + mobile, data = rpgData,
                main = "Variable Matrix",
                lower.panel = panel.rsquared.pvalue, # lower.panel = correlation coefficients
                upper.panel = panel.smooth) # upper.panel = panel.smooth to add a line

