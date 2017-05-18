import Control.Lens ((^.))
import Data.JSString (pack)
import GHCJS.Types (JSVal, jsval)
import JavaScript.Array (fromList)
import Language.Javascript.JSaddle (JSM, jsg, jsf, MakeArgs, val, runJSaddle)

foreign import javascript unsafe "console.log($1)"
  consoleLogF :: JSVal -> IO ()

consoleLogJ :: (MakeArgs args) => args -> JSM ()
consoleLogJ x = do
  c <- jsg "console"
  _ <- c ^. jsf "log" x
  return ()

main :: IO ()
main = do
  let
    s1 = "Hello, world!"
    s2 = ["Hello, ", "world!"]
  consoleLogF $ jsval $ pack s1
  consoleLogF $ jsval $ fromList $ map (jsval . pack) s2
  runJSaddle () $ do
    consoleLogJ $ val s1
    consoleLogJ $ val s2
