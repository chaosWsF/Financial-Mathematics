# Data

## vix_index

Source: CBOE  
Frequency: Daily  
Type: csv  
Variables:

- VIX Open
- VIX High
- VIX Low
- VIX Close

------

## vix_options

Source: Optionmetrics  
Frequency: Daily  
Type: csv  
Variables (name - type - description):

- am_set_flag - CHAR - AM Settlement Flag
- am_settlement - NUM - Am Settlement
- best_bid - NUM - Highest Closing Bid
- best_offer - NUM - Lowest Closing Ask
- cfadj - NUM - Cumulative Adjustment Factor
- class - CHAR - Class Designator
- contract_size - NUM - Contract Size
- cp_flag - CHAR - Call/Put Flag
- cusip - CHAR - CUSIP
- delta - NUM - Delta
- div_convention - CHAR - Dividends Convention
- exchange_d - NUM - Exchange Designator
- exdate - DATE - Expiration Date
- exercise_style - CHAR - Exercise Style
- expiry_indicator - CHAR - Expiry Indicator
- forward_price - NUM - Forward Price
- gamma - NUM - Gamma
- impl_volatility - NUM - Implied Volatility
- index_flag - CHAR - Index Flag
- industry_group - NUM - Industry Group
- issue_type - CHAR - Issue Type
- issuer - CHAR - Issuer
- last_date - DATE - Last Traded Date
- open_interest - NUM - Open Interest
- root - CHAR - Root of the Option Symbol
- secid - NUM - Security ID
- sic - CHAR - SIC
- ss_flag - CHAR - Settlement Flag
- strike_price - NUM - Strike Price Times 1000
- suffix - CHAR - Suffix of the Option Symbol
- symbol - CHAR - Option Symbol
- symbol_flag - CHAR - Symbol Flag
- theta - NUM - Theta
- ticker - CHAR - Ticker
- vega - NUM - Vega/Kappa
- volume - NUM - Volume

------

## zero_coupon_yield_curve

Source: Optionmetrics  
Frequency: Daily  
Type: csv  
Variables (name - type - description):

- days - NUM - Days to maturity
- rate - NUM - Zero-coupon interest rate (continuously compounded)
