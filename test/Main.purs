module Test.Main where

import Prelude

import Control.Monad.Aff                  (Aff())
import Control.Monad.Eff                  (Eff())
import Control.Monad.Eff.Class            (liftEff)
import Test.Spec                          (describe, it)
import Test.Spec.Runner                   (run)
import Test.Spec.Reporter.Console         (consoleReporter)
import Test.Spec.QuickCheck               (quickCheck)
import Test.QuickCheck                    (test)
import Test.QuickCheck.Laws.Data.Eq       (checkEq)
import Test.QuickCheck.Laws.Data.Semiring (checkSemiring)
import Type.Proxy                         (Proxy(..))

import Test.QuickCheck.Results

prxA :: Proxy Int
prxA = Proxy

main = run [consoleReporter] do
  describe "Results" do
    describe "the Show instance" do
      it "is total" do
        quickCheck \res -> const true (show (res :: Results Int String))
    describe "the Eq instance" do
      it "is law abiding" do
        lift' (checkEq prxA)
    describe "the Semiring instance" do
      it "is law abiding" do
        lift' (checkSemiring prxA)
    describe "the Testable instance" do
      it "is total" do
        quickCheck \res -> const true (test (res :: Results Int String))

lift' :: forall a eff. Eff eff a -> Aff eff a
lift' = liftEff
