library(PerformanceAnalytics)
library(quantmod)
library(stats)
library(xts)
library(dplyr)


tar_and_ind=c('VOO','AAPL', 'AMZN', 'BRK-B', 'FB', 'GOOG', 'GOOGL', 'JNJ', 'JPM', 'MSFT', 'NVDA', 'TSLA')

#calculate return of asset
dfx= getSymbols('VOO', src = 'yahoo', from = "2016-12-30", to = "2021-12-31", auto.assign = FALSE)
re <- Return.calculate(Ad(dfx), method = c("discrete", "log"))
rea= Return.annualized(re, scale = NA, geometric = TRUE)
colnames(re) <- 'VOO'
colnames(rea) <- 'VOO'
re=na.omit(re)
head(re)
head(rea)

symbols=c('AAPL', 'AMZN', 'BRK-B', 'FB','GOOG', 'GOOGL', 'JNJ', 'JPM', 'MSFT', 'NVDA', 'TSLA')

#calculate the returns of multiple indexes
for(i in 1:length(symbols)) {
  sym <- getSymbols(symbols[i], src = 'yahoo',from = "2016-12-30", to = "2021-12-31", auto.assign = FALSE)
  returns <- Return.calculate(Ad(sym), method = c("discrete", "log"))
  return_a= Return.annualized(returns, scale = NA, geometric = TRUE)
  colnames(returns) <- symbols[i]
  colnames(return_a) <- symbols[i]
  re=merge(re, returns)
  rea=merge(rea, return_a)
}
re=na.omit(re)
head(re)
head(rea)


