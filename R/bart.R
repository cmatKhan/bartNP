#'http://adv-r.had.co.nz/memory.html
#'http://adv-r.had.co.nz/Profiling.html#measure-perf
#'https://cran.r-project.org/web/packages/profmem/vignettes/profmem.html
#'
#' use BART to generate a network structure prediction
#'
#' @description
#'
#' @import BART
#'
#' @param regulators_predictor_matrix A sample x regulator matrix where the values
#' are expression of the given regulator j in sample i
#' @param gene_response_array Expression of a given gene in i samples. Length
#' of gene_response_array must be the same as the rows in regulators_predictor_matrix
#' @param test_data_matrix test data for bart. See [BART::mc.wbart]
#' @param ... additional arguments to [BART::mc.wbart]
#'
#' @return list with
#'
#' @export
bartForOneGene <- function(regulators_predictor_matrix,
                           gene_response_array,
                           test_data_matrix,
                           gene_name = NULL,
                           ...) {

  BART::mc.wbart(
    x.train = regulators_predictor_matrix,
    y.train = gene_response_array,
    x.test  = test_data_matrix,
    ...
  )

}
