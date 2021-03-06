module Tickler.Server.Types where

import Control.Monad.Reader

import Database.Persist.Sqlite

import Servant
import Servant.Auth.Server

import Tickler.API

data TicklerServerEnv = TicklerServerEnv
    { envConnectionPool :: ConnectionPool
    , envCookieSettings :: CookieSettings
    , envJWTSettings :: JWTSettings
    , envAdmins :: [Username]
    }

type TicklerHandler = ReaderT TicklerServerEnv Handler
