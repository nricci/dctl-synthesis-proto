module Dctl where



import qualified Data.Set as S
import Data.Set (Set)
import qualified SetAux as S

import Prelude hiding (break, negate)

import Debug.Trace


-- dCTL Formulas 
data Formula = 	And Formula Formula
			|	Or Formula Formula
			|	If Formula Formula
			|	Iff Formula Formula
			|	Xor Formula Formula
			|	Not Formula
			-- 	Quantifiers
			|	A PFormula
			|	E PFormula
			|	O PFormula
			|	P PFormula
			--	Atomic formulas 		
			|	Prop String
			|	Norm
			|	TrueConst
			|	FalseConst
			deriving (Eq,Ord)

data PFormula 	= 	U Formula Formula
				|	W Formula Formula
				|	X Formula
				|	G Formula
				|	F Formula
				deriving (Eq,Ord)


instance Show Formula where
	show (And p q) 	=	show p ++ " && " ++ show q
	show (Or p q) 	=	show p ++ " || " ++ show q 
	show (If p q)	=	show p ++ " -> " ++ show q 
	show (Iff p q) 	=	show p ++ " == " ++ show q
	show (Xor p q) 	=	show p ++ " != " ++ show q
	show (Not p)		=	"!" ++ show p
	show (A f) 		= 	"A" ++ show f
	show (O f) 		= 	"O" ++ show f
	show (P f) 		= 	"P" ++ show f
	show (E f) 		= 	"E" ++ show f
	show (Prop s) 	= 	s	
	show Norm		= 	"n"
	show TrueConst 	= 	"true"
	show FalseConst	= 	"false"

instance Show PFormula where
	show (U p q) 	=	"(" ++ show p ++ " U " ++ show q ++ ")"
	show (W p q) 	=	"(" ++ show p ++ " W " ++ show q ++ ")"
	show (X p) 	=	"X (" ++ show p ++ ")"
	show (G p) 	=	"G (" ++ show p ++ ")"
	show (F p)	=	"F (" ++ show p ++ ")"
	 


isAX :: Formula -> Bool
isAX (A(X _)) = True
isAX _ = False

isEX :: Formula -> Bool
isEX (E(X _)) = True
isEX _ = False

isEU :: Formula -> Bool
isEU (E(U _ _)) = True
isEU _ = False

isAU :: Formula -> Bool
isAU (A(U _ _)) = True
isAU _ = False

isProp :: Formula -> Bool
isProp (Prop _) = True
isProp _ = False

isNegLiteral :: Formula -> Bool
isNegLiteral (Not f) = isProp f
isNegLiteral _ = False

isLiteral :: Formula -> Bool
isLiteral f = (isProp f) || (isNegLiteral f)

isNLit = isNegLiteral

isPLit = isProp


chopEX :: Formula -> Formula
chopEX (E (X f)) = f
chopEX f = f

chopAX :: Formula -> Formula
chopAX (A (X f)) = f
chopAX f = f 




elementary :: Formula -> Bool
elementary (Not f) = elementary f
elementary (E (X _)) = True
elementary (A (X _)) = True
elementary (Prop _) = True
elementary Norm = True
elementary TrueConst = True
elementary FalseConst = True
elementary _ = False
--elementary P (X _) = True
--elementary O (X _) = True

isAlpha :: Formula -> Bool
isAlpha f = if elementary f then 
				False 
			else 
				1 == (length $ break_rule f) 

isBeta :: Formula -> Bool
isBeta f = if elementary f then 
				False 
			else 
				1 < (length $ break_rule f)  




break :: Formula -> Set (Set Formula)
break f = S.fromList (map S.fromList (break_rule f))

break_rule :: Formula -> [[Formula]]
-- Propositional
break_rule (Or p q)		=	[[p],[q]]
break_rule (And p q)	= 	[[p,q]]
break_rule (If p q)		=	[[negate p],[q]]
break_rule (Iff p q)	=	[[negate p, negate q],[p,q]]
break_rule (Xor p q)	=	[[negate p, q],[p, negate q]]
-- All
break_rule (A (U p q))	=	[[q],[p, A (X (A (U p q)))]]
break_rule (A (W p q))	=	[[q],[p, A (X (A (W p q)))]]
break_rule (A (G p))	=	[[p, A (X (A (G p)))]]
-- Exists
break_rule (E (U p q))	=	[[q],[p, E (X (E (U p q)))]]
break_rule (E (W p q))	=	[[q],[p, E (X (E (W p q)))]]
break_rule (E (G p))	=	[[p, E (X (E (G p)))]]
-- Obligation
break_rule (O (G p))	=	[[Norm, p, O (X (O (G p)))]]
break_rule (O (U p q))	=	[[Norm, q],[Norm, p, O (X (O (U p q)))]]
break_rule (O (X p))	=	[[A(X (Or (Not Norm) p))]]
-- Permission
break_rule (P (U p q))	=	[[Norm, q],[Norm, p, P (X (P (U p q)))]]
break_rule (P (X p))	=	[[E(X (And Norm p))]]



