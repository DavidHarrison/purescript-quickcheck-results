# purescript-lists

[![Latest release](http://img.shields.io/bower/v/purescript-quickcheck-results.svg)](https://github.com/DavidHarrison/purescript-quickcheck-results/releases)
[![Build Status](https://travis-ci.org/DavidHarrison/purescript-quickcheck-results.svg?branch=master)](https://travis-ci.org/DavidHarrison/purescript-quickcheck-results)
[![Dependency Status](https://www.versioneye.com/user/projects/55d2bee5265ff6001a00018e/badge.svg?style=flat)](https://www.versioneye.com/user/projects/55d2bee5265ff6001a00018e)

`Results fail pass` is a datatype isomorphic to `Either (Set fail) (Set pass)` with both `Testable` and `Semiring` instances. This allows properties to be combined similarly to `Booleans`:

## Installation

```
bower install purescript-quickcheck-results
```

## Module documentation

- [Test.QuickCheck.Results](docs/Test/QuickCheck/Results.md)
