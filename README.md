
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cohorts <a><img src='man/figures/cohorts_ppt.png' align="right" height="180" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/PeerChristensen/cohorts/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/PeerChristensen/cohorts/actions/workflows/R-CMD-check.yaml)
[![CRAN
status](https://www.r-pkg.org/badges/version/cohorts)](https://CRAN.R-project.org/package=cohorts)
<!-- badges: end -->

Creating cohort tables from event data is complicated and requires
several lines of code. The cohorts package lets users convert data
frames to cohort tables in both long and wide formats with simple
functions. Users may choose between day and month level cohorts.

## Installation

You can install the released version of cohorts from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("cohorts")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("PeerChristensen/cohorts")
```

## Creating a month level cohort table

In this example, we use a dataset consisting of customer IDs and invoice
dates.

``` r
library(cohorts)

head(online_cohorts)
#>   CustomerID InvoiceDate
#> 1      17850  2010-12-01
#> 2      13047  2010-12-01
#> 3      12583  2010-12-01
#> 4      13748  2010-12-01
#> 5      15100  2010-12-01
#> 6      15291  2010-12-01
```

We can then turn this into a cohort table where each customer ID is
tracked from the first invoice month until the last month in the period.

``` r
online_cohorts %>%
  cohort_table_month(CustomerID, InvoiceDate)
#> # A tibble: 13 x 14
#>    cohort `Dec 2010` `Jan 2011` `Feb 2011` `Mar 2011` `Apr 2011` `May 2011`
#>     <int>      <int>      <int>      <int>      <int>      <int>      <int>
#>  1      1       1423        622        522        666        539        655
#>  2      2         NA        514        127        163        132        201
#>  3      3         NA         NA        451        122         97        135
#>  4      4         NA         NA         NA        509        106        155
#>  5      5         NA         NA         NA         NA        362         98
#>  6      6         NA         NA         NA         NA         NA        336
#>  7      7         NA         NA         NA         NA         NA         NA
#>  8      8         NA         NA         NA         NA         NA         NA
#>  9      9         NA         NA         NA         NA         NA         NA
#> 10     10         NA         NA         NA         NA         NA         NA
#> 11     11         NA         NA         NA         NA         NA         NA
#> 12     12         NA         NA         NA         NA         NA         NA
#> 13     13         NA         NA         NA         NA         NA         NA
#> # … with 7 more variables: Jun 2011 <int>, Jul 2011 <int>, Aug 2011 <int>,
#> #   Sep 2011 <int>, Oct 2011 <int>, Nov 2011 <int>, Dec 2011 <int>
```

## Creating a day level cohort table

If we need to track activity on a daily basis, we can instead use the
`cohort_table_month()` function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate)
#> # A tibble: 31 x 32
#>    cohort `2016-04-27` `2016-04-28` `2016-04-29` `2016-04-30` `2016-05-01`
#>     <int>        <int>        <int>        <int>        <int>        <int>
#>  1      1          192           66           55           46           46
#>  2      2           NA          399          118           97           85
#>  3      3           NA           NA          740          209          184
#>  4      4           NA           NA           NA          773          225
#>  5      5           NA           NA           NA           NA          807
#>  6      6           NA           NA           NA           NA           NA
#>  7      7           NA           NA           NA           NA           NA
#>  8      8           NA           NA           NA           NA           NA
#>  9      9           NA           NA           NA           NA           NA
#> 10     10           NA           NA           NA           NA           NA
#> # … with 21 more rows, and 26 more variables: 2016-05-02 <int>,
#> #   2016-05-03 <int>, 2016-05-04 <int>, 2016-05-05 <int>, 2016-05-06 <int>,
#> #   2016-05-07 <int>, 2016-05-08 <int>, 2016-05-09 <int>, 2016-05-10 <int>,
#> #   2016-05-11 <int>, 2016-05-12 <int>, 2016-05-13 <int>, 2016-05-14 <int>,
#> #   2016-05-15 <int>, 2016-05-16 <int>, 2016-05-17 <int>, 2016-05-18 <int>,
#> #   2016-05-19 <int>, 2016-05-20 <int>, 2016-05-21 <int>, 2016-05-22 <int>,
#> #   2016-05-23 <int>, 2016-05-24 <int>, 2016-05-25 <int>, 2016-05-26 <int>,
#> #   2016-05-27 <int>
```

## Converting to percentages

In order to see the percent of remaining customers in subsequent
periods, we can pipe the above code into the `cohort_table_pct()`
function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  cohort_table_pct(decimals = 1)
#> # A tibble: 31 x 32
#>    cohort `2016-04-27` `2016-04-28` `2016-04-29` `2016-04-30` `2016-05-01`
#>     <int>        <dbl>        <dbl>        <dbl>        <dbl>        <dbl>
#>  1      1          100         34.4         28.6         24           24  
#>  2      2           NA        100           29.6         24.3         21.3
#>  3      3           NA         NA          100           28.2         24.9
#>  4      4           NA         NA           NA          100           29.1
#>  5      5           NA         NA           NA           NA          100  
#>  6      6           NA         NA           NA           NA           NA  
#>  7      7           NA         NA           NA           NA           NA  
#>  8      8           NA         NA           NA           NA           NA  
#>  9      9           NA         NA           NA           NA           NA  
#> 10     10           NA         NA           NA           NA           NA  
#> # … with 21 more rows, and 26 more variables: 2016-05-02 <dbl>,
#> #   2016-05-03 <dbl>, 2016-05-04 <dbl>, 2016-05-05 <dbl>, 2016-05-06 <dbl>,
#> #   2016-05-07 <dbl>, 2016-05-08 <dbl>, 2016-05-09 <dbl>, 2016-05-10 <dbl>,
#> #   2016-05-11 <dbl>, 2016-05-12 <dbl>, 2016-05-13 <dbl>, 2016-05-14 <dbl>,
#> #   2016-05-15 <dbl>, 2016-05-16 <dbl>, 2016-05-17 <dbl>, 2016-05-18 <dbl>,
#> #   2016-05-19 <dbl>, 2016-05-20 <dbl>, 2016-05-21 <dbl>, 2016-05-22 <dbl>,
#> #   2016-05-23 <dbl>, 2016-05-24 <dbl>, 2016-05-25 <dbl>, 2016-05-26 <dbl>,
#> #   2016-05-27 <dbl>
```

## Left-shifted cohort tables

Another option is to shift cohort tables left. Here, we align cohorts
such that date columns are replaced by time periods, i.e. t0, t1, t2
etc.

To left-shift a cohort table, we can use the `shift_left()` function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  shift_left()
#> # A tibble: 31 x 32
#>    cohort    t0    t1    t2    t3    t4    t5    t6    t7    t8    t9   t10
#>     <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      1   192    66    55    46    46    46    45    33    35    32    27
#>  2      2   399   118    97    85    83    77    62    74    63    52    59
#>  3      3   740   209   184   153   139   129   116    98    95    89    84
#>  4      4   773   225   177   153   132   124   107   115   114    86    89
#>  5      5   807   228   181   153   131   131   129   104    86    99    86
#>  6      6   648   188   150   126   119   105    85    74    72    59    59
#>  7      7   539   167   129   114   113   102    86    90    75    74    73
#>  8      8   527   143   125    92    73    76    81    63    61    55    55
#>  9      9   531   154   116   113   100    94    89    72    69    63    66
#> 10     10   251    74    58    51    42    42    50    41    42    40    32
#> # … with 21 more rows, and 20 more variables: t11 <dbl>, t12 <dbl>, t13 <dbl>,
#> #   t14 <dbl>, t15 <dbl>, t16 <dbl>, t17 <dbl>, t18 <dbl>, t19 <dbl>,
#> #   t20 <dbl>, t21 <dbl>, t22 <dbl>, t23 <dbl>, t24 <dbl>, t25 <dbl>,
#> #   t26 <dbl>, t27 <dbl>, t28 <dbl>, t29 <dbl>, t30 <dbl>
```

We can also get the raw numbers as percentages.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  shift_left_pct()
#> # A tibble: 31 x 32
#>    cohort    t0    t1    t2    t3    t4    t5    t6    t7    t8    t9   t10
#>     <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1      1   100  34.4  28.6  24    24    24    23.4  17.2  18.2  16.7  14.1
#>  2      2   100  29.6  24.3  21.3  20.8  19.3  15.5  18.5  15.8  13    14.8
#>  3      3   100  28.2  24.9  20.7  18.8  17.4  15.7  13.2  12.8  12    11.4
#>  4      4   100  29.1  22.9  19.8  17.1  16    13.8  14.9  14.7  11.1  11.5
#>  5      5   100  28.3  22.4  19    16.2  16.2  16    12.9  10.7  12.3  10.7
#>  6      6   100  29    23.1  19.4  18.4  16.2  13.1  11.4  11.1   9.1   9.1
#>  7      7   100  31    23.9  21.2  21    18.9  16    16.7  13.9  13.7  13.5
#>  8      8   100  27.1  23.7  17.5  13.9  14.4  15.4  12    11.6  10.4  10.4
#>  9      9   100  29    21.8  21.3  18.8  17.7  16.8  13.6  13    11.9  12.4
#> 10     10   100  29.5  23.1  20.3  16.7  16.7  19.9  16.3  16.7  15.9  12.7
#> # … with 21 more rows, and 20 more variables: t11 <dbl>, t12 <dbl>, t13 <dbl>,
#> #   t14 <dbl>, t15 <dbl>, t16 <dbl>, t17 <dbl>, t18 <dbl>, t19 <dbl>,
#> #   t20 <dbl>, t21 <dbl>, t22 <dbl>, t23 <dbl>, t24 <dbl>, t25 <dbl>,
#> #   t26 <dbl>, t27 <dbl>, t28 <dbl>, t29 <dbl>, t30 <dbl>
```

## Line plots

To visualize the data, we can turn a cohort table into long format and
create a line plot.

In this example, we select only the first seven cohorts.

``` r
library(tidyverse)

gamelaunch_long <- gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  shift_left_pct() %>%
  pivot_longer(-cohort) %>%
  mutate(time = as.numeric(str_remove(name,"t"))) 

gamelaunch_long %>%
  filter(value > 0, cohort <= 7, time > 0) %>%
  ggplot(aes(time, value, colour = factor(cohort), group = cohort)) +
  geom_line(size = 1.5) +
  geom_point(size = 1.5) +
  theme_light()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

## Cohort tables plotted

Another way to plot a cohort table is by means of tiles. In this case we
provide the percentages and colour the tiles accordingly.

``` r
gamelaunch_long %>%
  filter(time > 0, value > 0) %>%
  ggplot(aes(time, reorder(cohort, desc(cohort)))) +
  geom_raster(aes(fill = log(value))) +
  coord_equal(ratio = 1) +
  geom_text(aes(label = glue::glue("{round(value,0)}%")), size = 2, color = "snow") +
  scale_fill_gradient(guide = F) +
  theme_minimal() +
  theme(panel.grid   = element_blank(),
        panel.border = element_blank()) +
  labs(y= "cohort")
```

<img src="man/figures/README-unnamed-chunk-6-1.png" width="100%" />
