module Main where
import LI12122
import Mapas
import Tarefa3_2021li1g030
import Tarefa4_2021li1g030
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy (loadJuicy)

data Opcoes = Jogar
            | Titulo
            | Sair

data Menu = Controlador Opcoes
          | EmJogo

type GameWorld = (Menu, Coordenadas, Int, (Jogo, (Picture, Picture, Picture, Picture, Picture)))

levels :: [Jogo]
levels = [m1,m2,m3,m4,m5]

estadoInicial :: Int -> Jogo
estadoInicial level = levels!!level

estadoGlossInicial :: Coordenadas -> Picture -> Picture -> Picture -> Picture -> Picture -> GameWorld
estadoGlossInicial (0,0) bloco caixa porta playerE playerW = (Controlador Jogar, (0,0), 0, (estadoInicial 0, (bloco,caixa,porta,playerE,playerW)))


draw :: GameWorld -> Picture
draw (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = Pictures [Color blue $ Translate (0) (-120) $ drawOption "Jogar", drawOption1 "Block Dude" , drawOption "Sair"]
draw (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = Pictures [Color blue $ Translate (0) (-120) $ drawOption "Sair", drawOption1 "Block Dude" ,  drawOption "Jogar"]

draw  (EmJogo, (x,y), level,(Jogo [[]] (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = Blank
draw (EmJogo, (x,y), level, (Jogo ([]:tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = draw (EmJogo, (0,y + 1), level, (Jogo (tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
draw estadoGlossInicial@(EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
  | level == length levels =
    pictures [Color blue $ Translate (0) (-120) $ drawOption "Obrigado Por Jogar", drawOption1 "Trabalho Realizado por: David Teixeira & Adriana Frazão"]
  | (x,y) == (x2,y2) && dir == Este = 
    pictures [translate (xx) (yy) $ scale 0.25 0.15 playerE, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | (x,y) == (x2,y2) && dir == Oeste = 
    pictures [translate (xx) (yy) $ scale 0.25 0.15 playerW, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Bloco = 
    pictures [translate (xx) (yy) $ scale 0.1 0.1 bloco , (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Porta = 
    pictures [translate (xx) (yy) $ scale 0.25 0.13 porta, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Caixa = 
    pictures [translate (xx) (yy) $ scale 0.1 0.1 caixa , (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | otherwise = 
    pictures [translate (xx) (yy) $ Blank , (draw (EmJogo, (x +1, y), level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
    where
         xx = (fromIntegral (x * (40)))  - 190
         yy = (fromIntegral (y * (-40))) + 90

drawOption option = Translate (-110) (-70) $ Scale (0.75) (0.75) $ Text option
drawOption1 option = Translate (-350) (100) $ Scale (1.0) (1.0) $ Text option


reageEvento :: Event -> GameWorld -> GameWorld

reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  undefined


reageEvento (EventKey (SpecialKey KeyLeft) Down _ _) (EmJogo, (x,y), level, (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) 
  | (((h:t):tt)!!y2!!(x2-1) == Porta) = 
    if level+1 >= length levels then
      (EmJogo, (x,y), length levels,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
    else 
      (EmJogo, (x,y), (level+1), (estadoInicial (level + 1), (bloco,caixa,porta,playerE,playerW)))
  | otherwise = (EmJogo, (x,y), level, (andarEsquerda (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyRight) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) 
  | (((h:t):tt)!!y2!!(x2+1) == Porta) =
   if level+1 >= length levels then 
     (EmJogo, (x,y), length levels,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
   else 
    (EmJogo, (x,y), (level+1), (estadoInicial (level + 1), (bloco,caixa,porta,playerE,playerW)))
  | otherwise = (EmJogo, (x,y), level, (andarDireita (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level, (trepar (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeySpace) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level,(interageCaixa (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento _ s = s -- ignora qualquer outro evento



reageTempo :: Float -> GameWorld -> GameWorld
reageTempo _ w = w


fr :: Int 
fr = 50


dm :: Display
dm = InWindow "Novo Jogo" (720, 400) (0,0)


main :: IO ()
main = do 
    bloco  <- loadBMP "assets/bloco.bmp"
    caixa  <- loadBMP "assets/caixa.bmp"
    porta  <- loadBMP "assets/door.bmp"
    Just playerE <- loadJuicy "assets/playerE.png"
    Just playerW <- loadJuicy "assets/playerW.png"  
    play dm -- janela onde irá correr o jogo
          (greyN 0.5) -- côr do fundo da janela
          fr -- frame rate
          (estadoGlossInicial (0,0) bloco caixa porta playerE playerW) -- estado inicial
          draw -- desenha o estado do jogo
          reageEvento -- reage a um evento
          reageTempo -- reage ao passar do tempo

