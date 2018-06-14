{-# LANGUAGE FlexibleInstances #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}
{-# OPTIONS_GHC -fno-warn-dodgy-exports #-}

module Tickler.API.Protected.Gen where

import Import

import Data.GenValidity
import Data.GenValidity.Aeson ()
import Data.GenValidity.ByteString ()
import Data.GenValidity.Text ()
import Data.GenValidity.Time ()
import Data.GenValidity.UUID ()
import Data.GenValidity.UUID.Typed ()

import Intray.Data.Gen ()
import Tickler.Data.Gen ()

import Tickler.API.Protected.Types

instance GenUnchecked ItemFilter

instance GenValid ItemFilter

instance GenUnchecked TypedItem

instance GenValid TypedItem where
    genValid = (TypedItem <$> genValid <*> genValid) `suchThat` isValid

instance GenUnchecked a => GenUnchecked (Tickle a)

instance GenValid a => GenValid (Tickle a) where
    genValid =
        (Tickle <$> genValid <*> genValid <*> genValid <*> genValid) `suchThat`
        isValid

instance GenUnchecked TriggerAttempt

instance GenValid TriggerAttempt

instance GenUnchecked EmailTriggerResult

instance GenValid EmailTriggerResult

instance GenUnchecked IntrayTriggerResult

instance GenValid IntrayTriggerResult

instance GenUnchecked TriggeredInfo

instance GenValid TriggeredInfo

instance GenUnchecked a => GenUnchecked (ItemInfo a)

instance GenValid a => GenValid (ItemInfo a) where
    genValid =
        (ItemInfo <$> genValid <*> genValid <*> genValid <*> genValid <*>
         genValid) `suchThat`
        isValid

instance GenUnchecked a => GenUnchecked (TriggerInfo a)

instance GenValid a => GenValid (TriggerInfo a) where
    genValid = (TriggerInfo <$> genValid <*> genValid) `suchThat` isValid

instance GenUnchecked TypedTriggerInfo

instance GenValid TypedTriggerInfo where
    genValid = (TypedTriggerInfo <$> genValid <*> genValid) `suchThat` isValid

instance GenUnchecked IntrayTriggerInfo

instance GenValid IntrayTriggerInfo where
    genValid = (IntrayTriggerInfo <$> genValid) `suchThat` isValid

instance GenUnchecked EmailTriggerInfo

instance GenValid EmailTriggerInfo where
    genValid = (EmailTriggerInfo <$> genValid) `suchThat` isValid

instance GenUnchecked AddIntrayTrigger

instance GenValid AddIntrayTrigger where
    genValid =
        (AddIntrayTrigger <$> genValid <*> genValid <*> genValid) `suchThat`
        isValid

instance GenUnchecked AddEmailTrigger

instance GenValid AddEmailTrigger where
    genValid = (AddEmailTrigger <$> genValid) `suchThat` isValid

instance GenUnchecked SyncRequest

instance GenValid SyncRequest where
    genValid = (SyncRequest <$> genValid) `suchThat` isValid

instance GenUnchecked SyncResponse

instance GenValid SyncResponse where
    genValid = (SyncResponse <$> genValid) `suchThat` isValid
