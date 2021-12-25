module Main where 
import LI12122
import Tarefa4_2021li1g030
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game

type Imagem = Mapa
type ImagemGloss = (Coordenadas, (Imagem, (Picture, Picture, Picture)))

estadoInicial :: Imagem
estadoInicial = [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
                ,[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
                ,[Porta, Vazio, Vazio, Vazio, Caixa, Vazio, Bloco]
                ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]]

estadoGlossInicial :: Coordenadas -> Picture -> Picture -> Picture -> ImagemGloss
estadoGlossInicial (0,0) bloco caixa porta = ((0,0),(estadoInicial, (bloco,caixa,porta)))

draw :: ImagemGloss -> Picture
draw  (_,([[]],(bloco,caixa,porta))) = Blank
draw ((x,y),(([]:tt),(bloco,caixa,porta))) = draw ((0,y + 1),((tt),(bloco,caixa,porta)))
draw estadoGlossInicial@((x,y),(((h:t):tt),(bloco,caixa,porta)))
  | h == Bloco = pictures [translate (xx) (yy) $ scale 0.1 0.1 bloco , (draw ((x +1, y),(((t:tt),(bloco,caixa,porta)))))]
  | h == Porta = pictures [translate (xx) (yy) $ scale 0.25 0.13 porta, (draw ((x +1, y),(((t:tt),(bloco,caixa,porta)))))]
  | h == Caixa = pictures [translate (xx) (yy) $ scale 0.1 0.1 caixa , (draw ((x +1, y),(((t:tt),(bloco,caixa,porta)))))]
  | otherwise = pictures [translate (xx) (yy) $ Blank , (draw ((x +1, y),(((t:tt),(bloco,caixa,porta)))))]
    where
         xx = fromIntegral (x * (40))
         yy = fromIntegral (y * (-40))

reageEvento :: Event -> ImagemGloss -> ImagemGloss
reageEvento (EventKey (SpecialKey KeyUp) Down _ _)    ((x,y),(((h:t):tt),(bloco,caixa,porta))) = ((x,y),(((h:t):tt),(bloco,caixa,porta)))
reageEvento (EventKey (SpecialKey KeyDown) Down _ _)  ((x,y),(((h:t):tt),(bloco,caixa,porta))) = ((x,y),(((h:t):tt),(bloco,caixa,porta)))
reageEvento (EventKey (SpecialKey KeyLeft) Down _ _)  ((x,y),(((h:t):tt),(bloco,caixa,porta))) = ((x,y),(((h:t):tt),(bloco,caixa,porta)))
reageEvento (EventKey (SpecialKey KeyRight) Down _ _) ((x,y),(((h:t):tt),(bloco,caixa,porta))) = ((x,y),(((h:t):tt),(bloco,caixa,porta)))
reageEvento _ s = s -- ignora qualquer outro evento 

reageTempo :: Float -> ImagemGloss -> ImagemGloss
reageTempo n ((x,y),(((h:t):tt),(bloco,caixa,porta))) = ((x,y),(((h:t):tt),(bloco,caixa,porta)))
 where
    xx = fromIntegral x
    yy = fromIntegral y

fr :: Int 
fr = 50

dm :: Display
dm = InWindow "Novo Jogo" (720, 400) (0,0)

main :: IO ()
main = do 
    bloco <- loadBMP "assets/bloco.bmp"
    caixa <- loadBMP "assets/caixa.bmp"
    porta <- loadBMP "assets/door.bmp" 
    play dm -- janela onde irá correr o jogo
          (greyN 0.5) -- côr do fundo da janela
          fr -- frame rate
          (estadoGlossInicial (0,0) bloco caixa porta) -- estado inicial
          draw -- desenha o estado do jogo
          reageEvento -- reage a um evento
          reageTempo -- reage ao passar do tempo
