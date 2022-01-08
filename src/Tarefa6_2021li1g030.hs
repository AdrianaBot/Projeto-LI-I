{- |
Module      : Tarefa6_2021li1gXXX
Description : Resolução de um puzzle

Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}
module Tarefa6_2021li1gXXX where

import LI12122
import Tarefa2_2021li1g030

resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo i jogo = undefined

data Rose a = Node a [Rose a] 
    deriving Show


{-encontraCaminho :: Rose Jogo -> Maybe [Jogo]
encontraCaminho (Node (Jogo mapa jogador)) [] = Just [(Jogo mapa jogador)] -}

encontraCaminho :: Rose Jogo -> Maybe [Jogo] 
encontraCaminho Node (Jogo mapa jogador) [] = Just [(Jogo mapa jogador)] 


encontraPorta :: Jogo -> Bool
encontraPorta (Jogo mapa (Jogador (x,y) _ _)) = ((mapa!!y)!!x) == Porta 




