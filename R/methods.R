
# NetProphetDataSet

## getter/setters ----

### exprMat ----

#'
#' Set expression matrix
#'
#' Set or replace the expression matrix in the [NetProphetDataSet]
#'
#' @rdname exprMat
#'
#' @param x a NetProphetDataSet object
#' @param value an expression matrix with columns equal to colData, and colnames
#' equal to and in the same order as the colnames column of colData
#'
#' @export
setReplaceMethod("exprMat", "NetProphetDataSet", function(x, value) {
  # TODO error check colnames (see param value)
  assays(x)$expr = value
  validObject(x)
  x
})

#' @rdname exprMat
#' @export
setMethod("exprMat", "NetProphetDataSet", function(x) {
  assays(x)$expr
})

### regMatrix ----

#'
#' gene by regulators matrix
#'
#' A matrix with dimension genes, which is the same as the expression matrix of
#' the [NetProphetDataSet], and columns corresponding to regulators. Values are
#' boolean values where `TRUE` allows regulator j to affect the transcription of
#' gene i, and `FALSE` disallows regulation.
#'
#' @rdname regMatrix
#'
#' @param x a NetProphetDataSet object
#' @param reg_matrix a gene by regulation matrix, where the number of genes (rows) is
#'   equal to the rows in the [NetProphetDataSet] expression matrix
#'
#' @export
setReplaceMethod("regMatrix", "NetProphetDataSet", function(x, reg_matrix) {
  x@regMatrix = reg_matrix
  validObject(x)
  x
})

#' @rdname regMatrix
#' @export
setMethod("regMatrix", "NetProphetDataSet", function(x) {
  x@regMatrix
})


### get predictors ----


#' extract a subset of the expression matrix filtered by the regulation matrix
#' for a given gene
#'
#' This function returns a matrix in dimensions samples, where samples are the
#' columns of the [NetProphetDataSet], x predictors, where predictors are a
#' subset of the regulators. Any regulators which do not regulate a gene
#' according to the regulation matrix are filtered out
#'
#' @rdname regPredictors
#'
#' @param x a NetProphetDataSet object
#' @param gene a gene which is in the rownames(x) and possibly in the colnames(regMatrix(x))
#' @param transpose logical, default TRUE to return a sample x predictor matrix.
#' NOTE that this is of particular interest when calling C++ (and maybe C?)
#' functions as they store matricies differently than R and Fortran (row vs column wise).
#' Best to check on these details if you think it might matter.
#'
#' @export
setMethod("regPredictors", "NetProphetDataSet", function(x, gene, transpose = TRUE) {
  # get list of predictors excluding those which correspond to FALSE value in the
  # regulation matrix (FALSE means that regulator j should not be considered as
  # a regulator of gene i)

  # TODO ERROR HANDLING

  acceptable_predictors = names(regMatrix(x)[gene,])[regMatrix(x)[gene,] == TRUE]
  predictors = exprMat(x)[acceptable_predictors, ]

  if(transpose){
    t(predictors)
  } else{
    predictors
  }
})

#' get list of genes from the rownames of the [NetProphetDataSet] which are not
#' regulators, which are those genes in the columns of the regMatrix slot
#'
#'
#' @rdname nonRegGenes
#'
#' @param x a NetProphetDataSet object
#'
#' @export
setMethod("nonRegGenes", "NetProphetDataSet", function(x) {
  # TODO: add error handling
  rownames(x)[!rownames(x) %in% colnames(regMatrix(x))]
})

## subsetting custom slots ----

#' @export
setMethod("[", "NetProphetDataSet", function(x, i, j, drop=TRUE) {
  reg_matrix = regMatrix(x)

  if (!missing(i)) {
    unknown_gene_err = setdiff(i,rownames(x))
    if (is.character(i) & length(unknown_gene_err) != 0) {
      fmt = paste0("<", class(x), ">[i,] index out of bounds: %s")
      i = SummarizedExperiment:::.SummarizedExperiment.charbound(
        i, rownames(x), fmt
      )
    }
    i = as.vector(i)
    reg_matrix = reg_matrix[i,]
  }

  # no reason to subset regMatrix -- the regulatory relationships remain even
  # if the regulators are not KO in the data set.

  # see the Extending SummarizedExperiment vignette, or infer from i above,
  # how to also subset on j

  out = callNextMethod()
  BiocGenerics:::replaceSlots(out,
                              regMatrix = reg_matrix,
                              check=FALSE)

})
