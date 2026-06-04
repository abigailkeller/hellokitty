# Hello Kitty Color Palettes

<!-- badges: start -->

[![R-CMD-check](https://github.com/abigailkeller/hellokitty/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/abigailkeller/hellokitty/actions/workflows/R-CMD-check.yaml)

<!-- badges: end -->

## Installation

``` r
```

**Or the development version**

``` r
devtools::install_github("abigailkeller/hellokitty")
```

## Usage

``` r
library(hellokitty)

# See all palettes
names(hkitty_palettes)
#> [1] "hellokitty1" "hellokitty2"
```

## Palettes

`hellokitty` contains two color palettes:

### Hello Kitty Palette 1

<img src="figure/hellokitty1.webp" style="height:2in" />

[Image Source](https://hellokitty.fandom.com/wiki/Hello_Kitty)

``` r
hkitty_palette("hellokitty1")
```

![](figure/hellokitty1-1.png)

<img src="figure/hellokitty2.jpg" style="height:2in" />

### Hello Kitty Palette 2

[Image
Source](https://www.parents.com/why-is-hello-kitty-so-popular-11851589)

``` r
hkitty_palette("hellokitty2")
```

![](figure/hellokitty2-1.png)

## Example usage

The `hellokitty` package can be used to create both discrete and
continuous color scales.

### Example 1: Discrete color scale

First we will get data showing the number of Pacific salmon returning to
the Columbia River Basin based on visual observations at Bonneville Dam.

``` r
library(tidyverse)
#> ── [1mAttaching core tidyverse packages[22m ──────────────────────── tidyverse 2.0.0 ──
#> [32m✔[39m [34mdplyr    [39m 1.2.1     [32m✔[39m [34mreadr    [39m 2.2.0
#> [32m✔[39m [34mforcats  [39m 1.0.1     [32m✔[39m [34mstringr  [39m 1.6.0
#> [32m✔[39m [34mggplot2  [39m 4.0.3     [32m✔[39m [34mtibble   [39m 3.3.1
#> [32m✔[39m [34mlubridate[39m 1.9.5     [32m✔[39m [34mtidyr    [39m 1.3.2
#> [32m✔[39m [34mpurrr    [39m 1.2.2     
#> ── [1mConflicts[22m ────────────────────────────────────────── tidyverse_conflicts() ──
#> [31m✖[39m [34mdplyr[39m::[32mfilter()[39m masks [34mstats[39m::filter()
#> [31m✖[39m [34mdplyr[39m::[32mlag()[39m    masks [34mstats[39m::lag()
#> [36mℹ[39m Use the conflicted package ([3m[34m<http://conflicted.r-lib.org/>[39m[23m) to force all conflicts to become errors

# get CRB salmon
salmon <- c("Chinook", "Chum", "Coho", "Pink", "Sockeye")
CRB_salmon <- CRB_long[CRB_long$Species %in% salmon, ]
```

We will then create a discrete color palette based on the different
salmon species.

``` r
n_colors <- length(salmon)
pal1 <- hkitty_palette(name = "hellokitty2", n = n_colors, type = "discrete")
```

And we will plot the counts of salmon returns to Bonneville Dam over
time:

``` r
ggplot(data = CRB_salmon) +
  geom_line(aes(x = year_label, y = total_value, color = Species)) +
  scale_color_manual(values = pal1) +
  labs(x = "Year", y = "Count", color = "Species") +
  ggtitle(paste0("Annual counts of salmon returns to Bonneville\nDam in the ", 
                 "Columbia River Basin")) +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14),
        legend.title = element_text(hjust = 0.5)
  )
#> Warning: [1m[22mRemoved 5 rows containing missing values or values outside the scale range
#> (`geom_line()`).
```

![](figure/unnamed-chunk-4-1.png)

### Example 2: Continuous color scale

Now we will get a continuous color scale:

``` r
pal2 <- hkitty_palette(name = "hellokitty1", type = "continuous")
```

And use it to plot the relationship between the count of Chinook salmon,
shad, and lamprey returning to the Columbia River:

``` r
ggplot(data = CRB_wide[CRB_wide$Lamprey > 0, ]) +
  geom_point(aes(x = log(Chinook), y = log(Shad), color = log(Lamprey))) +
  scale_color_gradientn(colors = pal2) +
  labs(x = "Chinook (log count)", y = "Shad (log count)", 
       color = "Lamprey\n (log count)") +
  ggtitle("Fish co-occurrence in the Columbia River Basin") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, size = 14),
        legend.title = element_text(hjust = 0.5)
  )
```

![](figure/unnamed-chunk-6-1.png)

### Notes

Code adapted from the
[wesanderson](https://github.com/karthik/wesanderson/tree/master) R
package.
