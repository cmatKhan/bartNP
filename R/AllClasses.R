# extending SummarizedExperiment https://www.bioconductor.org/packages/devel/bioc/vignettes/SummarizedExperiment/inst/doc/Extensions.html

#' A container for expression data meant to be used to infer regulator relationships
#'
#' @rdname NetProphetDataSet
#'
#' @seealso
#' * [extending SummarizedExperiment](https://www.bioconductor.org/packages/devel/bioc/vignettes/SummarizedExperiment/inst/doc/Extensions.html).
#'    Note that A [SummarizedExperiment] object becomes a [RangedSummarizedExperiment]
#'    object when rowRanges are added.
#'
#' @slot regMatrix a gene (the number of genes in your expression matrix) by
#'   regulators (no required number) matrix where the value is TRUE if gene i
#'   can be regulated by regulator j, and FALSE otherwise.
#'
#' @export
#' @import methods
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
.NetProphetDataSet = setClass("NetProphetDataSet",
                            contains = "SummarizedExperiment",
                              slots = representation(regMatrix = "matrix"))

# validity check ---------------------------------------------------------------

# TODO: more error checking

setValidity2("NetProphetDataSet", function(x) {
  msg = NULL

  if (assayNames(x)[1] != "expr") {
    msg = c(msg, "'exprMat', the expression matrix, must be first assay")
  }

  if(nrow(regMatrix) != nrow(assays(x)$expr) | ncol(regMatrix) < 1){
    msg = c(msg, "'regMatrix'")
  }

  if (is.null(msg)) {
    TRUE
  } else msg
})

#'
#' @rdname NetProphetDataSet
#'
#' @param exprMatrix an expression matrix, eg the kemmeren microarray data set
#' @inheritParams .NetProphetDataSet
#'
#' @importFrom SummarizedExperiment SummarizedExperiment
#' @importFrom S4Vectors SimpleList
#'
#' @export
NetProphetDataSet = function(exprMatrix = matrix(0,0,0),
                             regMatrix = matrix(0,0,0), ...) {
  nps = SummarizedExperiment(assays  = SimpleList(expr=exprMatrix),...)
  .NetProphetDataSet(nps,
                     regMatrix = regMatrix)
}
