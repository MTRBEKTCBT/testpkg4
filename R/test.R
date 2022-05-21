library(dplyr)
library(lubridate)
library(zipangu)

seq_days_in_months <- function(year, from_month, to_month){
  # 何ヶ月分の日付の配列を作るか
  month_length <- to_month - from_month + 1
  # 日付の連番の1日目を作成
  start_date <- as.Date(paste(year, from_month, "01", sep="-"))
  # 日付の連番の最後の日を決定
  end_date <- start_date %m+% months(month_length) - 1
  dates <- seq(from = start_date, to = end_date, by = 1)
  return(dates)
}

count_business_days <- function(year, from_month, to_month){
  date_array <- seq_days_in_months(year, from_month, to_month)
  data.frame(target_date = date_array,
             day_of_week = lubridate::wday(date_array, label = TRUE) ) %>%
    dplyr::filter(! target_date %in% zipangu::jholiday(year, holiday.names = FALSE),
                  ! day_of_week %in% c("Sat","Sun") ) %>%
    nrow()
}
