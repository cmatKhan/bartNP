
# bartNP

<!-- badges: start -->
[![R-CMD-check](https://github.com/cmatKhan/bartNP/workflows/R-CMD-check/badge.svg)](https://github.com/cmatKhan/bartNP/actions)
<!-- badges: end -->

NOTE: incomplete install instructions 2021 11 10. Will complete tomorrow morning

## For HTCF cluster users, the input data (the NetProphetDataSet) is located at:

`/scratch/mblab/chasem/bartNP/data`

You can copy that folder either to your local or to your scratch space -- it is all the input you need.

## Source Code Installation (for development users)

This is meant for those wishing to play with the code. __If you don't want to play with the source code, don't install this way__.

Clone the repo into the spot where you keep source code. I put mine in `/home/$USER/code` on my computer. Launch the project in Rstudio (either click the .Rproj file, or open it through the file navigator in Rstudio). At this point, you have a choice -- `renv` is a virtual environment program akin to python `venv`. I have it set to activate automatically -- it may cause some issues for you. I don't know what will happen if your R is out of date, if you don't have `renv`, etc. If you want to deal with the virtual environment, first check the documentation, next ask me -- it is important to use the vitual environment if you want to actually work with me on this, but I have never set up an R virtual environment on someone elses's computer, so I don't know what to expect. It is not a 'normal' part of installatoin -- this is, again, only for 'development.

## User Installation (for those that want to interact with the bartNP package -- __Not__ intended for the NextFlow pipeline)

``` r
library(remotes)

# note: if you don't have an up to date R, and if you haven't been keeping your core bioconductor packages up to date, then this is going to install a lot
remotes::install_github("cmatKhan/bartNP", dependencies = TRUE, upgrade = "always")
```

This is meant for those who want to install the package, and then, for example, open the NetProphetDataSet and explore what is there. It is __not__ meant to be used for NextFlow (though you could. But if you try to do that and it doesn't work, I'll say, "just use singularity". The point of singularity is to avoid machine specific issues. 

Installing this way may mean that you may have to deal with some updates/dependency issues manually -- just read the error codes related to installation. If it says, "you don't have package x", then you'll have to install. `install_github()` *should* install all dependencies automatically, but there are always some issues with specific machines, etc. Again, avoiding those problems is the point of singularity, so if you have singularity installed, you can always pull the image and use it interactively. More on that below.

## Pulling the singularity 

## Running bartNP with NextFlow

You can do this either on your local, or on the cluster. If you chose to do this on your local, then I strongly suggest that you edit the `gene_list` in the `data` directory down to between 3 and 10 genes. Less is better -- Each gene model will still be multi-threaded (currently not set to infer the number of threads, but you're computer has more than 6, so no problem), but unless it won't be multi processor. Other than that, the steps are the same:

1. Go to the nextflow website and follow the installation instructions. Alternatively, if you have `conda`, you can do this: `conda install -p /path/to/where/you/put/virtual_envs/nextflow nextflow`. Once the environment installs, you can do this: `conda activate /path/to/where/you/put/virtual_envs/nextflow********


## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(bartNP)
## basic example code
```