negate :: Formula -> Formula
-- Propositional
negate (Not f) 		= 	f
negate (Or p q)		=	And (negate p) (negate q)
negate (And p q)	= 	Or (negate p) (negate q)
negate (If p q)		=	And p (negate q)
negate (Iff p q)	=	Xor p q --Or (And (negate p) q) (And p (negate q))
negate (Xor p q)	=	Iff p q --Or (And (negate p) q) (And p (negate q))
negate (Prop p)		=	Not (Prop p)
negate Norm			=	Not Norm
negate TrueConst 			=	FalseConst
negate FalseConst 			=	TrueConst
-- All
negate (A (X p))	=	E (X (negate p))
negate (A (U p q))	=	E (W (negate q) (And (negate p) (negate q)))
negate (A (W p q))	=	E (U (negate q) (And (negate p) (negate q)))
-- Exists
negate (E (X p))	=	A (X (negate p))
negate (E (U p q))	=	A (W (negate q) (And (negate p) (negate q)))
negate (E (W p q))	=	A (U (negate q) (And (negate p) (negate q)))
-- Obligation
negate (O (U p q))	=	P (W (negate q) (And (negate p) (negate q)))
negate (O (W p q))	=	P (U (negate q) (And (negate p) (negate q)))
negate (O (X p))	=	P (X (negate p))
-- Permission
negate (P (U p q))	=	O (W (negate q) (And (negate p) (negate q)))
negate (P (W p q))	=	O (U (negate q) (And (negate p) (negate q)))
negate (P (X p))	=	O (X (negate p))


-- Branching rank: determines how many branches are introduced by the formula			
brrk :: Formula -> Int
brrk (Or p q)		=	brrk p + brrk q
brrk (And p q)		= 	brrk p * brrk q	
brrk (If p q)		=	brrk p + brrk q
brrk (Iff p q)	=	2 * (brrk p + brrk q)
brrk (Prop p)		=	1
brrk Norm			=	1
brrk TrueConst 		=	1
brrk FalseConst		=	0
-- we assume NNF
brrk (Not f) 		= 	brrk f
-- All
brrk (A (X p))	=	1
brrk (A (U p q))	=	brrk p + brrk q
brrk (A (W p q))	=	brrk p + brrk q
-- Exists
brrk (E (X p))	=	1
brrk (E (U p q))	=	brrk p + brrk q
brrk (E (W p q))	=	brrk p + brrk q
-- Obligation
brrk (O (U p q))	=	brrk p + brrk q
brrk (O (W p q))	=	brrk p + brrk q
brrk (O (X p))	=	1
-- Permission
brrk (P (U p q))	=	brrk p + brrk q
brrk (P (W p q))	=	brrk p + brrk q
brrk (P (X p))	=	1



-- Fischer-Lander Closure: returns every subformula of f
cl :: Formula -> [Formula]
cl TrueConst = []
cl FalseConst = []
cl f@(Prop p) = [f]
cl f@(And p q) = f : (cl p ++ cl q)
cl f@(Or p q) = f : (cl p ++ cl q)
cl f@(If p q) = f : (cl p ++ cl q)
cl f@(Iff p q) = f : (cl p ++ cl q)
cl f@(Xor p q) = f : (cl p ++ cl q)
cl f@(Not p) = f : cl p

cl f@(A (X p)) = f : cl p
cl f@(A (U p q)) = f : (cl q ++ cl p ++ [A (X (A (U p q)))])
cl f@(A (W p q)) = f : (cl q ++ cl p ++ [A (X (A (W p q)))])
cl f@(A (G p)) = f : (cl p ++ [A (X (A (G p)))])
-- Exists
cl f@(E (X p)) = f : cl p
cl f@(E (U p q)) = f : (cl q ++ cl p ++ [E (X (E (U p q)))])
cl f@(E (W p q))	= f : (cl p ++ cl q ++ [E (X (E (W p q)))])
cl f@(E (G p))	= f : (cl p ++ [E (X (E (G p)))])
cl f@_ = error ("no match for : " ++ show f)
-- Obligation
--cl f@(O (U p q))	= f :	[[Norm, q],[Norm, p, O (X (O (U p q)))]]
--cl f@(O (W p q))	= f :	 [[Norm, q],[Norm, p, O (X (O (W p q)))]]
--cl f@(O (X p))	= f :	[[A(X (Or (Not Norm) p))]]
-- Permission
--cl f@(P (U p q))	=	f : [[Norm, q],[Norm, p, P (X (P (U p q)))]]
--cl f@(P (W p q))	=	f : [[Norm, q],[Norm, p, P (X (P (W p q)))]]
--cl f@(P (X p))	= f :	[[E(X (And Norm p))]]







inconsistent :: Set Formula -> Bool
inconsistent s | (S.member FalseConst s) = True
inconsistent s | (S.member Norm s && S.member (Not Norm) s) = True
inconsistent s = (S.member FalseConst s) || (not $ S.null $ S.intersection pos (S.map chopNeg neg))
					where
						pos = S.filter isProp s
						neg = S.filter isNegLiteral s
						chopNeg = \f -> case f of
											(Not x) -> x
											_ -> f


{-
closure :: Set Formula -> Set (Set Formula)
closure s = let r1 = S.filter (not . inconsistent) (closure_impl s) in
				S.fromList (pick_one_of_each (S.toList r1) [])

pick_one_of_each :: [Set Formula] -> [Set Formula] -> [Set Formula]
pick_one_of_each [] r = r
pick_one_of_each (s:xs) r = if (any (\x -> filter_elem x == filter_elem s) r) then
								pick_one_of_each xs r
							else
								pick_one_of_each xs (s:r)	

	where filter_elem = S.filter $ elementary



closure_impl :: Set Formula -> Set (Set Formula)
closure_impl s =  case S.toList (S.filter (not . elementary) s) of 
				(f:fs) 	-> let sminf = S.delete f s in 
								let subcalls = S.map (sminf `S.union`) (break f) in
				 					let subresults = S.fold S.union S.empty (S.map closure subcalls) in
				 						S.map (f `S.insert`) subresults
				[] 	-> 	S.singleton s



-}


