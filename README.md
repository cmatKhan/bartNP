
# bartNP

<!-- badges: start -->
[![R-CMD-check](https://github.com/cmatKhan/bartNP/workflows/R-CMD-check/badge.svg)](https://github.com/cmatKhan/bartNP/actions)
<!-- badges: end -->

You can copy that folder either to your local or to your scratch space -- it is all the input you need.

## Source Code Installation (for development users)

This is meant for those wishing to play with the code. __If you don't want to play with the source code, don't install this way__.

Clone the repo into the spot where you keep source code. I put mine in `/home/$USER/code` on my computer. Launch the project in Rstudio (either click the .Rproj file, or open it through the file navigator in Rstudio). At this point, you have a choice -- `renv` is a virtual environment program akin to python `venv`. I have it set to activate automatically -- it may cause some issues for you. I don't know what will happen if your R is out of date, if you don't have `renv`, etc. If you want to deal with the virtual environment, first check the documentation, next ask me -- it is important to use the vitual environment if you want to actually work with me on this, but I have never set up an R virtual environment on someone elses's computer, so I don't know what to expect. It is not a 'normal' part of installatoin -- this is, again, only for 'development.

## User Installation
For those who want to use the package interactively, or within the Nextflow pipeline 
without Singularity

``` r
library(remotes)

# note: if you don't have an up to date R, and if you haven't been keeping your core bioconductor packages up to date, then this is going to install a lot
remotes::install_github("cmatKhan/bartNP", dependencies = TRUE, upgrade = "always")
```

This is meant for those who want to install the package, and then, for example, open the NetProphetDataSet and explore what is there.

Installing this way may mean that you may have to deal with some updates/dependency issues manually -- just read the error codes related to installation. If it says, "you don't have package x", then you'll have to install. `install_github()` *should* install all dependencies automatically, but there are always some issues with specific machines, etc. Again, avoiding those problems is the point of singularity, so if you have singularity installed, you can always pull the image and use it interactively. More on that below.

## Pulling the singularity 

You may pull the Singularity container from the terminal on a computer 
with Singularity installed.

```{bash}
singularity pull library://cmatkhan/default/bartnp 
```

## Running bartNP with NextFlow

See [https://github.com/cmatKhan/bartNPNF](https://github.com/cmatKhan/bartNPNF)

