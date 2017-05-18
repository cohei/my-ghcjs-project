import GHCJS.DOM (currentDocument)
import GHCJS.DOM.Document (getBody, createElement)
import GHCJS.DOM.Element (setInnerHTML)
import GHCJS.DOM.EventM (on, mouseClientXY)
import GHCJS.DOM.GlobalEventHandlers (click)
import GHCJS.DOM.Node (appendChild)

main :: IO ()
main = do
  Just document <- currentDocument
  Just body <- getBody document
  _ <- on document click $ handler document body
  return ()
  where
    handler doc body = do
      (x, y) <- mouseClientXY
      pElement <- createElement doc "p"
      setInnerHTML pElement $ Just $ "Clicked: " ++ show (x, y)
      appendChild body pElement
      return ()
