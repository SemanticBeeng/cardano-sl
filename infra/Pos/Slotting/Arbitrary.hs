-- | Arbitrary instances for Pos.Slotting types (infra package)

module Pos.Slotting.Arbitrary () where

import           Test.QuickCheck                   (Arbitrary (..))
import           Test.QuickCheck.Arbitrary.Generic (genericArbitrary, genericShrink)

import           Pos.Slotting.Types                (EpochSlottingData (..))
import           Pos.Core.Arbitrary                ()

instance Arbitrary EpochSlottingData where
    arbitrary = genericArbitrary
    shrink = genericShrink
