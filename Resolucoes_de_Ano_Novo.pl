% Regra para encontrar a posição da caracteristica Y que está à direita de determinada caracteristica X.
right(X,Y,Hs) :- nextto(X,Y,Hs).
right(X,Y,Hs) :- nextto(X,[_,Y,_,_],Hs).
right(X,Y,Hs) :- nextto(X,[_,_,Y,_],Hs).
right(X,Y,Hs) :- nextto(X,[_,_,_,Y],Hs).

% Regra para encontrar a posição da caracteristica X que está à esquerda ou à direita de determinada caracteristica Y.
nextTo(X,Y,Hs) :- right(X,Y,Hs).
nextTo(X,Y,Hs) :- right(Y,X,Hs).

% Regra para encontrar a posição da caracteristica Y que está entre a caracteristica X e a caracteristica Z.
bet(X,Y,Z, Hs) :- append(_,[X,Y,Z,_,_],Hs).
bet(X,Y,Z, Hs) :- append(_,[X,_,Y,Z,_],Hs).
bet(X,Y,Z, Hs) :- append(_,[X,Y,_,Z,_],Hs).
bet(X,Y,Z, Hs) :- append(_,[_,X,Y,Z,_],Hs).
bet(X,Y,Z, Hs) :- append(_,[_,X,_,Y,Z],Hs).
bet(X,Y,Z, Hs) :- append(_,[_,X,Y,_,Z],Hs).
bet(X,Y,Z, Hs) :- append(_,[_,_,X,Y,Z],Hs).

betwn(X,Y,Z,Hs) :- bet(X,Y,Z,Hs).
betwn(X,Y,Z,Hs) :- bet(Z,Y,X,Hs).

% Regra para adicionar duas caracteristicas a um determinado objeto.
exists(X,Hs) :- right(X,_,Hs).
exists(X,Hs) :- right(_,X,Hs).

% Cabeçalho para estilizar tabela no swish(compilador online) / Caso não for utilizar o swish online para compilar comente as linhas 28,29
:- use_rendering(table,
		 [header(h('Nome', 'Bolsa', 'Realização', 'Namorado', 'Idade'))]).

amigas(A):-

  %Resoluções de Ano Novo(Nome,Bolsa,Resolução,Namorado,Idade)
  length(A,5),
  % 1 - A mulher que quer viajar está ao lado de quem tem 24 anos.
  nextTo(h(_,_,viajar,_,_),h(_,_,_,_,24), A),

  % 2 - A Clarissa está em algum lugar à esquerda de quem tem 23 anos.
  right(h(clarissa,_,_,_,_),h(_,_,_,_,23), A),

  % 3 - A Vivian está exatamente à direita da mulher mais velha.
  right(h(_,_,_,_,26),h(vivian,_,_,_,_), A),

  %4 - A namorada do Otávio é a mulher mais nova do grupo.
  exists(h(_,_,_,otavio,19), A),

  % 5 - A mulher que namora o Daniel está na última posição.
  A = [_,_,_,_,h(_,_,_,daniel,_)],

  % 6 - A Fabiana está em algum lugar entre quem tem 20 anos e quem quer viajar, nessa ordem.
  betwn(h(_,_,_,_,20),h(fabiana,_,_,_,_),h(_,_,viajar,_,_), A),

  % 7 - Quem namora o Marcelo está ao lado da Vivian.
  nextTo(h(_,_,_,marcelo,_),h(vivian,_,_,_,_), A),

  % 8 - A Vivian está em algum lugar à esquerda de quem pretende economizar dinheiro.
  right(h(vivian,_,_,_,_),h(_,_,poupar_dinheiro,_,_), A),

  % 9 - Quem quer ler mais no ano novo está ao lado da Vivian.
  nextTo(h(_,_,ler,_,_),h(vivian,_,_,_,_), A),

  % 10 - Quem gostaria de emagrecer está na segunda posição.
  A = [_,h(_,_,emagrecer,_,_),_,_,_],

  % 11 - A Thaís está ao lado da mulher que namora o Otávio.
  nextTo(h(thais,_,_,_,_),h(_,_,_,otavio,_), A),

  % 12 - A mulher de bolsa amarela está exatamente à esquerda da Ana.
  right(h(_,amarela,_,_,_),h(ana,_,_,_,_), A),

  % 13 - A mulher de 19 anos está ao lado da mulher de bolsa verde.
  nextTo(h(_,_,_,_,19),h(_,verde,_,_,_), A),

  % 14 - Quem tem a bolsa branca está em algum lugar entre a mulher de 20 anos e a de 26 anos, nessa ordem.
  betwn(h(_,_,_,_,20),h(_,branca,_,_,_),h(_,_,_,_,26), A),

  % 15 - A cor da bolsa da Ana é vermelha.
  exists(h(ana,vermelha,_,_,_), A),

  % 16 - A Thaís está ao lado da Fabiana.
  nextTo(h(thais,_,_,_,_),h(fabiana,_,_,_,_), A),

  % 17 - A mulher de 26 anos está exatamente à esquerda da mulher que namora o Alexandre.
  right(h(_,_,_,_,26),h(_,_,_,alexandre,_), A),

  % 18 - A mulher de bolsa verde está em algum lugar à direita da Thaís. CONDIÇÃO QUE GERA O CONFLITO
  % right((thais,_,_,_,_),(_,verde,_,_,_), A), CONDIÇÃO QUE GERA O CONFLITO

  % 19 - Clarissa tem uma bolsa verde.
  exists(h(clarissa,verde,_,_,_), A),

  % 20 - A namorada de Daniel está ao lado da mulher que tem 23 anos.
  nextTo(h(_,_,_,daniel,_),h(_,_,_,_,23), A),

  % 21 - A mulher da primeira quer aprender ingles
  A = [h(_,_,aprender_ingles,_,_),_,_,_,_],

  % 22 - A mulher que tem a bolsa vermelha quer poupar dinheiro.
  exists(h(_,vermelha,poupar_dinheiro,_,_), A),
  
  % 23 - A mulher que tem a bolsa amarela está exatamente a direita da mulher que gosta de ler.
  right(h(_,_,ler,_,_),h(_,amarela,_,_,_), A),
  
  % 24 - A namorada de Alexandre tem 23 anos.
  exists(h(_,_,_,alexandre,23), A),
  
  % 25 - A mulher que está na primeira posição namora o julio.
  A = [h(_,_,_,julio,_),_,_,_,_],
 
  % 26 - A mulher de bolsa branca está ao lado da mulher de bolsa azul.
  nextTo(h(_,branca,_,_,_),h(_,azul,_,_,_), A).


