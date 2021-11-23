# AIOMFAC.jl

*A Julia wrapper to work with the AIOMFAC-web model*.

## Background

The [AIOMFAC-web model](http://www.aiomfac.caltech.edu/model.html) is a web interface to run the [AIOMFAC](http://www.aiomfac.caltech.edu/about.html) model. AIOMFAC is a thermodynamic group contribution model that is used to calculate the activity coefficients of different chemical species. It is developed by Andi Zuend and colleagues, without any contribution from us or our group. The AIOMFAC-web model is driven by a publicly licensed FORTRAN module, that is included in their [AIOMFAC-web Public Code Repository](https://github.com/andizuend/AIOMFAC).

## AIMS

The aims of this project are

1. To make the FORTRAN code accessible/callable from a high-level language. The purpose is to allow for automated generation of a large number of simulations without the need to fill in a web form.
2. To enable initialization modes that are not accessible through the web API. For example initialization by group mass concentrations.
3. To compute additional output not provided in the raw model output, e.g. the hygroscopicity parameter kappa. 

## Status

This work is currently under development. 
