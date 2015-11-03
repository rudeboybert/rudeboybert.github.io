---
layout: page
title: Importing Shapefiles into `R`
description: Importing Shapefiles into `R`
---

This tutorial demonstrates how to install all the necessary packages to import





## 1. Install Compiler Tools

We first need to install a C compiler and other command-line tools.  

#### Mac Users

* Install either [Xcode](https://developer.apple.com/xcode/download/) or the [Command Line Tools for Xcode](https://developer.apple.com/downloads/). You’ll need to
have a (free) Apple ID.
* Open Terminal by going to a Finder window -> Applications -> Utilities ->
Terminal and then
    + Run `sudo xcodebuild -license`, scroll to the bottom and `agree` to the licence.
    + Open a new tab by pressing command+T and run `xcode-select --install`


#### Windows Users

Download and install [Rtools](https://cran.r-project.org/bin/windows/Rtools/). Note: this is not an R package!





## 2. Install `geos` and `gdal` Geospatial Libraries

Next we need to install two open source geospatial libraries: 

* [geos](http://trac.osgeo.org/geos/) Geometry Engine Open Source 
* [gdal](http://www.gdal.org/) Geospatial Data Abstraction Library

#### Mac Users

* In your Mac menu bar go to System Preferences... -> Security & Privacy ->
unlock the lock on the bottom left of panel -> select "Allow apps downloaded
from": Anywhere -> relock the lock


* Install Macports as per the [Quickstart](http://www.macports.org/install.php)
instructions.
    + You have already completed steps 1 and 2.
    + To know what version of OS X you have click on the Apple icon on the top
    left of the menu bar -> About This Mac
* Install the [`gdal`](http://www.gdal.org/) and [`geos`](http://trac.osgeo.org/geos/) 
geospatial libraries.
    + In Terminal open a new tab and run `sudo port install gdal`
    + In Terminal open a new tab and run `sudo port install geos`

#### Windows Users

Follow the instructions in [Quick Start for OSGeo4W Users](http://trac.osgeo.org/osgeo4w/#QuickStartforOSGeo4WUsers)





## 3. Install `rgeos` and `rgdal` R Packages

Next we install two R packages that provide functions to interface the previously installed geospatial libraries:
the `rgeos` and `rgdal` packages.  In R run the following two commands.

```{r}
install.packages("rgeos", type="source")
install.packages("rgdal", type="source")
```

After installation, test that both packages work by running the following two commands in R:

```{r}
library(rgeos)
library(rgdal)
```





## 4. Load a Shapefile into R












    _includes/
    _layouts/
    _plugins/
    assets/
    pages/
    .gitignore
    License.md
    Rakefile
    ReadMe.md
    _config.yml
    index.md    
    
    
    
    
    


