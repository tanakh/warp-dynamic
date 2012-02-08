{-# LANGUAGE RecordWildCards #-}

module Network.Wai.Application.Dynamic (
  Config(..),
  warpd,  
  appNull,
  ) where

import qualified Config.Dyre as Dyre
import Data.Monoid
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp

data Config
  = Config
    { configApplication :: Application
    }

-- | Null application (always returns 404)
appNull :: Application
appNull _ = return $ ResponseBuilder status404 [] mempty

-- | dynamic warp app
warpd :: Config -> IO ()
warpd = Dyre.wrapMain $ Dyre.defaultParams
  { Dyre.projectName = "warpd"
  , Dyre.realMain = realMain
  , Dyre.showError = \_ err -> error err
  }

realMain :: Config -> IO ()
realMain Config {..} = do
  run 3000 configApplication
