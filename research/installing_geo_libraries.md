---
layout: page
title: Importing Shapefiles into R
description: Importing Shapefiles into R
---

This tutorial demonstrates how to install all the necessary packages to import ESRI shapefiles into R and plot them. 



* * *



### 1. Install Compiler Tools

In case you haven't already, we first need to install a C++ compiler and other command-line tools.  

#### Mac Users

Some of you may have already done this in the last two weeks. If you recall
doing the last step below in the last two weeks, then ignore this step.

<!--either [Xcode](https://developer.apple.com/xcode/download/) or-->
* Install the [Command Line Tools for Xcode](https://developer.apple.com/downloads/). You’ll need to
have a (free) Apple ID.
* Open Terminal by going to a Finder window -> Applications -> Utilities ->
Terminal and then
    + Run the command: `sudo xcodebuild -license`
    + Scroll to the bottom and `agree` to the licence.
    + Open a new tab by pressing command+T and run the command: `sudo xcode-select --install`


#### Windows Users

Download and install [Rtools](https://cran.r-project.org/bin/windows/Rtools/). Note: this is not an R package!



* * *



### 2. Install `geos` and `gdal` Geospatial Libraries via QGIS

Next we need to install two open source geospatial libraries: 

* [geos](http://trac.osgeo.org/geos/): Geometry Engine Open Source 
* [gdal](http://www.gdal.org/): Geospatial Data Abstraction Library

<!--
#### Mac Users

* In your Mac menu bar go to System Preferences... -> Security & Privacy -> General Tab ->
unlock the lock on the bottom left of panel -> select "Allow apps downloaded
from": Anywhere -> relock the lock
* Install Macports as described in the [Quickstart](http://www.macports.org/install.php)
instructions.  Note
    + You have already completed steps 1 and 2.
    + To know what version of OS X you have click on the Apple icon on the top
    left of the menu bar -> About This Mac
* Install the [`gdal`](http://www.gdal.org/) and [`geos`](http://trac.osgeo.org/geos/) 
geospatial libraries.  In Terminal
    + Open a new tab and run the command: `sudo port install gdal`
    + Open a new tab and run the command: `sudo port install geos`

#### Windows Users

Follow the instructions in [Quick Start for OSGeo4W Users](http://trac.osgeo.org/osgeo4w/#QuickStartforOSGeo4WUsers)
-->

This can be done by installing QGIS, which is an open-source alternative to ArcGIS: <http://www.qgis.org/en/site/forusers/download.html>


* * *



### 3. Install Necessary R Packages

Next we install two R packages that provide functions to interface the previously installed geospatial libraries:
the `rgeos` and `rgdal` packages.  In R run the following two commands.

~~~
install.packages("rgeos", repos="https://cran.rstudio.com/", type="source")
install.packages("rgdal", repos="https://cran.rstudio.com/", type="source")
~~~

After installation, test that both packages work by running the following two commands in R:

~~~
library(rgeos)
library(rgdal)
~~~

Finally, for the purposes of this tutorial, install the `maptools`, `ggplot2`, and `dplyr` packages:

~~~
install.packages("maptools", repos="https://cran.rstudio.com/")
install.packages("ggplot2", repos="https://cran.rstudio.com/")
install.packages("dplyr", repos="https://cran.rstudio.com/")
~~~



* * *



### 4. Testing: Load a Shapefile into R

We now load a shapefile into R which you can download [here]({{ BASE_PATH }}/pages/research/sids.zip).  In it we find three files:

    sids.shp
    sids.dbf
    sids.shx

We have two choices of functions for loading shapefiles into R.  We demonstrate
both their uses below noting that in my case that the files are contained in the
directory `/Users/rudeboybert/Downloads/sids/`; change this directory to reflect
where your files are located.


#### maptools Package

When using `readShapePoly()` from the `maptools` package, the input argument `shpfile_name` identifies the search path of the `.shp` file:

~~~
library(maptools)
shpfile_name <- "/Users/rudeboybert/Downloads/sids/sids.shp"
nc_sids <- readShapePoly(fn = shpfile_name, proj4string = CRS("+proj=longlat +ellps=clrk66"))
plot(nc_sids, axes=TRUE)
~~~


#### rgdal Package

When using `readOGR()` from the `rgdal` package, the input argument `shpfile_dir` identifies the search path of the directory:

~~~
library(rgdal)
shpfile_dir <- "/Users/rudeboybert/Downloads/sids"
nc_sids <- readOGR(dsn=shpfile_dir, layer="sids", p4s="+proj=longlat +ellps=clrk66")
plot(nc_sids, axes=TRUE)
~~~



* * *



### 5. Plot Map Using ggplot2

In order to plot the shapefile data using the `ggplot2` package, we must first convert the `SpatialPolygonsDataFrame` object into a data frame
defining each polygon (i.e. area in the region).  This is done using the `fortify()` function.

~~~
library(ggplot2)
library(dplyr)
sp_obj <- nc_sids
sp_obj$id <- rownames(sp_obj@data)
map_points <- fortify(sp_obj, region="id")
map_df <- inner_join(map_points, sp_obj@data, by="id")
~~~

We can now plot this data frame using `ggplot2`

~~~
map_ggplot <- 
    ggplot(map_df, aes(x=long, y=lat, group=group)) +
    coord_map() +
    theme_bw() +
    xlab("Longitude") + ylab("Latitude") + 
    ggtitle("North Carolina SIDS") + 
    geom_polygon(aes(fill=SID74)) + 
    geom_path(col="black", size=0.5) + 
    scale_fill_continuous(low="white", high="black", name="SIDS74")
map_ggplot
~~~



* * *



### Sources

* [Installing rgeos and rgdal on a Mac](http://tlocoh.r-forge.r-project.org/mac_rgeos_rgdal.html)
* [Plotting polygon shapefiles](https://github.com/hadley/ggplot2/wiki/plotting-polygon-shapefiles)

