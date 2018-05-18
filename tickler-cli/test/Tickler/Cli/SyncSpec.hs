{-# LANGUAGE OverloadedStrings #-}

module Tickler.Cli.SyncSpec
    ( spec
    ) where

import TestImport

import qualified Data.Text as T

import Servant.API
import Servant.Client

import Tickler.Client
import Tickler.Server.TestUtils

import Tickler.Cli.LastSeen (readLastSeen)
import Tickler.Cli.OptParse
import Tickler.Cli.Session (loadToken)
import Tickler.Cli.TestUtils

spec :: Spec
spec =
    withTicklerServer $
    it "correctly deletes the local LastSeen after a sync if the item has dissappeared remotely" $ \cenv ->
        forAllValid $ \ti ->
            withValidNewUserAndData cenv $ \un pw _ -> do
                let (ClientEnv _ burl _) = cenv
                let u = T.unpack $ usernameText un
                let p = T.unpack pw
                let d = "/tmp"
                dir <- resolveDir' d
                tickler
                    [ "login"
                    , "--username"
                    , u
                    , "--password"
                    , p
                    , "--url"
                    , showBaseUrl burl
                    , "--tickler-dir"
                    , d
                    ]
                let sets =
                        Settings
                        { setBaseUrl = Just burl
                        , setUsername = Just un
                        , setTicklerDir = dir
                        , setSyncStrategy = NeverSync
                        }
                mToken <- runReaderT loadToken sets
                token <-
                    case mToken of
                        Nothing -> do
                            expectationFailure
                                "Should have a token after logging in"
                            undefined
                        Just t -> pure t
                uuid <- runClientOrError cenv $ clientPostAddItem token ti
                tickler ["sync", "--url", showBaseUrl burl, "--tickler-dir", d]
                tickler ["show", "--url", showBaseUrl burl, "--tickler-dir", d]
                mLastSeen1 <- runReaderT readLastSeen sets
                mLastSeen1 `shouldSatisfy` isJust
                NoContent <- runClientOrError cenv $ clientDeleteItem token uuid
                tickler ["sync", "--url", showBaseUrl burl, "--tickler-dir", d]
                mLastSeen2 <- runReaderT readLastSeen sets
                mLastSeen2 `shouldSatisfy` isNothing
