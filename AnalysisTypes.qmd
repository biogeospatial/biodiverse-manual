**Table of contents:**
* [Introduction](#introduction)
* [Clustering](#clustering)
* [Spatial analyses](#spatial-analyses)
* [Matrix visualisations](#matrix-visualisations)
* [Region Grower](#region-grower)
* [Randomisations](#randomisations)
  * [Where do the randomisation results go and what do they mean?](#where-do-the-randomisation-results-go-and-what-do-they-mean)

# Introduction #

When complete, this will be a description of the analyses available in Biodiverse.  Much of the informative content is currently in the SampleSession page, but is likely to be moved here in a future round of editing.

# Clustering #

Agglomerative clustering of the groups based on their labels, or based on some function of their labels such as the values of a linked matrix or tree.  See [SampleSession#running-a-cluster-analysis](https://github.com/shawnlaffan/biodiverse/wiki/SampleSession#running-a-cluster-analysis)

# Spatial analyses #

These are moving window analyses.  See [SampleSession#running-a-spatial-moving-window-analysis](https://github.com/shawnlaffan/biodiverse/wiki/SampleSession#running-a-spatial-moving-window-analysis)

# Matrix visualisations #

_Available from version 0.16._

Need to add text here.

# Region Grower #

_Available from version 0.16._

Need to add text here.

# Randomisations #

See [SampleSession#running-a-randomisation](https://github.com/shawnlaffan/biodiverse/wiki/SampleSession#running-a-randomisation).

<a href='Hidden comment: 
NEED TO EXPLAIN HOW THEY WORK - OVERVIEW
'></a>


## Where do the randomisation results go and what do they mean? ##

The randomisations do not themselves store any results.  All results are added as additional lists in the spatial and cluster outputs.  They can be accessed under the chooser which defaults to SPATIAL_RESULTS for a spatial analysis and Cluster for a cluster analysis.

Assume in this case that _Rand1_ was used as the name of the randomisation (despite knowing full well that it is a poor choice of name and that in three weeks time we will have no idea what it means or was for).

1. **Spatial analyses**

   i. The randomisation results for spatial analyses go into a set of lists prefixed with _Rand1>>_ in the respective output.  So, for an analysis which only has SPATIAL_RESULTS, a new list is added called Rand1>>SPATIAL_RESULTS.  The naming scheme of the contents is explained below.

   ii. The results are post-processed into a set of scores from which rank-relative significance is more easily interpreted.  These are prefixed with _Rand1>>p_rank>>_.  This is described in more detail [in this blog post](https://biodiverse-analysis-software.blogspot.com/2016/08/easier-to-use-randomisation-results.html). 

   iii. From version 4, z-score significances are also available.  These are in lists prefixed with names such as _Rand1>>z_scores>>_.

2. **Cluster and Region Grower analyses** (tree based analyses), prior to version 4, have at least three lists attached to each node, with an extra set if a spatial analysis was conducted on each node.  From version 4 the first three lists are only generated when requested.

   i. _Rand1_ contains summary statistics of the most similar nodes between the original and randomised trees (e.g. mean, median, SD, quartiles, count of comparisons, how many were identical), with the similarity assessed using a Sorenson dissimilarity index (zero is identical, 0.5 means half of the terminal elements across both nodes were shared, with double counting of shared nodes).

   ii. _Rand1_DATA_ is the full set of Sorenson comparison results in case you want to extract them for other nefarious purposes (e.g. how many times did the randomisation produce a node which had 80% or more terminal elements in common?).

   iii. _Rand1_ID_LDIFFS_ contains the total lengths (from the tip of the tree) of those nodes that contained an identical set of terminal elements. If all (or most) are longer then the original tree at least has a shorter total length, even though it resulted in the same set of elements being grouped together.  (The name is an abbreviation of IDentical node Length DIFFerences. This is a confusing abbreviation and name, so any suggestions are welcome.)

   iv. Lists with names like _Rand1>>SPATIAL_RESULTS_, _Rand1>>p_rank>>SPATIAL_RESULTS_ and _Rand1>>z_scores>>SPATIAL_RESULTS_ are the same as for the Spatial analyses, but applied to the calculations for each node in the tree.  Note that these calculations use the group contents from the randomised basedata, but with groups selected using the non-randomised tree.  This makes their interpretation more directly comparable to a spatial analysis.


What do the names and values in the spatial comparison lists mean? The indices shown are those used in the comparisons, prefixed by a letter with an underscore.

  * `C_*` (e.g. C_ENDC_CWE, C_NUM_MAX) is the number of times the original value was higher than the comparison.
  * `Q_*` (e.g. Q_ENDC_CWE, Q_NUM_MAX) is the number of comparisons (q = quantum). We could use the number of iterations directly, however there may be cases where undefined values result for some indices. We cannot compare undefined with a number, and we also cannot be sure that the number of times undef results is the same for all indices.
  * `P_*` (e.g. P_ENDC_CWE, P_NUM_MAX) is the fractional ranking of the original value against those generated by the set of randomisations, calculated as `C_*` / `Q_*`. Multiply by 100 to get a percentile. The `P_*` score can be converted into a p-score in the normal way, i.e. if `P_*` = 0.99 then the original measure is higher than the randomised versions 99 times out of every hundred. If one considers higher scores to be more significant (a one tailed test) then this is the same as a p score of 0.01. One-tailed tests for low values need to account for any ties (see next point) to get the correct rank, but the interpretation is then the same.  Obviously one changes the interpretation appropriately if it is a two tailed system, e.g. the mean of numeric labels (NUM_MEAN) can be higher or lower than the set of randomisation results. So long as it is in one of the tails of the distribution then the original result is significantly more extreme than that generated by the randomisation (e.g. (C_NUM_MEAN + T_NUM_MEAN) / Q_NUM_MEAN < 0.025 or P_NUM_MEAN > 0.975 for an alpha of 0.05).
  * `T_*` (e.g. T_ENDC_CWE, T_NUM_MAX) is the number of ties, being the count of the number of times the original value was the same as the randomised value.  If there were no ties then this index is not listed.  (Note - ties are only counted from version 0.15, see [issue #146](https://github.com/shawnlaffan/biodiverse/issues/146)).
  * `SUMX_*` and `SUMXX_*` (e.g. SUMX_ENDC_CWE, SUMXX_NUM_MAX) are the sums and sums of squared values for the random indices.  These are used to calculate z-scores of the distributions as an alternative to the rank relative scoring system (search for running variance calculation if you are interested in how this works).  


<a href='Hidden comment: 
Add comment about the fact that some results will be missing since comparisons might not be generated by the randomisation given the number of iterations.
'></a>
