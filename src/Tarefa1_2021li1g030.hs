{- |
Module      : Tarefa1_2021li1g030
Description : Validação de um potencial mapa
Copyright   : David da Silva Teixeira <a100554@alunos.uminho.pt>;
            : Adriana Sofia Frazão Pires <a95112@alunos.uminho.pt>;

Módulo para a realização da Tarefa 1 do projeto de LI1 em 2021/22.
-}
module Tarefa1_2021li1g030 where

import LI12122

{-| validaPotencialMapa : Corre todas as funções descritas. Se todas forem verdadeiras, então, a função também o é.
  O que quer dizer que o mapa fornecido, está bem definido -}

validaPotencialMapa :: [(Peca, Coordenadas)] -> Bool
validaPotencialMapa [] = False
validaPotencialMapa [(a,(x,y))] = False
validaPotencialMapa l = lugarDif l && porta l && caixaSegura l && vazio l && chao l



{-|1. coordenadas : Verifica se as coordenadas de uma lista estão bem definidas, ou seja, maiores do que zero -}
coordenadas :: [(Peca, Coordenadas)] -> Bool
coordenadas [] = True
coordenadas ((peca, (x,y)):t)
 | x < 0 || y < 0 = False
 | otherwise = coordenadas t

{-|1. pertence : Verifica se uma dada coordenada aparece em algum ponto numa lista de Peças e coordenadas-}
pertence :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
pertence _ [] = False
pertence (x,y) ((p,(xs,ys)):t)
 | x == xs && y == ys = True
 | otherwise = pertence (x,y) t

{-|1. lugarDif': Verifica se as Peças de uma lista estão em lugares difrentes -}
lugarDif' :: [(Peca, Coordenadas)] -> Bool 
lugarDif' [] = True
lugarDif' ((p,(x,y)):t)
 | pertence (x,y) t = False
 | otherwise = lugarDif' t

{-|1. Função Principal

lugarDif: Verfica se a função coordenadas é verdade, se sim executa lugarDif' -}
lugarDif :: [(Peca, Coordenadas)] -> Bool
lugarDif [] = True
lugarDif ((p,(x,y)):t) = if coordenadas ((p,(x,y)):t) then lugarDif' ((p,(x,y)):t)
                        else False








{-| 2. Função Principal

      porta : verifica se existe, pelo menos, uma porta na lista

          semPortas : verifica se não existe mais do que uma porta na lista-}


porta :: [(Peca, Coordenadas)] -> Bool
porta [] = False
porta ((p,(x,y)):t) = if p == Porta then semPortas t
                       else porta t

 where semPortas :: [(Peca,Coordenadas)] -> Bool
       semPortas [] = True
       semPortas ((p,(x,y)):t)
        | p == Porta = False
        | otherwise = semPortas t







{-|3. caixaSeguara2 : Verifica se na coordenada inferiror a uma caixa existe outra caixa ou bloco -}
caixaSegura2 :: Coordenadas -> [(Peca, Coordenadas)] -> Bool
caixaSegura2 _ [] = False
caixaSegura2 (x,y) ((p, (xs,ys)):t)
 | xs == x && ys == y+1 && (p == Bloco || p == Caixa) = True
 | otherwise = caixaSegura2 (x,y) t

{-|3. listaCaixas: Cria uma lista (apartir da lista principal) só com as peças que são caixas -}
listaCaixas :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)]
listaCaixas [] = []
listaCaixas ((p,(x,y)):t) 
    | p == Caixa = (p,(x,y)) : listaCaixas t
    | otherwise = listaCaixas t

{-|3. caixaSeguraM : Compara as coordenadas da 'listaCaixas' com as da lista original -}
caixaSeguraM :: [(Peca, Coordenadas)] -> [(Peca, Coordenadas)] -> Bool
caixaSegiraM _ [] = False
caixaSeguraM [] _ = True
caixaSeguraM ((p,(x,y)):t) mapa = caixaSegura2 (x,y) mapa && ( t == [] || caixaSeguraM t mapa )                            

