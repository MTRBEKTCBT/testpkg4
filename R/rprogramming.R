library(dplyr)

# 複数列の平均と観測数を計算
summarise_mean <- function(data, vars) {
  data %>% summarise(n = n(), across({{ vars }}, mean))
}

# x, y, grpを列名に持つデータのサマリー
my_summary_function <- function(data) {
  data %>%
    filter(x > 0) %>%
    group_by(grp) %>%
    summarise(y = mean(y), n = n())
}

# データの平均と標準偏差をそれぞれ指定する
my_summarise3 <- function(data, mean_var, sd_var) {
  data %>%
    summarise(mean = mean({{ mean_var }}), sd = sd({{ sd_var }}))
}

# データの平均と合計を計算して列に名前をつける
my_summarise4 <- function(data, expr) {
  data %>% summarise(
    "mean_{{expr}}" := mean({{ expr }}),
    "sum_{{expr}}" := sum({{ expr }}),
    "n_{{expr}}" := n()
  )
}

# データの平均と標準偏差を計算して列に名前を付ける
my_summarise5 <- function(data, mean_var, sd_var) {
  data %>%
    summarise(
      "mean_{{mean_var}}" := mean({{ mean_var }}),
      "sd_{{sd_var}}" := sd({{ sd_var }})
    )
}

# 任意の変数でグルーピングして平均を求める
my_summarise_by <- function(.data, .var, ...) {
  .data %>%
    group_by(...) %>%
    summarise(
      "{{.var}}_mean" := mean({{ .var }}, na.rm = TRUE)
    )
}
# my_summarise(iris, Petal.Width, Species)
# my_summarise(starwars, height, sex, gender)

# acrossを使用して平均値を求める
my_summarise_across <- function(data, summary_vars) {
  data %>%
    summarise(across({{ summary_vars }}, ~ mean(., na.rm = TRUE)))
}
# my_summarise_across(starwars, c(height, mass))

my_summarise <- function(data, group_vars, summarise_vars) {
  data %>%
    group_by(across({{ group_vars }})) %>%
    summarise(across({{ summarise_vars }}, mean, .names = "mean_{.col}"))
}
# my_summarise(starwars, contains("color"), c(height, mass))