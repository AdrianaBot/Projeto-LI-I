module Mapas where

import LI12122

m0 :: Jogo
m0 = Jogo [[Vazio, Vazio, Vazio]
          ,[Porta, Vazio, Vazio]
          ,[Bloco, Bloco, Bloco]] (Jogador (1,1) Oeste False)

m1 :: Jogo
m1 = Jogo [[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Bloco, Vazio, Vazio, Vazio, Vazio, Bloco, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Porta, Vazio, Bloco, Vazio, Bloco, Caixa, Vazio, Bloco, Vazio, Caixa, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]] (Jogador (11,2) Oeste False)

m2 :: Jogo
m2 = Jogo [[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
          ,[Bloco, Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Caixa, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Bloco, Bloco, Bloco, Bloco, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Vazio, Bloco, Bloco, Bloco, Bloco, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Porta, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]] (Jogador (1,3) Este True)

m3 :: Jogo
m3 = Jogo [[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Bloco, Bloco, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Caixa, Vazio, Bloco, Porta, Caixa, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Vazio, Vazio, Caixa, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]] (Jogador (1,3) Este False)

m4 :: Jogo
m4 = Jogo [[Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Porta]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco, Bloco, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Bloco, Bloco, Bloco, Bloco, Bloco]
          ,[Bloco, Caixa, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Vazio, Vazio, Caixa, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]] (Jogador (7,5) Oeste False)

m5 :: Jogo
m5 = Jogo [[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Porta, Vazio, Vazio, Caixa, Vazio, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Vazio, Bloco, Bloco, Bloco, Vazio, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Vazio, Bloco, Bloco, Bloco, Bloco, Vazio, Vazio, Vazio, Vazio, Bloco]
          ,[Bloco, Bloco, Vazio, Bloco, Bloco, Bloco, Bloco, Bloco, Caixa, Caixa, Vazio, Bloco]
          ,[Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco, Bloco]] (Jogador (10,5) Oeste False)