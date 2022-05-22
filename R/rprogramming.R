#' Summary statistics using group.
#'
#' @param .data Data frame
#' @param .var Variable to get summary.
#' @param ... Grouping variables
#' @export
my_summarise_by <- function(.data, .var, ...) {
  .data %>%
    group_by(...) %>%
    summarise(
      "{{.var}}_mean" := mean({{ .var }}, na.rm = TRUE),
      "{{.var}}_sd" := sd({{ .var }}, na.rm = TRUE),
      "{{.var}}_sum" := sum({{ .var }}, na.rm = TRUE),
      "{{.var}}_n" := n()
    )
}

#' Summry statistics using group and across.
#'
#' @param .data Data frame
#' @param .vars Variables to get summary.
#' Default value is all numeric columns.
#' @param ... Grouping variable
#' @export
my_summarise_across <- function(.data, ..., .vars = tidyselect::vars_select_helpers$where(is.numeric)) {

  .data %>%
    group_by(...) %>%
    summarise(across({{ .vars }}, list(
      n = ~ n(),
      mean = ~mean(.x, na.rm = TRUE),
      sd = ~sd(.x, na.rm = TRUE),
      sum = ~sum(.x, na.rm = TRUE)
    )))
}
utils::globalVariables("where")
