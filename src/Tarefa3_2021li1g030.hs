{- |
Module      : Tarefa3_2021li1g030
Description : Representação textual do jogo
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 3 do projeto de LI1 em 2021/22.
-}
module Tarefa3_2021li1g030 where

import LI12122

import Tarefa1_2021li1g030

{- | a instancia Show escreve o mapa em linguagem textual, seprando as linhas pelo caracter "\n". Para ser visível o mapa é necessário digitar:
  putStrLn (show (Jogo)) -}

instance Show Jogo where
  show (Jogo mapa (Jogador (x,y) direcao caixa)) = fazString (constroiJogo (Jogo mapa (Jogador (x,y) direcao caixa)))
  
    where fazString :: [String] -> String
          fazString [] = ""
          fazString [h] = h
          fazString (h:t) = h ++ "\n" ++ (fazString t)
         
{- |escrevePeca : Dada uma determinada Peca, representa-a em forma de String-}
escrevePeca :: Peca -> String
escrevePeca Vazio = " "
escrevePeca Bloco = "X"
escrevePeca Caixa = "C"
escrevePeca Porta = "P"


{- |escreveJogador : Dada as informações de um Jogador, escreve um String correspondente-}
escreveJogador :: Jogador -> String
escreveJogador (Jogador (x,y) direcao caixa)
 | direcao == Este = ">"
 | otherwise = "<"


{- |introduzPlayerY : Verifica em qual das listas do mapa pertence o jogador
    
    introduzPlayerX : Depois de descobrir a que lista do mapa a qual o jogador pertence, procura saber qual o elemente dessa lista que lhe corresponde-}
introduzPlayerY :: [String] -> String -> Coordenadas -> [String]
introduzPlayerY [] _ _ = []
introduzPlayerY ((h:t):t1) a (x,y)
 | y == 0 = (introduzPlayerX (h:t) a x) : t1
 | otherwise = (h:t) : (introduzPlayerY t1 a (x,y - 1))

 where introduzPlayerX :: String -> String -> Int -> String
       introduzPlayerX [] _ _ = []
       introduzPlayerX (h:t) a x
        | x == 0 = a ++ t
        | otherwise = h : introduzPlayerX t a (x - 1)


{- |introduzCaixaY : Verifica em qual das listas do mapa pertence o caixa que o jogador segura (isto, se ele segurar uma)

  introduzCaixaX : Depois de descobrir a que lista do mapa a qual a caixa pertence, procura saber qual o elemente dessa lista que lhe corresponde-}
introduzCaixaY :: [String] -> String -> Coordenadas -> [String]
introduzCaixaY [] _ _ = []
introduzCaixaY ((h:t):t1) a (x,y)
 | y == 0 = (introduzCaixaX (h:t) a x) : t1
 | otherwise = (h:t) : (introduzCaixaY t1 a (x,y - 1))

 where introduzCaixaX :: String -> String -> Int -> String
       introduzCaixaX [] _ _ = []
       introduzCaixaX (h:t) a x
        | x == 0 = a ++ t
        | otherwise = h : introduzCaixaX t a (x - 1)


{- |escreveLinha : Cria uma String formada pelas strings que corresponde aos elementos do mapa-}
escreveLinha :: [Peca] -> String
escreveLinha [] = []
escreveLinha (h:t) = escrevePeca h ++ escreveLinha t


{- |cosntroiMapa1 : Cria uma lista com as Strings da função escreveLinha-}
constroiMapa1 :: Mapa -> [String]
constroiMapa1 [] = []
constroiMapa1 mapa@((h:t):t1) = escreveLinha (h:t) : constroiMapa1 t1


{- |constroiJogo : Ponto de entrada da função (executa todas as outras funções a cima, de modo a se obter uma lista de listas de String, sendo que cada
"sub-lista" dessa lista corresponde a uma linha do eixo das ordenadas aonde se encontram as Peças que compoẽm o mapa)
-}
constroiJogo :: Jogo -> [String]
constroiJogo (Jogo [] (Jogador (x,y) direcao caixa)) = []
constroiJogo (Jogo mapa (Jogador (x,y) direcao caixa)) 
 | caixa == False = introduzPlayerY (constroiMapa1 mapa) (escreveJogador (Jogador (x,y) direcao caixa)) (x,y)
 | otherwise = introduzCaixaY (introduzPlayerY (constroiMapa1 mapa) (escreveJogador (Jogador (x,y) direcao caixa)) (x,y)) "C" (x,y-1) 