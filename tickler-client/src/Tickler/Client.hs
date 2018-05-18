{-# LANGUAGE DataKinds #-}

module Tickler.Client
    ( clientGetShowItem
    , clientGetSize
    , clientGetItemUUIDs
    , clientGetItems
    , clientPostAddItem
    , clientGetItem
    , clientDeleteItem
    , clientPostSync
    , clientPostRegister
    , clientPostLogin
    , clientGetDocs
    , clientGetAccountInfo
    , clientGetAccountSettings
    , clientPutAccountSettings
    , clientDeleteAccount
    , clientAdminGetStats
    , clientAdminDeleteAccount
    , clientAdminGetAccounts
    , ItemType(..)
    , TypedItem(..)
    , textTypedItem
    , TypedItemCase(..)
    , typedItemCase
    , ItemInfo(..)
    , AddItem(..)
    , SyncRequest(..)
    , NewSyncItem(..)
    , SyncResponse(..)
    , AccountInfo(..)
    , AccountSettings(..)
    , Registration(..)
    , LoginForm(..)
    , GetDocsResponse(..)
    , AdminStats(..)
    , ItemUUID
    , AccountUUID
    , Username
    , parseUsername
    , parseUsernameWithError
    , usernameText
    , NoContent(..)
    , Token
    , module Data.UUID.Typed
    ) where

import Import

import qualified Data.UUID.Typed
import Servant.API
import Servant.API.Flatten
import Servant.Auth.Client
import Servant.Auth.Server
import Servant.Auth.Server.SetCookieOrphan ()
import Servant.Client

import Tickler.API

clientGetShowItem :: Token -> ClientM (Maybe (ItemInfo TypedItem))
clientGetSize :: Token -> ClientM Int
clientGetItemUUIDs :: Token -> ClientM [ItemUUID]
clientGetItems :: Token -> ClientM [ItemInfo TypedItem]
clientPostAddItem :: Token -> AddItem -> ClientM ItemUUID
clientGetItem :: Token -> ItemUUID -> ClientM (ItemInfo TypedItem)
clientDeleteItem :: Token -> ItemUUID -> ClientM NoContent
clientPostSync :: Token -> SyncRequest -> ClientM SyncResponse
clientGetAccountInfo :: Token -> ClientM AccountInfo
clientGetAccountSettings :: Token -> ClientM AccountSettings
clientPutAccountSettings :: Token -> AccountSettings -> ClientM NoContent
clientDeleteAccount :: Token -> ClientM NoContent
clientPostRegister :: Registration -> ClientM NoContent
clientPostLogin ::
       LoginForm
    -> ClientM (Headers '[ Header "Set-Cookie" SetCookie, Header "Set-Cookie" SetCookie] NoContent)
clientGetDocs :: ClientM GetDocsResponse
clientAdminGetStats :: Token -> ClientM AdminStats
clientAdminDeleteAccount :: Token -> AccountUUID -> ClientM NoContent
clientAdminGetAccounts :: Token -> ClientM [AccountInfo]
clientGetShowItem :<|> clientGetSize :<|> clientGetItemUUIDs :<|> clientGetItems :<|> clientPostAddItem :<|> clientGetItem :<|> clientDeleteItem :<|> clientPostSync :<|> clientGetAccountInfo :<|> clientGetAccountSettings :<|> clientPutAccountSettings :<|> clientDeleteAccount :<|> clientPostRegister :<|> clientPostLogin :<|> clientGetDocs :<|> clientAdminGetStats :<|> clientAdminDeleteAccount :<|> clientAdminGetAccounts =
    client (flatten ticklerAPI)
