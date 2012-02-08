{-# LANGUAGE RecordWildCards #-}

module Network.Wai.Application.Dynamic (
  Config(..),
  warpd,
  ) where

import qualified Config.Dyre as Dyre
import Network.Wai
import Network.Wai.Application.Static
import Network.Wai.Handler.Warp

data Config
  = Config
    { configMiddleware :: Middleware
    }

warpd :: Config -> IO ()
warpd = Dyre.wrapMain $ Dyre.defaultParams
  { Dyre.projectName = "warpd"
  , Dyre.realMain = realMain
  , Dyre.showError = \_ err -> error err
  }

realMain :: Config -> IO ()
realMain Config {..} = do
  run 3000 $ configMiddleware $
    staticApp defaultFileServerSettings
