#' 複数列の平均と観測数を計算
#'
#' @param data data frame
#' @param vars several variables.
#' Using select helper function is accepted.
#' @export
summarise_mean <- function(data, vars) {
  data %>% summarise(n = n(), across({{ vars }}, mean))
}

#' x, y, grpを列名に持つデータのサマリー
#'
#' @param data data frame
#' @export
my_summary_function <- function(data) {
  data %>%
    filter(x > 0) %>%
    group_by(grp) %>%
    summarise(y = mean(y), n = n())
}

#' データの平均と標準偏差をそれぞれ指定する
#'
#' @param data data frame
#' @param mean_var variable to get mean
#' @param sd_var variable to get sd
#' @export
my_summarise3 <- function(data, mean_var, sd_var) {
  data %>%
    summarise(mean = mean({{ mean_var }}), sd = sd({{ sd_var }}))
}

#' データの平均と合計を計算して列に名前をつける
#'
#' @param data data frame
#' @param var variable
#' @export
my_summarise4 <- function(data, var) {
  data %>% summarise(
    "mean_{{var}}" := mean({{ var }}),
    "sum_{{var}}" := sum({{ var }}),
    "n_{{var}}" := n()
  )
}

#' データの平均と標準偏差を計算して列に名前を付ける
#'
#' @param data data frame
#' @param mean_var variable to get mean
#' @param sd_var variable to get sd
#' @export
my_summarise5 <- function(data, mean_var, sd_var) {
  data %>%
    summarise(
      "mean_{{mean_var}}" := mean({{ mean_var }}),
      "sd_{{sd_var}}" := sd({{ sd_var }})
    )
}

#' 任意の変数でグルーピングして平均を求める
#' @param .data data frame
#' @param .var variable
#' @param ... grouping variable
#' @export
my_summarise_by <- function(.data, .var, ...) {
  .data %>%
    group_by(...) %>%
    summarise(
      "{{.var}}_mean" := mean({{ .var }}, na.rm = TRUE)
    )
}
# my_summarise(iris, Petal.Width, Species)
# my_summarise(starwars, height, sex, gender)

#' acrossを使用して平均値を求める
#' @param data data frame
#' @param summary_vars variables to get mean
#' @export
my_summarise_across <- function(data, summary_vars) {
  data %>%
    summarise(across({{ summary_vars }}, ~ mean(., na.rm = TRUE)))
}
# my_summarise_across(starwars, c(height, mass))

#' acrossを使用して平均値を求める
#' @param data data frame
#' @param group_vars grouping variables
#' @param summarise_vars variables to get mean
#' @export
my_summarise <- function(data, group_vars, summarise_vars) {
  data %>%
    group_by(across({{ group_vars }})) %>%
    summarise(across({{ summarise_vars }}, mean, .names = "mean_{.col}"))
}
# my_summarise(starwars, contains("color"), c(height, mass))
