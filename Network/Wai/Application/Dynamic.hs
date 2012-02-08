{-# LANGUAGE RecordWildCards #-}

module Network.Wai.Application.Dynamic (
  Config(..),
  warpd,
  
  def, nullApp,
  ) where

import qualified Config.Dyre as Dyre
import Data.Default
import Data.Monoid
import Network.HTTP.Types
import Network.Wai
import Network.Wai.Handler.Warp

-- | HTTP config
data Config
  = Config
    { warpSettings :: Settings    -- ^ Warp settings
    , application  :: Application -- ^ Application to serve
    }

instance Default Config where
  def = Config
    { warpSettings = defaultSettings
    , application = nullApp
    }

-- | Null application (always returns 404)
nullApp :: Application
nullApp _ = return $ ResponseBuilder status404 [] mempty

-- | dynamic warp app
warpd :: Config -> IO ()
warpd = Dyre.wrapMain $ Dyre.defaultParams
  { Dyre.projectName = "warpd"
  , Dyre.realMain = realMain
  , Dyre.showError = \_ err -> error err
  }

realMain :: Config -> IO ()
realMain Config {..} = do
  runSettings warpSettings application
