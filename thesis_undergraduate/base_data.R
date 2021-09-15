library('dplyr')
library('lubridate')

## VIX index
# vix_total <- read.csv('./data/vix_index.csv')
vix_total <- read.csv(
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vTM61GOOYb5iXzwmSM1xH8CPRRiRQS1HWclfam-EtjNPNQWAW8vpyjmNqcrAxBsI-WsmdnXZf2Aorxs/pub?output=csv'
)
vix_total$Date <- mdy(vix_total$Date)
vix <- subset(vix_total, Date >= '2013/12/31' & Date <= '2018/12/31', select = c('Date', 'VIX.Close'))
n <- nrow(vix) - 1
r <- log(vix$VIX.Close[2:(n+1)] / vix$VIX.Close[1:n])
vix <- data.frame(date = vix$Date[2:(n+1)], vix = vix$VIX.Close[2:(n+1)], r = r)

## risk free returns
# rf <- read.csv('./data/zero_coupon_yield_curve.csv')
rf <- read.csv(
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vS_3jrHc8cqFB8EiSmKlj_ULbqDNPX298fkw26eifzDwc4AuO_fQ6HPH2941jpksrArEv5IN_dars8v/pub?output=csv'
)
rf$date <- ymd(rf$date)
rf <- subset(rf, (days == 42) & (date >= '2018/01/01' & date <= '2018/12/31'), select = 'rate')
rf <- mean(rf$rate) / 100

## VIX options
# options <- read.csv('./data/vix_options_filtered.csv')
options <- read.csv(
    'https://docs.google.com/spreadsheets/d/e/2PACX-1vT-wfPhjKs-oqLWPK8F5wMreOP_ZN6TP79jFcalI6_DaDB5aobprLRbV6_M9fu2m8tH6Xbr9AP3hy8f/pub?output=csv'
)
options$date <- ymd(options$date)
options$exdate <- ymd(options$exdate)
options$strike <- options$strike_price / 1000
options <- inner_join(options, vix, by = 'date')
options <- options %>%
  mutate(
      price = (best_bid + best_offer) / 2, maturity = as.numeric(exdate - date), moneyness = strike / vix
  ) %>%
  filter(
      price >= 0.1 & (best_offer - best_bid) / price <= 0.3 & maturity > 7 & maturity <= 90 & moneyness > 1
  ) %>%
  select(date, price, maturity, strike, moneyness, vix)
