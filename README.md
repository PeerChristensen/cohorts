
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cohorts

<!-- badges: start -->
<!-- badges: end -->

Creating cohort tables from event data is complicated and requires
several lines of code. The cohorts package lets users convert data
frames to cohort tables in both long and wide formats with simple
functions. Users may choose between day and month level cohorts.

## Installation

You can install the released version of cohorts from
[CRAN](https://CRAN.R-project.org) with:

``` r
#install.packages("cohorts")
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
  cohort_table_month(CustomerID, InvoiceDate)  %>%
  head()
#> # A tibble: 6 x 14
#>   cohort `Dec 2010` `Jan 2011` `Feb 2011` `Mar 2011` `Apr 2011` `May 2011`
#>    <int>      <int>      <int>      <int>      <int>      <int>      <int>
#> 1      1       1423        622        522        666        539        655
#> 2      2         NA        514        127        163        132        201
#> 3      3         NA         NA        451        122         97        135
#> 4      4         NA         NA         NA        509        106        155
#> 5      5         NA         NA         NA         NA        362         98
#> 6      6         NA         NA         NA         NA         NA        336
#> # … with 7 more variables: Jun 2011 <int>, Jul 2011 <int>, Aug 2011 <int>,
#> #   Sep 2011 <int>, Oct 2011 <int>, Nov 2011 <int>, Dec 2011 <int>
```

## Creating a day level cohort table

If we need to track activity on a daily basis, we can instead use the
`cohort_table_month()` function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  head()
#> # A tibble: 6 x 32
#>   cohort `2016-04-27` `2016-04-28` `2016-04-29` `2016-04-30` `2016-05-01`
#>    <int>        <int>        <int>        <int>        <int>        <int>
#> 1      1          192           66           55           46           46
#> 2      2           NA          399          118           97           85
#> 3      3           NA           NA          740          209          184
#> 4      4           NA           NA           NA          773          225
#> 5      5           NA           NA           NA           NA          807
#> 6      6           NA           NA           NA           NA           NA
#> # … with 26 more variables: 2016-05-02 <int>, 2016-05-03 <int>,
#> #   2016-05-04 <int>, 2016-05-05 <int>, 2016-05-06 <int>, 2016-05-07 <int>,
#> #   2016-05-08 <int>, 2016-05-09 <int>, 2016-05-10 <int>, 2016-05-11 <int>,
#> #   2016-05-12 <int>, 2016-05-13 <int>, 2016-05-14 <int>, 2016-05-15 <int>,
#> #   2016-05-16 <int>, 2016-05-17 <int>, 2016-05-18 <int>, 2016-05-19 <int>,
#> #   2016-05-20 <int>, 2016-05-21 <int>, 2016-05-22 <int>, 2016-05-23 <int>,
#> #   2016-05-24 <int>, 2016-05-25 <int>, 2016-05-26 <int>, 2016-05-27 <int>
```

## Converting to percentages

In order to see the percent of remaining customers in subsequent
periods, we can pipe the above code into the `cohort_table_pct()`
function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  cohort_table_pct(decimals = 1) %>%
  head()
#>   cohort 2016-04-27 2016-04-28 2016-04-29 2016-04-30 2016-05-01 2016-05-02
#> 1      1        100       34.4       28.6       24.0       24.0       24.0
#> 2      2         NA      100.0       29.6       24.3       21.3       20.8
#> 3      3         NA         NA      100.0       28.2       24.9       20.7
#> 4      4         NA         NA         NA      100.0       29.1       22.9
#> 5      5         NA         NA         NA         NA      100.0       28.3
#> 6      6         NA         NA         NA         NA         NA      100.0
#>   2016-05-03 2016-05-04 2016-05-05 2016-05-06 2016-05-07 2016-05-08 2016-05-09
#> 1       23.4       17.2       18.2       16.7       14.1       17.7       17.2
#> 2       19.3       15.5       18.5       15.8       13.0       14.8       14.5
#> 3       18.8       17.4       15.7       13.2       12.8       12.0       11.4
#> 4       19.8       17.1       16.0       13.8       14.9       14.7       11.1
#> 5       22.4       19.0       16.2       16.2       16.0       12.9       10.7
#> 6       29.0       23.1       19.4       18.4       16.2       13.1       11.4
#>   2016-05-10 2016-05-11 2016-05-12 2016-05-13 2016-05-14 2016-05-15 2016-05-16
#> 1       13.0       13.0       14.6       14.6       10.9       14.1        9.9
#> 2       11.8       13.5       11.5       12.5       12.5        8.3       10.0
#> 3        9.5        9.5        9.9        9.6        9.5        8.6        7.6
#> 4       11.5       10.7        9.7        9.3       10.7        9.4        7.5
#> 5       12.3       10.7       10.0       10.4        9.8       10.5        9.5
#> 6       11.1        9.1        9.1        9.1        9.9        8.6        8.0
#>   2016-05-17 2016-05-18 2016-05-19 2016-05-20 2016-05-21 2016-05-22 2016-05-23
#> 1       12.5       12.0        8.3       10.4        6.8       12.0       10.9
#> 2       10.0        8.3        9.0        9.8        8.0        6.8        7.3
#> 3        7.7        6.6        7.3        7.6        6.5        6.4        5.8
#> 4        8.7        8.9        7.9        7.4        8.0        7.4        6.6
#> 5        8.7        7.3        5.7        7.7        7.7        6.6        5.9
#> 6        7.3        7.3        6.6        8.3        6.8        8.2        6.2
#>   2016-05-24 2016-05-25 2016-05-26 2016-05-27
#> 1        8.9        8.3        7.8        8.3
#> 2        8.0        7.5        7.3        6.3
#> 3        6.1        6.2        6.1        7.3
#> 4        6.3        6.3        6.0        6.1
#> 5        5.2        5.7        5.2        5.0
#> 6        6.3        6.0        5.9        5.2
```

## Left-shifted cohort tables

Another option is to shift cohort tables left. Here, we align cohorts
such that date columns are replaced by time periods, i.e. t0, t1, t2
etc.

To left-shift a cohort table, we can use the `shift_left()` function.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  shift_left() %>%
  head()
#> # A tibble: 6 x 32
#>   cohort    t0    t1    t2    t3    t4    t5    t6    t7    t8    t9   t10   t11
#>    <int> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#> 1      1   192    66    55    46    46    46    45    33    35    32    27    34
#> 2      2   399   118    97    85    83    77    62    74    63    52    59    58
#> 3      3   740   209   184   153   139   129   116    98    95    89    84    70
#> 4      4   773   225   177   153   132   124   107   115   114    86    89    83
#> 5      5   807   228   181   153   131   131   129   104    86    99    86    81
#> 6      6   648   188   150   126   119   105    85    74    72    59    59    59
#> # … with 19 more variables: t12 <dbl>, t13 <dbl>, t14 <dbl>, t15 <dbl>,
#> #   t16 <dbl>, t17 <dbl>, t18 <dbl>, t19 <dbl>, t20 <dbl>, t21 <dbl>,
#> #   t22 <dbl>, t23 <dbl>, t24 <dbl>, t25 <dbl>, t26 <dbl>, t27 <dbl>,
#> #   t28 <dbl>, t29 <dbl>, t30 <dbl>
```

We can also get the raw numbers as percentages.

``` r
gamelaunch %>%
  cohort_table_day(userid, eventDate) %>%
  shift_left_pct() %>%
  head()
#>   cohort  t0   t1   t2   t3   t4   t5   t6   t7   t8   t9  t10  t11  t12  t13
#> 1      1 100 34.4 28.6 24.0 24.0 24.0 23.4 17.2 18.2 16.7 14.1 17.7 17.2 13.0
#> 2      2 100 29.6 24.3 21.3 20.8 19.3 15.5 18.5 15.8 13.0 14.8 14.5 11.8 13.5
#> 3      3 100 28.2 24.9 20.7 18.8 17.4 15.7 13.2 12.8 12.0 11.4  9.5  9.5  9.9
#> 4      4 100 29.1 22.9 19.8 17.1 16.0 13.8 14.9 14.7 11.1 11.5 10.7  9.7  9.3
#> 5      5 100 28.3 22.4 19.0 16.2 16.2 16.0 12.9 10.7 12.3 10.7 10.0 10.4  9.8
#> 6      6 100 29.0 23.1 19.4 18.4 16.2 13.1 11.4 11.1  9.1  9.1  9.1  9.9  8.6
#>    t14  t15  t16  t17  t18  t19  t20  t21 t22  t23 t24  t25  t26 t27 t28 t29
#> 1 13.0 14.6 14.6 10.9 14.1  9.9 12.5 12.0 8.3 10.4 6.8 12.0 10.9 8.9 8.3 7.8
#> 2 11.5 12.5 12.5  8.3 10.0 10.0  8.3  9.0 9.8  8.0 6.8  7.3  8.0 7.5 7.3 6.3
#> 3  9.6  9.5  8.6  7.6  7.7  6.6  7.3  7.6 6.5  6.4 5.8  6.1  6.2 6.1 7.3 0.0
#> 4 10.7  9.4  7.5  8.7  8.9  7.9  7.4  8.0 7.4  6.6 6.3  6.3  6.0 6.1 0.0 0.0
#> 5 10.5  9.5  8.7  7.3  5.7  7.7  7.7  6.6 5.9  5.2 5.7  5.2  5.0 0.0 0.0 0.0
#> 6  8.0  7.3  7.3  6.6  8.3  6.8  8.2  6.2 6.3  6.0 5.9  5.2  0.0 0.0 0.0 0.0
#>   t30
#> 1 8.3
#> 2 0.0
#> 3 0.0
#> 4 0.0
#> 5 0.0
#> 6 0.0
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

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" /> \#\#
Cohort tables plotted

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
