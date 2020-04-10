
<!-- README.md is generated from README.Rmd. Please edit that file -->

# avitcaf

<!-- badges: start -->

<!-- badges: end -->

The goal of avitcaf is to extract news content from a wire service (that
I can’t even name it here).

## Installation

``` r
remotes::install_github("chainsawriot/avitcaf")
```

## Data collection

Please refer to the following two screenshots and use your imagination.

<img src="man/figures/save1.png" align="center" height="400" />

<img src="man/figures/save2.png" align="center" height="400" />

## Usage

``` r
avitcaf::avitcaf("nypost.html")
#> # A tibble: 100 x 4
#>    pubdate   headline               lede                body               
#>    <chr>     <chr>                  <chr>               <chr>              
#>  1 18 Janua… "Deadly virus prompts… "Federal health of… "The CDC said the …
#>  2 21 Janua… "China virus 'pandemi… "China on Monday r… "The infection can…
#>  3 22 Janua… "Chinese neo-virus re… "The new virus swe… "The unidentified …
#>  4 23 Janua… "Virus 'quarantine' T… "The Chinese city … "Buses, subways, f…
#>  5 23 Janua… "Game app livens up a… "Chinese gamers ar… "Developed by UK-b…
#>  6 24 Janua… "Bug 'bred' in wildli… "Chinese health of… "\"Freshly slaught…
#>  7 24 Janua… "US patient might hav… "The lone American… "He had been home …
#>  8 24 Janua… "Queasy Huawei\r\n"    "Telecom giant Hua… "The conference, b…
#>  9 24 Janua… "Eerie parallels to d… "The coronavirus c… "The flick's endin…
#> 10 24 Janua… "'A state of war' vs.… "The Chinese city … "Public-health aut…
#> # … with 90 more rows
```
