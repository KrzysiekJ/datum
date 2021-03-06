%%
%%   Copyright 2012 - 2013 Dmitry Kolesnikov, All Rights Reserved
%%
%%   Licensed under the Apache License, Version 2.0 (the "License");
%%   you may not use this file except in compliance with the License.
%%   You may obtain a copy of the License at
%%
%%       http://www.apache.org/licenses/LICENSE-2.0
%%
%%   Unless required by applicable law or agreed to in writing, software
%%   distributed under the License is distributed on an "AS IS" BASIS,
%%   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%%   See the License for the specific language governing permissions and
%%   limitations under the License.
%%
%% @description
%%   pure functional data structures
-module(datum).

-include("datum.hrl").

-export([
   compare/2
]).

%%
%% types
-type option(X)    :: undefined | X.

-type either(L, R) :: {error, L} | {ok, R}.
-type either()     :: {error, _} | ok.
-type either(R)    :: {error, _} | {ok, R}.
-type either(L, R1, R2) :: {error, L} | {ok, R1, R2}.

-type foldable(T)    :: T.
-type traversable(T) :: T.
-type maplike()      :: _.

-type tree(T)   :: {t, compare(T), _}.
-type heap(T)   :: {h, compare(T), _}.
-type stream(T) :: #stream{head :: T, tail :: datum:option(fun(() -> T))}.
-type q(T)      :: {q, integer(), [T], [T]}.

-type ring()    :: tuple().

-type monoid(T)    :: fun((T, T) -> T).
-type predicate(T) :: fun((T) -> true | false).
-type effect(T)    :: fun((T) -> ok).
-type compare(T)   :: fun((T, T) -> eq | gt | lt).

-type lens(A, S)   :: fun( (fun( (A) -> _ ), S) -> _ ).
-type lens()       :: lens(_, _).

-export_type([
   option/1,
   either/0,
   either/1,
   either/2,
   either/3,

   foldable/1,
   traversable/1,
   maplike/0,

   tree/1,
   heap/1,
   stream/1,
   q/1,

   ring/0,

   monoid/1,
   predicate/1,
   effect/1,
   compare/1,

   lens/2,
   lens/0
]).


%%
%% compare two instances, default implementation
-spec compare(_, _) -> eq | gt | lt.

compare(A, B) when A =:= B -> eq;
compare(A, B) when A  >  B -> gt;
compare(A, B) when A  <  B -> lt.
