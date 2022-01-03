{- |
Module      : Tarefa2_2021li1g030
Description : Construção/Desconstrução do mapa
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 2 do projeto de LI1 em 2021/22.
-}
module Tarefa2_2021li1g030 where

import LI12122
import Control.Lens

{-1. constroiMapa-}

{-constroiMapa preenche o mapa de Vazios com as peças dadas nas coordenadas correspondentes-}
constroiMapa :: [(Peca, Coordenadas)] -> Mapa
constroiMapa [] = []
constroiMapa ((p, (x,y)):t)
    | t == [] = subLinha (mapaVazios x y) (p, (x,y))
    | otherwise = subLinha (constroiMapa t) (p, (x,y))

{-FUNÇÕES AUXILIARES-}
{-mapaVazios constrói uma matriz (mapa) de Vazios de "x+1" colunas e "y+1" linhas-}
mapaVazios :: Int -> Int -> Mapa
mapaVazios x y = replicate (y+1) (replicate (x+1) Vazio)

{-subPeca substitui a peça pré-existente pela peça dada por "p" no ponto das abcissas "x"-}
subPeca :: (Peca, Coordenadas) -> [Peca] -> [Peca]
subPeca (x,y) [] = [x]
subPeca (p, (x,y)) l = (element x .~ p) l

{-subLinha substitui uma linha inteira no mapa;
  subLinha troca a linha de índice "y" pela linha dada por subPeca, que já tem a peça na abcissa "x"-}
subLinha :: Mapa -> (Peca, Coordenadas) -> Mapa
subLinha [] (x,y) = [[x]]
subLinha mapa (p, (x,y)) = (element y .~ (subPeca (p,(x,y)) (mapa!!y))) mapa


{-2. desconstroiMapa-}

{-desconstroiMapa devolve as peças e respetivas coordenadas do mapa-}
desconstroiMapa :: Mapa -> [(Peca, Coordenadas)]
desconstroiMapa mapa = desconstroiColunas mapa 0 0

{-FUNÇÕES AUXILIARES-}
{-desconstroiLinhas dá uma linha com as peças e respetivas coordenadas-}
desconstroiLinhas :: [Peca] -> Int -> Int -> [(Peca, Coordenadas)]
desconstroiLinhas [] _ _ = []
desconstroiLinhas (h:t) x y
    | h == Vazio = desconstroiLinhas t (x+1) y
    | otherwise = (h, (x,y)) : desconstroiLinhas t (x+1) y

{-desconstroiColunas itera pelo mapa e desconstrói cada linha-}
desconstroiColunas :: Mapa -> Int -> Int -> [(Peca, Coordenadas)]
desconstroiColunas [] _ _ = []
desconstroiColunas (h:t) x y = desconstroiLinhas h x y  ++ desconstroiColunas t x (y+1)

