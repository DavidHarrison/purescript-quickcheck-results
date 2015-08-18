module Test.QuickCheck.Results where

import Prelude

import Data.Set                  (Set(), empty, fromList, union)
import Data.Foldable             (Foldable, foldl)
import Data.List                 (toList)
import Data.Monoid               (Monoid, mempty)
import Data.Tuple                (Tuple(..), snd)
import Test.QuickCheck           (Testable, Result(..), test)
import Test.QuickCheck.Arbitrary (Arbitrary, arbitrary)
import Test.QuickCheck.Gen       (Gen(), arrayOf, oneOf)

-- Could probably be replaced with Either, but this allows pattern matching
-- and declaring instances more easily
data Results fail pass = Fails (Set fail) | Passes (Set pass)

instance showResults :: (Show fail, Show pass) => Show (Results fail pass) where
  show (Fails  fails ) = "(Fails "  <> show fails  <> ")"
  show (Passes passes) = "(Passes " <> show passes <> ")"

instance eqResults :: (Eq fail, Eq pass) => Eq (Results fail pass) where
  eq (Fails  a) (Fails  b) = a == b
  eq (Passes a) (Passes b) = a == b
  eq _          _          = false

instance semiringResults :: (Ord fail, Ord pass) => Semiring (Results fail pass) where
  one                       = Passes empty
  mul (Fails a)  (Fails b)  = Fails (a `union` b)
  mul (Fails a)  _          = Fails a
  mul _          (Fails a)  = Fails a
  mul (Passes a) (Passes b) = Passes (a `union` b)
  zero                      = Fails empty
  add (Passes a) (Passes b) = Passes (a `union` b)
  add (Passes a) _          = Passes a
  add _          (Passes a) = Passes a
  add fail       _          = fail

instance testableResults :: (Show fail) => Testable (Results fail pass) where
  test (Passes _    ) = return Success
  test (Fails  fails) = return (Failed (intercalateMap show "\n" fails))

intercalateMap :: forall f a b. (Foldable f, Monoid b) => (a -> b) -> b -> f a -> b
intercalateMap f sep = snd <<< (foldl iter (Tuple true mempty))
  where iter (Tuple init acc) x = if init
                                     then Tuple false (f x)
                                     else Tuple false (acc <> sep <> f x)

instance arbResults :: (Arbitrary fail, Arbitrary pass, Ord fail, Ord pass) => Arbitrary (Results fail pass) where
  arbitrary = oneOf (Fails <$> arbSet) [Passes <$> arbSet]

arbSet :: forall a. (Arbitrary a, Ord a) => Gen (Set a)
arbSet = fromList <<< toList <$> arrayOf arbitrary
