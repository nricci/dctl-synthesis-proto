#!/opt/local/bin/runhugs

import System.Environment
import Dctl
import Parser
import ParseLib
import Tableaux

import qualified Data.Set as S
import Data.Set (Set)
import qualified SetAux as S

import Debug.Trace

import qualified Model as Model
import Model (Model)

import Data.Maybe        (isJust, fromJust, isJust, fromMaybe)
import System.Exit

import SyncProduct

main = do {
	args <- getArgs;
	--k <- return $ (read (args !! 3) :: Int);
	sync <- synthesize (args !! 0) "synthesizing-synchonizer-process";
	sync <- if isJust sync then return $ fromJust sync else exitFailure; 
	proc1 <- synthesize (args !! 1) "synthesizing-process-1";
	proc1 <- if isJust proc1 then return $ fromJust proc1 else exitFailure; 
	proc2 <- synthesize (args !! 2) "synthesizing-process-2";
	proc2 <- if isJust proc2 then return $ fromJust proc2 else exitFailure;
	putStrLn "Building composite system.";
	final <- return $ SyncProduct.product sync proc1 proc2;
	--final <- SyncProduct.product_debug k sync proc1 proc2;
	writeFile ("output/sync.dot") (tab2dot final);
	putStrLn ("Cheers!");
}



synthesize :: String -> String -> IO (Maybe Tableaux) 
synthesize = \path msg -> do {
	putStrLn $ "[" ++ msg ++ "] spec location: " ++ path;
	str <- readFile path;
	spec <- return $ parseSpecification str;
	putStrLn $ "[" ++ msg ++ "] specification successfully parsed (" ++ (show (S.size spec)) ++ " formulas).";
	putStr $ "[" ++ msg ++ "] running tableaux .. ";
	t <- return $ do_tableaux $ make_tableaux spec;
	putStrLn $ "done (" ++ (show $ S.size $ nodes t ) ++ " nodes).";
	-- writeFile "output/tableaux_raw.dot" (tab2dot t);
	putStr $ "[" ++ msg ++ "] refining tableaux .. ";
	t2 <- return $ refine_tableaux t;
	putStrLn ("done.");
	if not $ S.null $ nodes t2 then
		do 
			writeFile ("output/tableaux-" ++ msg ++ ".dot") (tab2dot t2);
			putStrLn "";
			return $ Just t2;
	else 
		do
			putStrLn $ "[" ++ msg ++ "] inconsistent spec.";
			putStrLn "";
			return Nothing;
}









