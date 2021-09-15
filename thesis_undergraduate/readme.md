# VIX Option Pricing Based on Heston-Nandi Model

## Abstract

Volatility derivatives, as an efficient hedging tool, are favored by lots of financial practitioners. One of them with a large volume and high turnover, VIX options, is studied in our paper. After reviewing the classical Black-Scholes (BS) theory, we introduce the Heston stochastic volatility model and then obtain its closed-form solution to option pricing. However, the Heston stochastic volatility model is for continuous-time situation and is hard to be put into practice. Thus, we assume realized variance of log returns of the VIX index as a GARCH$(p,q)$ process and derive the Heston-Nandi GARCH (HN) model and its corresponding option pricing formula. Thereafter, on the data of VIX options from 2014 to 2018, we calculate its theoretical price based on the HN model via the maximum likelihood estimation and the Gauss-Kronrod quadratic formula. Through several empirical studies, we show that the HN model is superior to the BS formula for all used error indicators when pricing VIX options of different moneyness, such as moderate OTM and deep OTM options. Furthermore, the predictability of the HN model is also studied in our paper. Through separating data into two parts, we forecast the out-of-sample price of VIX options and record its in-sample and out-of-sample pricing errors. Actually, these results show that the price of VIX call options can be correctly predicted by the HN model. In general, we draw a conclusion that the HN model can not only perform well in the VIX options pricing but also has good short-term predictability of the price of VIX options.

## Keywords

Stochastic volatility; GARCH model; VIX options; Out-of-sample

## Programs

- base_data.R
  - run initially
  - load data
- black_scholes.R
  - bs im vol
  - bs pricing
- eval_models.R
  - error measures: rmse, mae, arpe
  - main programs
- heston_nandi.R
  - simulate hn garch
  - `nlm` for mle
  - `integrate` & `Vectorize` for option pricing