{-|3. Função Principal

  caixaSegura : Corre as funções auxiliares que premitiram saber se não há caixas a flutuar -}
caixaSegura :: [(Peca, Coordenadas)] -> Bool
caixaSegura [] = False
caixaSegura mapa = caixaSeguraM (listaCaixas mapa) mapa 







{-|4. ePeca : Verifica se numa dada lista existe um certo tipo de peça-}
ePeca :: Peca -> [(Peca,Coordenadas)] -> Bool
ePeca a [] = False
ePeca a ((p,(x,y)):t)
 | a == p = True
 | otherwise = ePeca a t

{-|4. maiorY : Verifica se as coordenadas da lista estão corretas
      
    procurarY : Procura na lista o elemente com maior Y-}
maiorY :: [(Peca,Coordenadas)] -> Int
maiorY [] = 0
maiorY l = if coordenadas l then procurarY l else 0

 where procurarY :: [(Peca,Coordenadas)] -> Int
       procurarY [] = 0
       procurarY [(p,(x,y))] = y
       procurarY ((p,(x,y)):(p1,(x1,y1)):t)
        | y > y1 = procurarY ((p,(x,y)):t)
        | otherwise = procurarY ((p1,(x1,y1)):t)

{-|4. maiorX : Verifica se as coordenadas da lista estão corretas
      
       procurarX : Procura na lista o elemente com maior X-}
maiorX :: [(Peca,Coordenadas)] -> Int
maiorX [] = 0
maiorX l = if coordenadas l then procurarX l else 0

 where procurarX :: [(Peca,Coordenadas)] -> Int
       procurarX [] = 0
       procurarX [(p,(x,y))] = x
       procurarX ((p,(x,y)):(p1,(x1,y1)):t)
        | x > x1 = procurarX ((p,(x,y)):t)
        | otherwise = procurarX ((p1,(x1,y1)):t)

{-|4. area : Calcula a area de uma lista de peças -}
area ::[(Peca,Coordenadas)] -> Int
area [] = 0
area [_] = 0
area l = ((maiorY l)+1) * ((maiorX l)+1)

{-|4. Função Principal

  vazio : Verifica se a lista tem uma peça vazia ou se a area da lista é diferente do número de peças presentes na lista (o que inderetamente significa que existem peças vazias)-}
vazio :: [(Peca,Coordenadas)] -> Bool
vazio [] = False
vazio [(p,(0,0))] = False
vazio l
 | length l < area l || ePeca Vazio l = True
 | otherwise = False








{-|5. existe : Verifica se um par cosntituido por uma dada peça e coordenada existe no mapa fornecido-}
existe :: (Peca,Coordenadas) -> [(Peca,Coordenadas)] -> Bool
existe _ [] = False
existe (a,(x,y)) ((p,(x1,y1)):t)
 | (a,(x,y)) == (p,(x1,y1)) = True
 | otherwise = existe (a,(x,y)) t

{-|5. proximo : Verifica se na abcissa ao lado do Bloco na posião (0, maiorY l) exite um outro Bloco, e continua assim até ao ponto com a maior abcissa-}
proximo :: (Peca,Coordenadas) -> [(Peca,Coordenadas)] -> Bool
proximo _ [] = False
proximo (a,(x,y)) mapa 
 | (x == maiorX mapa && existe (a,(x,y)) mapa) = True
 | not (existe (Bloco,(x,y)) mapa) = False
 | otherwise = proximo (Bloco,(x+1,y)) mapa

{-|5. Função Principal

  chao : Executa as funções auxiliares que vão derterminar se existe chão no mapa fornecido-}
chao :: [(Peca,Coordenadas)] -> Bool
chao [] = False
chao mapa = if (existe (Bloco,(0,maiorY mapa)) mapa) then (proximo (Bloco,(0,maiorY mapa)) mapa) else False
