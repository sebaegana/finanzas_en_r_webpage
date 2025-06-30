# Load required libraries
library(quantmod)
library(TTR)
library(ggplot2)

# Step 3: Data Retrieval and Preparation
# Define the stock symbol and date range
stock_symbol <- "AAPL"
start_date <- as.Date("2020-01-01")
end_date <- as.Date("2021-01-01")

# Import historical stock prices
stock_data <- getSymbols(stock_symbol, src = "yahoo", from = start_date, to = end_date, auto.assign = FALSE)

# Extract adjusted close prices
closing_prices <- Cl(stock_data)

# Step 4: Introduction to Technical Indicators
# Calculate moving averages
sma_50 <- SMA(closing_prices, n = 50)
sma_200 <- SMA(closing_prices, n = 200)

# Calculate RSI
rsi <- RSI(closing_prices)

# Step 5: Implementing Technical Indicators in R
# Plotting stock prices and technical indicators
ggplot() +
  geom_line(aes(x = index(closing_prices), y = closing_prices), color = "blue") +
  geom_line(aes(x = index(sma_50), y = sma_50), color = "red") +
  geom_line(aes(x = index(sma_200), y = sma_200), color = "green") +
  geom_line(aes(x = index(rsi), y = rsi), color = "orange") +
  labs(title = paste(stock_symbol, "Stock Prices and Technical Indicators"),
       x = "Date", y = "Price/Indicator") +
  theme_minimal()

########

# Step 7: Backtesting Strategies
# Define a simple moving average crossover strategy
# Buy when the short-term SMA crosses above the long-term SMA
# Sell when the short-term SMA crosses below the long-term SMA
signals <- ifelse(sma_50 > sma_200, 1, ifelse(sma_50 < sma_200, -1, 0))

library(PerformanceAnalytics)

# Calculate strategy returns
strategy_returns <- daily_returns * signals

# Calculate cumulative returns of the strategy
cumulative_returns <- cumprod(1 + strategy_returns) - 1

# Plot cumulative returns
ggplot() +
  geom_line(aes(x = index(closing_prices), y = cumulative_returns), color = "blue") +
  labs(title = "Cumulative Returns of SMA Crossover Strategy",
       x = "Date", y = "Cumulative Returns") +
  theme_minimal()

