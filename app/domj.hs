import Control.Lens ((^.))
import Language.Javascript.JSaddle (JSM, jsg, jsf, val, jss, js, valToNumber, fun)

main :: IO ()
main = do
  document <- jsg "document"
  body <- document ^. js "body"
  _ <- document ^. jsf "addEventListener" (val "click", fun (listener document body))
  return ()
  where
    listener doc body _ _ [e] = do
      x <- valToNumber =<< (e ^. js "clientX")
      y <- valToNumber =<< (e ^. js "clientY")
      pElement <- doc ^. jsf "createElement" (val "p")
      _ <- pElement ^. jss "innerHTML" (val ("Clicked: " ++ show (x, y)))
      _ <- body ^. jsf "appendChild" pElement
      return ()
