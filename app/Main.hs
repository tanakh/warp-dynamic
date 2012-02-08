import Network.Wai.Application.Dynamic

main :: IO ()
main = warpd Config { configApplication = appNull }
