# Add a label to a logical vector.

This function is mainly for internal use. It adds a label to a logical
vector, so that the
[`Percent`](https://dmurdoch.github.io/tables/reference/Percent.md)
pseudo-function can ignore it when forming a denominator.

## Usage

``` r
labelSubset(subset, label)
```

## Arguments

- subset:

  A logical vector describing a subset of the dataset.

- label:

  A character label to use to describe this subset in a call to `Equal`
  or `Unequal` within
  [`Percent`](https://dmurdoch.github.io/tables/reference/Percent.md).

## Value

A vector of class `"labelledSubset"` with the label recorded as an
attribute.

## Author

Duncan Murdoch

## See also

[`Percent`](https://dmurdoch.github.io/tables/reference/Percent.md)
