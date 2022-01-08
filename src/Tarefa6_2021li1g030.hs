{- |
Module      : Tarefa6_2021li1g030
Description : Resolução de um puzzle
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Visamos Módulo para a realização da Tarefa 6 do projeto de LI1 em 2021/22.
-}
module Tarefa6_2021li1g030 where

import LI12122
import Tarefa2_2021li1g030
import Tarefa4_2021li1g030
import Data.Maybe

data Rose a = Node a [Rose a] 
    deriving Show

{-A utilização de uma Rose Tree para a realização desta tarefa foi particularmente útil, visto que as diversas ramificações de uma RTree se traduzem, neste caso, para os quatro movimentos possíveis: InterageCaixa, Trepar, AndarDireita e AndarEsquerda.
No entanto, através do nosso método (brute force), os quatro movimentos multiplicam-se exponencialmente, pelo que a nossa resolução demorará demasiado tempo para calcular a resolução de mapas grandes-}


{-resolveJogo é a função final desta tarefa, que permite a resolução do mapa no menor número de passos/movimentos possíveis-}
resolveJogo :: Int -> Jogo -> Maybe [Movimento]
resolveJogo i jogo 
    | i < 0 = Nothing --não há solução
    | procuraSequencia jogo = Just 


{-A procuraPorta encontra a porta no jogo, de forma a possibilitar a resolução do jogo na procuraSequencia-}
procuraPorta :: Jogo -> Bool
procuraPorta (Jogo mapa (Jogador (x,y) _ _)) = ((mapa!!y)!!x) == Porta 

{-A procuraSequencia descobre um caminho no jogo, retornando um Just, caso o encontre, ou um Nothing, quando a resolução é impossível-}
procuraSequencia :: Rose Jogo -> Maybe [Jogo] 
procuraSequencia (Node jogo1@(Jogo mapa (Jogador (x,y) _ _)) []) 
    | procuraPorta jogo1 = Just [jogo1]
    | otherwise = Nothing 
procuraSequencia (Node jogo1@(Jogo mapa jogador) (h:t)) 
    | isJust (procuraSequencia h) = Just (jogo1 : fromJust (procuraSequencia h)) 
    | otherwise = procuraSequencia (Node (Jogo mapa jogador) t)


{-jogosParaMovimentos indica o movimento ocorrido entre dois jogos diferentes-}
jogosParaMovimento :: Jogo -> Jogo -> Movimento 
jogosParaMovimento (Jogo mapa1 (Jogador (x1,y1) dir1 caixa1)) (Jogo mapa2 (Jogador (x2,y2) dir2 caixa2)) 
    | caixa1 /= caixa2 = InterageCaixa --o jogador pegou ou largou numa caixa
    | y2 > y1 = Trepar --o jogador trepou um bloco 
    | x2 > x1 = AndarDireita --o jogador andou para a direita
    | otherwise = AndarEsquerda --o jogador andou para a esquerda

{-jogosParaLista transforma uma lista de jogos numa lista de movimentos, isto é, a função devolve a lista de movimentos ocorridos entre cada jogo na lista inicial-}
jogosParaLista :: [Jogo] -> [Movimento]
jogosParaLista [] = [] 
jogosParaLista (h:x:t) = jogosParaMovimento h x : jogosParaLista t 


{-adicionarJogosTree pega num jogo e numa lista de movimentos, adicionando-os aos ramos de uma RTree-}
adicionarJogosTree :: Jogo -> [Movimento] -> [Rose Jogo]
adicionarJogosTree jogo (h:t) = (Node (moveJogador jogo h) []) : adicionarJogosTree jogo t

{-aumentaRTree expande a árvore através da função map que percorre as ramificações da RTree (listas), aplicando a cada movimento (InterageCaixa, Trepar, AndarDireita, AndarEsquerda) a função aumentaRTree-}
aumentaRTree :: Rose Jogo -> Rose Jogo
aumentaRTree (Node jogo []) = Node jogo (adicionarJogosTree jogo [InterageCaixa, Trepar, AndarDireita, AndarEsquerda]) 
aumentaRTree (Node jogo (h:t)) = Node jogo (map aumentaRTree t)
    


