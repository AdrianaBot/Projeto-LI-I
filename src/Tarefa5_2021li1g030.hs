{- |
Module      : Tarefa5_2021li1g030
Description : Movimentação do personagem
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 5 do projeto de LI1 em 2021/22.


 Bibliografia:

  . https://andrew.gibiansky.com/blog/haskell/haskell-gloss/
  
  . https://hackage.haskell.org/package/gloss-1.13.2.1/docs/Graphics-Gloss-Data-Color.html
  
  . https://hackage.haskell.org/package/gloss-1.13.2.1/docs/Graphics-Gloss.html
  
  . https://hackage.haskell.org/package/gloss-1.1.1.0/docs/Graphics-Gloss-Game.html
-}

module Main where
import LI12122
import Mapas
import Tarefa3_2021li1g030
import Tarefa4_2021li1g030
import Graphics.Gloss
import Graphics.Gloss.Interface.Pure.Game
import Graphics.Gloss.Juicy (loadJuicy)

{- | As opções que podem ser selecionas no menu -}

data Opcoes = Jogar
            | Titulo
            | Sair
            | Guia

{- | O controlador dá informação ao progama se o jogador se encontra em algum estado de jogo, nestes casos ou no guia de comandos, ou em jogo -}

data Menu = Controlador Opcoes
          | EmJogo
          | EmGuia

{- | Constítuido por:

   . Menu (para identificar aonde o jogador se encontra)

   . Coordenadas (para saber aonde deve começar a construir o mapa graficamente)

   . 1 Inteiro (corresponde ao nível do jogo atual)

   . 1 Jogo

   . 5 Sprites-}

type GameWorld = (Menu, Coordenadas, Int, (Jogo, (Picture, Picture, Picture, Picture, Picture)))




{- | Armazena os níveis do jogo-}

levels :: [Jogo]
levels = [m1,m2,m3,m4,m5,m6,m7]



{- | Atualiza o nível aonde o jogador está-}

estadoInicial :: Int -> Jogo
estadoInicial level = levels!!level






{- |recebe 2 tipos de argumentos:

   . coordenadas para auxiliar  na construção no nível graficamente

   . os sprites para represnetar o jogo

  devolve um GameWorld-}

estadoGlossInicial :: Coordenadas -> Picture -> Picture -> Picture -> Picture -> Picture -> GameWorld
estadoGlossInicial (0,0) bloco caixa porta playerE playerW = (Controlador Jogar, (0,0), 0, (estadoInicial 0, (bloco,caixa,porta,playerE,playerW)))





{- | Reinicia um nível-}

reiniciaNivel :: Int -> Picture -> Picture -> Picture -> Picture -> Picture -> GameWorld
reiniciaNivel level bloco caixa porta playerE playerW = (EmJogo, (0,0), level, (estadoInicial level, (bloco,caixa,porta,playerE,playerW)))





{- | Recebe um GameWorld e desenha o mapa graficamnete (levando em consideração o menu aonde o jogador se encontra e o nível)-}

draw :: GameWorld -> Picture

{- | As seguintes linhas de comando desenham o menu inicial-}

