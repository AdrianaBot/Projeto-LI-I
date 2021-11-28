module Tarefa1_2021li1g030_Spec where

import Test.HUnit
import LI12122
import Tarefa1_2021li1g030
import Fixtures

-- Tarefa 1
testsT1 =
  test
    [ "Tarefa 1 - Teste Valida Mapa m1r" ~: validaPotencialMapa m1 ~=? True
    , "Tarefa 1 - Teste Valida Mapa vazio" ~: validaPotencialMapa [] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com 2 peças em sítios diferentes" ~: lugarDif [(Bloco, (1,0)),(Bloco, (1,1))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa com 2 peças no mesmo sítio" ~: lugarDif [(Bloco, (1,1)),(Bloco, (1,1))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com 1 porta" ~: porta [(Porta, (0,0)), (Bloco, (0,1))] ~=?  True
    , "Tarefa 1 - Teste Valida Mapa com 2 portas" ~: porta [(Porta, (0,0)), (Porta, (1,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa sem portas" ~: porta [(Bloco, (0,0)), (Bloco, (1,0))] ~=?  False
    , "Tarefa 1 - Teste Valida Mapa com 1 caixa sobre 1 bloco" ~: caixaSegura [(Caixa, (0,0)),(Bloco, (0,1))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa com 1 caixa sobre 1 caixa sobre 1 bloco" ~: caixaSegura [(Caixa, (0,0)),(Caixa, (0,1)), (Bloco, (0,2))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa com caixa a flutuar" ~: caixaSegura [(Caixa, (0,0)),(Bloco, (0,2))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com espaço vazio explícito" ~: vazio [(Vazio, (0,0)),(Bloco, (1,0)),(Bloco, (0,1)),(Bloco, (1,1))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa com espaço vazio inplícito" ~: vazio [(Bloco, (1,0)),(Bloco, (0,1)),(Bloco, (1,1))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa sem espaço Vazio" ~: vazio [(Bloco, (0,0)),(Bloco, (1,0)),(Bloco, (0,1)),(Bloco, (1,1))] ~=? False
    , "Tarefa 1 - Teste Valida Mapa com chao sem buraco" ~: chao [(Bloco, (0,0)),(Bloco, (1,0)),(Bloco, (2,0)),(Bloco, (3,0)),(Bloco, (4,0))] ~=? True
    , "Tarefa 1 - Teste Valida Mapa com chao com buraco" ~: chao [(Bloco, (0,0)),(Bloco, (1,0)),(Bloco, (3,0)),(Bloco, (4,0))] ~=? False
    ]

