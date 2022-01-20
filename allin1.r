library(PerformanceAnalytics)
library(quantmod)
library(stats)
library(xts)
library(dplyr)
library(TTR)

library(rugarch)
library(forecast)
library(ggplot2)

tar_and_ind=c('VOO','AAPL', 'AMZN', 'BRK-B', 'FB', 'GOOG', 'GOOGL', 'JNJ', 'JPM', 'MSFT', 'NVDA', 'TSLA')

#calculate return of asset
dfx= getSymbols('VOO', src = 'yahoo', from = "2016-12-30", to = "2021-12-31", auto.assign = FALSE)
re1 <- Return.calculate(Ad(dfx), method = c("discrete", "log"))
rea1 <- Return.annualized(re1, scale = NA, geometric = TRUE)
colnames(re1) <- 'VOO'
colnames(rea1) <- 'VOO'
re1=na.omit(re1)
head(re1)
head(rea1)

symbols=c('AAPL', 'AMZN', 'BRK-B', 'FB','GOOG', 'GOOGL', 'JNJ', 'JPM', 'MSFT', 'NVDA', 'TSLA')
re=re1
rea=rea1
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


