module SyncProduct where


import Tableaux

import qualified Data.Set as S
import Data.Set (Set)
import qualified SetAux as S

import qualified Data.Map as M
import Data.Map (Map)

import qualified Relation as R
import Relation (Relation)

import Dctl

import Debug.Trace


do_something = print "hola"

data ProdState = ProdState {
					p1 :: Tableaux, 
					p2 :: Tableaux,
					p3 :: Tableaux,
					mapp :: Map Node (Node, Node, Node),
					r :: Tableaux
				} deriving Eq

-- Sync product of three tableaux
product :: Tableaux -> Tableaux -> Tableaux -> Tableaux
product t1 t2 t3 = r $ do_prod $ ProdState t1 t2 t3 m tab
	
	where
		m = M.fromList [(rt, ((root t1), (root t2), (root t3)))]
		tab = Tableaux rt (S.singleton rt) R.empty
		rt = mergenodes ((root t1), (root t2), (root t3))


-- Fixpoints the product state
do_prod :: ProdState -> ProdState
do_prod st = let st' = step st in
				if st' == st then (trace "st") st else do_prod $ (trace "st'") st'



-- Product step. Expands one node in the parallel tableaux.
step :: ProdState -> ProdState
step st = case S.pick $ frontier $ r st of
				Nothing -> st
				(Just n) -> ProdState (p1 st) (p2 st) (p3 st) map' r'
					where
						map' = M.union (mapp st) $ M.fromList $ zip newnodes prodsuccs_refined
						r' = Tableaux (root $ r st) nodes' rel'
						nodes' = (nodes $ r st) S.+ (S.fromList $ (trace ("newnodes = " ++ (show newnodes) ++ "\n")) newnodes)
						rel' = (rel $ r st) `R.union` R.fromList [(n,succ) | succ <- newnodes]
						newnodes = (trace ("prodsuccs_refined = " ++ (show prodsuccs_refined) ++ "\n")) map mergenodes prodsuccs_refined	
						prodsuccs_refined = (trace ("prodsuccs = " ++ (show prodsuccs) ++ "\n")) filter agree prodsuccs
						prodsuccs = [(s1', s2', s3') | s1' <- succs1, s2' <- succs2, s3' <- succs3]
						succs1 = S.toList $ succesors (p1 st) n1
						succs2 = S.toList $ succesors (p2 st) n2
						succs3 = S.toList $ succesors (p3 st) n3
						--succs3 = S.toList $ if isOr n3 then blocks n3 else tiles n3			
						(n1, n2, n3) = (mapp st) M.! (trace ("n = " ++ show n ++ "\n")) n


mergenodes = \(x,y,z) -> 	if isOr x then 
								OrNode (formulas x S.+ formulas y S.+ formulas z)
							else
								AndNode (formulas x S.+ formulas y S.+ formulas z)



-- Checks whether three nodes of the same type agree on common variables.
agree :: (Node, Node, Node) -> Bool
agree ((OrNode fs1), (OrNode fs2), (OrNode fs3)) = agree_imp fs1 fs2 fs3
agree ((AndNode fs1), (AndNode fs2), (AndNode fs3)) = agree_imp fs1 fs2 fs3



agree_imp :: Set Formula -> Set Formula -> Set Formula -> Bool
agree_imp sy p1 p2 = (prop_sat p1 sem1) == (prop_sat sy sem1) && (prop_sat p2 sem2) == (prop_sat sy sem2)

	where
		sem1 = Prop "s1"
		sem2 = Prop "s2"
	



-- Sync product of three tableaux
product_debug :: Int -> Tableaux -> Tableaux -> Tableaux -> IO Tableaux
product_debug (i+1) t1 t2 t3 = do {
								init <- return $ ProdState t1 t2 t3 m tab;
								current <- return $ init;
								writeFile ("output/sync-" ++ (show i) ++ ".dot") (tab2dot $ r current);
								current <- product_debug_loop i current;
								return $ r current;
							}
	where
		m = M.fromList [(rt, ((root t1), (root t2), (root t3)))]
		tab = Tableaux rt (S.singleton rt) R.empty
		rt = mergenodes ((root t1), (root t2), (root t3))


product_debug_loop :: Int -> ProdState -> IO ProdState
product_debug_loop 0 st = return $ st
product_debug_loop (i+1) st = do {
									current <- return $ st;
									current <- return $ step current;
									writeFile ("output/sync-" ++ (show i) ++ ".dot") (tab2dot $ r current);
									product_debug_loop i current;
								}














