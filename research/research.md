---
layout: page
title: Research
description: Research
---


## Forest Ecology

#### **Background**

I've developed a recent interest in forest ecology, in particular inter-species 
competition model of Canham . Along with [Prof. David
Allen](http://www.middlebury.edu/academics/bio/faculty/node/352418) in the
Biology Department at Middlebury College.

#### **Data & Code**

* [Shiny App of Tree Plot](https://shiny.middlebury.edu:3838/aykim/Focal_Trees/)



<hr>


## Spatial Epidemiology

#### **Background**

The detection of areas in which the risk of a particular disease is 
significantly elevated, leading to an excess of cases, is an important 
enterprise in spatial epidemiology. Various frequentist approaches have been 
suggested for the detection of "clusters" within a hypothesis testing framework.
Unfortunately, these suffer from a number of drawbacks including the difficulty 
in specifying a p-value threshold at which to call significance, the inherent 
multiplicity problem, and the possibility of multiple clusters. In this paper, 
we suggest a Bayesian approach to detecting "areas of clustering" in which the 
study region is partitioned into, possibly multiple, "zones" within which the 
risk is either at a null, or non-null, level. Computation is carried out using 
Markov chain Monte Carlo, tuned to the model that we develop. The method is
applied to:

* Leukemia data in upstate New York.
* Various cancers in western Washington state.

#### **Publications**

* Kim, A.Y., and Wakefield, J (2016). [A Bayesian method for cluster detection with application to brain and breast cancer in Puget Sound](http://www.ncbi.nlm.nih.gov/pubmed/26841056) *Epidemiology* **27**, 347-55.
* Wakefield, J., and Kim, A. (2013). [A Bayesian model for cluster detection](http://biostatistics.oxfordjournals.org/content/14/4/752)
*Biostatistics* **14**, 752-765.

#### **Data & Code**

The `SpatEpi` package contains data and code for spatial epidemiology:

* On [CRAN](http://cran.r-project.org/package=SpatialEpi)
* Development version on [GitHub](https://github.com/rudeboybert/SpatialEpi)


<hr>


## Change Point Detection

#### **Background**

<img src="{{BASE_PATH}}/assets/images/university_bridge.jpg" width="300">

We consider the problem of detecting changes in a multivariate
data stream. A change detector is defined by a detection algorithm and an alarm
threshold. A detection algorithm maps the stream of input vectors into a
univariate detection stream. The detector signals a change when the detection
stream exceeds the chosen alarm threshold. We consider two aspects of the
problem: (1) setting the alarm threshold and (2) measuring/comparing the
performance of detection algorithms. We assume we are given a segment of the
stream where changes of interest are marked. We present evidence that, without
such marked training data, it might not be possible to accurately estimate the
false alarm rate for a given alarm threshold. Commonly used approaches assume
the data stream consists of independent observations, an implausible assumption
given the time series nature of the data. Lack of independence can lead to
estimates that are badly biased. Marked training data can also be used for
realistic comparison of detection algorithms. We define a version of the
receiver operating characteristic curve adapted to the change detection problem
and propose a block bootstrap for comparing such curves. We illustrate the
proposed methodology using multivariate data derived from an image stream.

**Keywords**: Block bootstrap; Change point detection; Time series analysis

#### **Publications**

* Kim, A., Marzban, C., Percival D.B., and Stuetzle, W. (2009). [Using labeled data to evaluate change detectors in a multivariate streaming environment](http://www.sciencedirect.com/science/article/pii/S016516840900173X). *Signal Processing* **89**, 2529-2536.

#### **Data & Code**

[Link to data](http://www.stat.washington.edu/research/changedetection/) used for above method: manually tagged images of boat traffic
underneath the University Bridge in Seattle WA.


<hr>


## Service

* **Journal Refereeing**: [The American Statistician](http://www.tandfonline.com/toc/utas20/current) and the [Journal of Quantitative Analysis in Sports](www.degruyter.com/view/j/jqas).
