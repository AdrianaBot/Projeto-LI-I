{- |
Module      : Tarefa4_2021li1g030
Description : Movimentação do personagem
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 4 do projeto de LI1 em 2021/22.
-}
module Tarefa4_2021li1g030 where

import LI12122
import Tarefa2_2021li1g030
import Tarefa3_2021li1g030
import Control.Lens 


{-1.-}
moveJogador :: Jogo -> Movimento -> Jogo
moveJogador (Jogo mapa jogador) movimento 
    | movimento == AndarEsquerda = andarEsquerda (Jogo mapa jogador)
    | movimento == AndarDireita = andarDireita (Jogo mapa jogador) 
    | movimento == Trepar = trepar (Jogo mapa jogador) 
    | movimento == InterageCaixa = interageCaixa (Jogo mapa jogador)

{-1.1. AndarEsquerda/AndarDireita-}
{-andarEsquerda é o movimento para a esquerda do jogador, seja ele andar uma unidade ou virar-se-}
andarEsquerda :: Jogo -> Jogo
andarEsquerda (Jogo mapa (Jogador (x,y) dir caixa)) 
    | podeAndar (x-1,y) caixa mapa && caixa = (Jogo (moveObjeto mapa Caixa (x,y-1) (calculaQuedaCaixa (x-1,y) mapa)) (Jogador (calculaQueda (x-1,y) mapa) Oeste True))
    | podeAndar (x-1,y) caixa mapa && not caixa = (Jogo mapa (Jogador (calculaQueda (x-1,y) mapa) Oeste False)) 
    | otherwise = (Jogo mapa (Jogador (x,y) Oeste caixa))

{-andarDireita é o movimento para a direita do jogador, seja andar uma unidade ou virar-se-}
andarDireita :: Jogo -> Jogo
andarDireita (Jogo mapa (Jogador (x,y) dir caixa))
    | podeAndar (x+1,y) caixa mapa && caixa = (Jogo (moveObjeto mapa Caixa (x,y-1) (calculaQuedaCaixa (x+1,y) mapa)) (Jogador (calculaQueda (x+1,y) mapa) Este True))
    | podeAndar (x+1,y) caixa mapa && not caixa = (Jogo mapa (Jogador (calculaQueda (x+1,y) mapa) Este False)) 
    | otherwise = (Jogo mapa (Jogador (x,y) Este caixa))

{-podeAndar considera as várias possibilidades de movimento do jogador-}
podeAndar :: Coordenadas -> Bool -> Mapa -> Bool
podeAndar (x,y) caixa mapa
    | x < 0 && y < 0 && x > (length (mapa!!0)) && y > (length mapa)-1 = False 
    | caixa && y < 1 = False 
    | mapa!!y!!x == Porta = True 
    | (mapa!!y!!x == Vazio) && ((not caixa) || ((mapa!!(y-1)!!x == Vazio) && caixa)) = True 
    | otherwise = False 


{-1.2 trepar-}
trepar :: Jogo -> Jogo
trepar (Jogo mapa (Jogador (x,y) dir caixa))
    | dir == Este && podeTrepar (x+1,y) caixa mapa = trepa (Jogador (x,y) Este caixa) mapa
    | dir == Oeste && podeTrepar (x-1,y) caixa mapa = trepa (Jogador (x,y) Oeste caixa) mapa
    | otherwise = (Jogo mapa (Jogador (x,y) dir caixa))  