% Nome de todas as amigas -> EX: nomes(Nome).
    nomes(Nome) :-
      amigas(A),
      member(h(Nome,_,_,_,_), A).

% Cor da bolsa de todas as amigas -> EX: corBolsas(Nome, Bolsa).
    corBolsas(Nome, Bolsa) :-
        amigas(A),
        member(h(Nome,Bolsa,_,_,_), A).

% Realições de todas as amigas -> EX: realizacoes(Nome, Realizacao).
    realizacoes(Nome, Realizacao) :-
        amigas(A),
        member(h(Nome,_,Realizacao,_,_), A).

% Namorados de todas as amigas -> EX: namorados(Nome, Namorado).
    namorados(Nome, Namorado) :-
        amigas(A),
        member(h(Nome,_,_,Namorado,_), A).

% Idade de todas as amigas -> EX: idades(Nome, Idade).
    idades(Nome, Idade) :-
        amigas(A),
        member(h(Nome,_,_,_,Idade), A).

% Cor da bolsa da amiga X -> EX: corBolsaAmiga(fabiana, Bolsa).
    corBolsaAmiga(Nome, X) :-
    amigas(A),
    member(h(Nome,X,_,_,_), A).

% Idade da amiga X -> EX: idadeAmiga(fabiana, Idade).
    idadeAmiga(Nome, X) :-
      amigas(A),
      member(h(Nome,_,_,_,X), A).

% Vizinha da amiga X -> EX: vizinha(fabiana, Vizinha).
    vizinha(Nome, X) :-
      amigas(A),
      nextTo(h(Nome,_,_,_,_),h(X,_,_,_,_), A),
      nextTo(h(X,_,_,_,_),h(Nome,_,_,_,_), A).

% Amiga com mais de 20 anos -> EX: maisDe20(Nome, Idade).
    maisDe20(Nome, Idade) :-
      amigas(A),
      member(h(Nome,_,_,_,Idade), A), Idade > 20.

% Amiga com até 20 anos -> EX: ate20(Nome, Idade).
    ate20(Nome, Idade) :-
      amigas(A),
      member(h(Nome,_,_,_,Idade), A), Idade =< 20.
