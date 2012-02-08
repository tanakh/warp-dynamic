{-# LANGUAGE OverloadedStrings #-}

import Network.Wai.Application.Dynamic
import Network.Wai.Application.Static

main :: IO ()
main = warpd def
  { application = staticApp defaultFileServerSettings
  }
