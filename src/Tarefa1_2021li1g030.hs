{- |
Module      : Tarefa1_2021li1g030
Description : Validação de um potencial mapa
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}
module Tarefa1_2021li1g030 where

import LI12122

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa pecas = undefined

coordenadas :: (Int,Int) -> Bool
coordenadas (x,y) = x >= 0 && y >= 0 

--1. não haver mais do que uma declaração de peça para a mesma posição
umaDeclaracao :: [(Peca, Coordenadas)] -> Bool
umaDeclaracao [] = False 
umaDeclaracao ((p1, (x1,y1)):(p2, (x2,y2)):t) 
    | p1 == p2 && x1 == x2 && y1 == y2 = False 
    | p1 /= p2 || x1 /= x2 || y1 /= y2 && umaDeclaracao t 
    | otherwise = True 

{-umaDeclaracao :: (Peca, Coordenadas) -> (Peca, Coordenadas) -> Bool
umaDeclaracao (a, (x1,y1)) (b, (x2,y2)) 
    | x1 == x2 && y1 == y2 && a == b = True 
    | otherwise = False  -}
  
{-umaPorta :: [(Peca, Coordenadas)] -> Bool
umaPorta ((a, (x1,y1)), (b, (x2,y2)):t) 
    | a == Porta && b /= Porta = True
    | a /= Porta && b == Porta = True
    | otherwise = umaPorta t -}

{-chao :: [(Peca, Coordenadas)] -> Bool
chao [] = False
chao ((p, (x,y)):t) 
    | p == Bloco && x == 0 && c = True 
    | otherwise = False 
    where c = 

chao1 :: -}

     




{-validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = True
validaPotencialMapa ((a,(x,y)):t) = ((a == Bloco || a == Porta || a == Caixa || a == Vazio) && coordenadas (x,y)) && (validaPotencialMapa t) -}
    

{- if y == 0 then Bloco, (x+1,0) --5. base do mapa deve ser blocos 
if ((a,(x,y)) == Porta, (x,y) || (Porta, (x,y) `elem` t) then --2. declarar exatamente uma porta
    else -}