{-trepa faz com que o jogador trepe de acordo com as circunstâncias (direção e mapa-}
trepa :: Jogador -> Mapa -> Jogo
trepa (Jogador (x,y) dir caixa) mapa 
    | not caixa && dir == Oeste = Jogo mapa (Jogador (x-1,y-1) dir caixa) --Oeste, sem caixa
    | not caixa && dir == Este = Jogo mapa (Jogador (x+1, y-1) dir caixa) --Este, sem caixa
    | caixa && dir == Oeste = Jogo (moveObjeto mapa Caixa (x,y-1) (x-1,y-2)) (Jogador (x-1,y-1) dir caixa) --Oeste, com caixa
    | caixa && dir == Este = Jogo (moveObjeto mapa Caixa (x,y-1) (x+1,y-2)) (Jogador (x+1,y-1) dir caixa) --Este, com caixa 


{-podeTrepar verifica se o jogador pode trepar um bloco ou caixa consoante o mapa; (x,y) é as coordenadas desejadas-}
podeTrepar :: Coordenadas -> Bool -> Mapa -> Bool
podeTrepar (x,y) caixa mapa 
    | (caixa && y < 2) || (not caixa && y < 1) = False 
    | ((mapa!!y!!x == Caixa || mapa!!y!!x == Bloco) 
    && (mapa!!(y-1)!!x == Vazio) 
    && (not caixa || (caixa && (mapa!!(y-2)!!x == Vazio)))) = True 
    |otherwise = False


{-1.3. interageCaixa faz com que o jogador tente interagir com uma caixa, pegando ou largando-}
interageCaixa :: Jogo -> Jogo
interageCaixa (Jogo mapa (Jogador (x,y) dir caixa))
    | caixa = (Jogo (largaCaixa (Jogador (x,y) dir caixa) mapa) (Jogador (x,y) dir False))
    | podePegar dir (x,y) mapa = (Jogo (pegaCaixa (Jogador (x,y) dir caixa) mapa) (Jogador (x,y) dir True))
    | podePegar dir (x,y-1) mapa = (Jogo (pegaCaixa (Jogador (x,y) dir caixa) mapa) (Jogador (x,y) dir True))
    | otherwise = (Jogo (pegaCaixa (Jogador (x,y) dir caixa)  mapa) (Jogador (x,y) dir True)) 


{-podePegar verifica se o jogador pode pegar uma caixa-}
podePegar :: Direcao -> Coordenadas -> Mapa -> Bool
podePegar dir (x,y) [] = False 
podePegar dir (x,y) mapa
    | dir == Este = x >= 0 && x <= (length (mapa!!0))-2 && y > 0 && (mapa!!(y-1)!!x == Vazio) && (mapa!!y!!(x+1) == Caixa) && mapa!!(y-1)!!(x+1) == Vazio
    | dir == Oeste = x > 0 && x <= (length (mapa!!0))-1 && y > 0 && (mapa!!(y-1)!!x == Vazio) && (mapa!!y!!(x-1) == Caixa) && mapa!!(y-1)!!(x-1) == Vazio
    | otherwise = False 


{-podeLargar verifica se o jogador pode largar uma caixa-}
podeLargar :: Direcao -> Coordenadas -> Mapa -> Bool
podeLargar dir (x,y) [] = False 
podeLargar dir (x,y) mapa
    | dir == Este = x >= 0 && x<= (length (mapa!!0))-2 && y > 0 && (mapa!!(y-1)!!(x+1) == Vazio) 
    | dir == Oeste = x > 0 && x<= (length (mapa!!0))-1 && y > 0 && (mapa!!(y-1)!!(x-1) == Vazio)
    | otherwise = False 

{-moveObjeto move o objeto-}
moveObjeto :: Mapa -> Peca -> Coordenadas -> Coordenadas -> Mapa 
moveObjeto mapa peca (x1,y1) (x2,y2) = subLinha (subLinha mapa (Vazio, (x1,y1))) (peca, (x2,y2))

{-pegaCaixa pega numa caixa, se for possível-}
pegaCaixa :: Jogador -> Mapa -> Mapa
pegaCaixa (Jogador (x,y) dir caixa) mapa 
    | caixa = mapa 
    | podePegar dir (x,y) mapa = moveObjeto mapa Caixa ((x-1),y) (x,(y-1)) --Oeste, caixa no chão
    | podePegar dir (x,y) mapa = moveObjeto mapa Caixa ((x-1),(y-1)) (x,(y-1)) --Oeste, caixa em cima de algo
    | podePegar dir (x,y) mapa = moveObjeto mapa Caixa ((x+1),y) (x,(y-1)) --Este, caixa no chão
    | podePegar dir (x,y) mapa = moveObjeto mapa Caixa ((x+1),(y-1)) (x,(y-1)) --Este, caixa em cima de algo
    | otherwise = mapa

{-largaCaixa larga uma caixa, se possível-}
largaCaixa :: Jogador -> Mapa -> Mapa
largaCaixa (Jogador (x,y) dir caixa) mapa 
    | dir == Este && (podeLargar dir (x,y) mapa) = moveObjeto mapa Caixa (x,y-1) (calculaQueda (x + 1, y) mapa)
    | dir == Oeste && (podeLargar dir (x,y) mapa) = moveObjeto mapa Caixa (x,y-1) (calculaQporueda (x-1, y) mapa) 
    | otherwise =  mapa

{-calculaQueda calcula a queda de qualquer objeto-}
calculaQueda :: Coordenadas -> Mapa -> Coordenadas 
calculaQueda (x,y) [] = (x,y)
calculaQueda (x,y) mapa 
    | ((mapa!!y!!x == Bloco) || (mapa!!y!!x == Caixa)) = (x,y-1) 
    | y == (length mapa)-1 = (x,y)
    | mapa!!y!!x == Vazio = calculaQueda (x,y+1) mapa  
    

calculaQuedaCaixa :: Coordenadas -> Mapa -> Coordenadas 
calculaQuedaCaixa (x,y) [] = (x,y)
calculaQuedaCaixa (x,y) mapa 
    | ((mapa!!y!!x == Bloco) || (mapa!!y!!x == Caixa)) = (x,y-2) 
    | y == (length mapa)-1 = (x,y-1)
    | mapa!!y!!x == Vazio = calculaQuedaCaixa (x,y+1) mapa  

{-2.-}
correrMovimentos :: Jogo -> [Movimento] -> Jogo
correrMovimentos (Jogo mapa jogador) [] = (Jogo mapa jogador)
correrMovimentos (Jogo mapa jogador) (h:t) = correrMovimentos (moveJogador (Jogo mapa jogador) h) t 