draw (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = Pictures [Color blue $ drawOption "Jogar", drawOption1 "Block Dude" , drawOptionA "Sair", drawOptionB "Comandos" ]
draw (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = Pictures [drawOption "Jogar", drawOption1 "Block Dude" ,  Color blue $ drawOptionA "Sair", drawOptionB "Comandos" ]
draw (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = Pictures [drawOption "Jogar", drawOption1 "Block Dude" ,  drawOptionA "Sair", Color blue $ drawOptionB "Comandos" ]

{- | As seguintes linhas de comando desenham o menu da opção "comandos"-}

draw (EmGuia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  Pictures [drawOption4a "Prima 'Delete (insert)' para sair", drawOption4b "Andar - Setas (Esq. & Dir.)", drawOption4c "Trepar - Seta (Cima)", drawOption4d "Pegar/Largar Caixa - Barra de Espacos", drawOption4e "Sair do Jogo - Esc", drawOption4f "Reiniciar nivel - Seta (Baixo)"]

{- | As seguintes linhas de comando desenham o jogo usando, principalmente, os sprites e coordenadas "(x,y)"-}

draw  (EmJogo, (x,y), level,(Jogo [[]] (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = Blank
draw (EmJogo, (x,y), level, (Jogo ([]:tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = draw (EmJogo, (0,y + 1), level, (Jogo (tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
draw estadoGlossInicial@(EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW)))
  | level == length levels =
    pictures [drawOption2 "Trabalho Realizado por: ", drawOption2a "Obrigado Por Jogar", drawOption3 "David Teixeira", drawOption3a "Adriana Frazao"]
  | (x,y) == (x2,y2) && dir == Este = 
    pictures [translate (xx) (yy) $ scale 0.10 0.11 playerE, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | (x,y) == (x2,y2) && dir == Oeste = 
    pictures [translate (xx) (yy) $ scale 0.10 0.11 playerW, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Bloco = 
    pictures [translate (xx) (yy) $ scale 0.16 0.16 bloco , (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Porta = 
    pictures [translate (xx) (yy) $ scale 0.14 0.10 porta, (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | h == Caixa = 
    pictures [translate (xx) (yy) $ scale 0.52 0.52 caixa , (draw (EmJogo, (x +1, y),level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
  | otherwise = 
    pictures [translate (xx) (yy) $ Blank , (draw (EmJogo, (x +1, y), level,((Jogo (t:tt) (Jogador (x2,y2) dir bool),(bloco,caixa,porta,playerE,playerW)))))]
    where
         xx = (fromIntegral (x * (40)))  - 190
         yy = (fromIntegral (y * (-40))) + 90

{- | A função "drawOption" e as suas variações escrevem texto no ecrã, quando assim necessário pela função "draw"-}

drawOption option = Translate (-110) (-20) $ Scale (0.75) (0.75) $ Text option
drawOptionA option = Translate (-110) (-200) $ Scale (0.75) (0.75) $ Text option
drawOptionB option = Translate (-240) (-110) $ Scale (0.75) (0.75) $ Text option
drawOption1 option = Translate (-350) (100) $ Scale (1.0) (1.0) $ Text option
drawOption2 option = Translate (-370) (20) $ Scale (0.5) (0.5) $ Text option
drawOption2a option = Translate (-320) (140) $ Scale (0.5) (0.5) $ Text option
drawOption3 option = Translate (-230) (-100) $ Color green $ Scale (0.5) (0.5) $ Text option
drawOption3a option = Translate (-230) (-200) $ Color rose $ Scale (0.5) (0.5) $ Text option

drawOption4a option = Translate (0) (-160) $ Scale (0.15) (0.15) $ Text option
drawOption4b option = Translate (-330) (140) $ Scale (0.25) (0.25) $ Text option
drawOption4c option = Translate (-330) (100) $ Scale (0.25) (0.25) $ Text option
drawOption4d option = Translate (-330) (60) $ Scale (0.25) (0.25) $ Text option
drawOption4e option = Translate (-330) (20) $ Scale (0.25) (0.25) $ Text option
drawOption4f option = Translate (-330) (-20) $ Scale (0.25) (0.25) $ Text option





{- | Dependendo de diferentes inputs em teclas ou eventos (como chegar ao final de um nível ou navegar/mudar de menu), 
o jogo é atualizado para corresponder a tais acontecimentos-}

reageEvento :: Event -> GameWorld -> GameWorld

reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (Controlador Jogar, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Sair, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  undefined

reageEvento (EventKey (SpecialKey KeyEnter) Down _ _) (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) = 
  (EmGuia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

reageEvento (EventKey (SpecialKey KeyDelete) Down _ _) (EmGuia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW))) =
   (Controlador Guia, (x,y), level, ((Jogo m (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

{- | Os próximos 2 conjuntos de códigos, além de fazerem o jogador andar quando necessário, mudam para o próximo nível, quando o jogador ficar com as mesmas
 coordenadas da porta. -}

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

{- | Quando é premida a tecla para cima, faz o jogador trepar um bloco ou caixa-}

reageEvento (EventKey (SpecialKey KeyUp) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level, (trepar (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

{- | Quando é premida a tecla para baixo, reinicia o nível-}

reageEvento (EventKey (SpecialKey KeyDown) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) =
  reiniciaNivel level bloco caixa porta playerE playerW

{- | Quando é premida a barra de espaços, faz o jogador interagir com a caixa-}

reageEvento (EventKey (SpecialKey KeySpace) Down _ _) (EmJogo, (x,y), level,(Jogo ((h:t):tt) (Jogador (x2,y2) dir bool), (bloco,caixa,porta,playerE,playerW))) = 
  (EmJogo, (x,y), level,(interageCaixa (Jogo ((h:t):tt) (Jogador (x2,y2) dir bool)), (bloco,caixa,porta,playerE,playerW)))

{- | ignora qualquer outro evento-}

reageEvento _ s = s






{- | reage ao passar do tempo-}

reageTempo :: Float -> GameWorld -> GameWorld
reageTempo _ w = w

{- | frame rate-}

fr :: Int 
fr = 50

{- | janela onde irá correr o jogo-}

dm :: Display
dm = InWindow "Novo Jogo" (720, 400) (0,0)

{- | Executa todas as funções listadas a cima de modo a criar um jogo-}

main :: IO ()
main = do 
    Just bloco   <- loadJuicy "assets/bloco.png"
    Just caixa   <- loadJuicy "assets/caixa.png"
    Just porta   <- loadJuicy "assets/porta.png"
    Just playerE <- loadJuicy "assets/gatoE.png"
    Just playerW <- loadJuicy "assets/gatoW.png"  
    play dm 
          (greyN 0.5)
          fr
          (estadoGlossInicial (0,0) bloco caixa porta playerE playerW)
          draw
          reageEvento
          reageTempo

