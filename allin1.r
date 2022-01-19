library(PerformanceAnalytics)
library(quantmod)
library(stats)
library(xts)

df <- read.csv(file='/Users/angal/OneDrive/Documents/la/all.csv')

tar_and_ind=c('VOO','AAPL', 'AMZN', 'BRK-B', 'FB', 'GOOG', 'GOOGL', 'JNJ', 'JPM', 'MSFT', 'NVDA', 'TSLA')

#calculate return of asset
dfx = xts(df$VOO, order.by=as.Date(df$Date))
re <- Return.calculate(dfx, method = c("discrete", "log"))
rea= Return.annualized(re, scale = 252, geometric = TRUE)
colnames(re) <- 'VOO'
colnames(rea) <- 'VOO'
head(re)
head(rea)

symbols=c('AAPL', 'AMZN', 'BRK-B', 'FB','GOOG')

#calculate the returns of multiple indexes
for(i in 1:length(symbols)) {
  sym <- getSymbols(symbols[i], src = 'yahoo',from = "2015-01-01", to = "2021-12-25", auto.assign = FALSE)
  returns <- Return.calculate(Ad(sym), method = c("discrete", "log"))
  return_a= Return.annualized(returns, scale = NA, geometric = TRUE)
  colnames(returns) <- symbols[i]
  colnames(return_a) <- symbols[i]
  re=merge(re, returns)
  rea=merge(rea, return_a)
}
head(re)
head(rea)

#fffff