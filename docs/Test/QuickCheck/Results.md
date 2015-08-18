## Module Test.QuickCheck.Results

#### `Results`

``` purescript
data Results fail pass
  = Fails (Set fail)
  | Passes (Set pass)
```

The type of results with multiple passes or failures.

##### Instances
``` purescript
instance showResults :: (Show fail, Show pass) => Show (Results fail pass)
instance eqResults :: (Eq fail, Eq pass) => Eq (Results fail pass)
instance semiringResults :: (Ord fail, Ord pass) => Semiring (Results fail pass)
instance testableResults :: (Show fail) => Testable (Results fail pass)
instance arbResults :: (Arbitrary fail, Arbitrary pass, Ord fail, Ord pass) => Arbitrary (Results fail pass)
```


