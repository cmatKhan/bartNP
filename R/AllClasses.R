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
#' @export
#' @import methods
#' @importClassesFrom SummarizedExperiment SummarizedExperiment
.NetProphetDataSet = setClass("NetProphetDataSet",
                              contains = "RangedSummarizedExperiment",
                              slots = representation(regMatrix = "matrix"))

# validity check ---------------------------------------------------------------

# TODO: more error checking

setValidity2("NetProphetDataSet", function(x) {
  msg = NULL

  if (assayNames(x)[1] != "expr") {
    msg = c(msg, "'expression' must be first assay")
  }

  if (is.null(msg)) {
    TRUE
  } else msg
})

#' @export
#' @importFrom SummarizedExperiment SummarizedExperiment
NetProphetDataSet = function(exprMat = matrix(0,0,0),
                             regMatrix = matrix(0,0,0), ...) {
  nps = SummarizedExperiment(assays  = SimpleList(expr=exprMat),...)
  .NetProphetDataSet(nps,
                     regMatrix = regMatrix)
}
