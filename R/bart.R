#'
#' use BART to generate a network structure prediction
#'
#' @description The following can be used for memory and performance profiling
#'  \url{http://adv-r.had.co.nz/memory.html}
#'  \url{http://adv-r.had.co.nz/Profiling.html#measure-perf}
#'  \url{https://cran.r-project.org/web/packages/profmem/vignettes/profmem.html}
#'
#' @import BART
#'
#' @param regulators_predictor_matrix A sample x regulator matrix where the values
#' are expression of the given regulator j in sample i
#' @param gene_response_array Expression of a given gene in i samples. Length
#' of gene_response_array must be the same as the rows in regulators_predictor_matrix
#' @param ... additional arguments to [BART::mc.wbart]
#'
#' @return a BART object
#'
#' @export
bartForOneGene <- function(regulators_predictor_matrix,
                           gene_response_array,
                           ...) {

    BART::mc.wbart(
      x.train = regulators_predictor_matrix,
      y.train = gene_response_array,
      ...
    )

}
