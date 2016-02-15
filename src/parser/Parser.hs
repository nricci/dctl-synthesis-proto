{-# OPTIONS_GHC -w #-}
module Parser where
import Lexer
import Dctl
import Control.Applicative(Applicative(..))

-- parser produced by Happy Version 1.19.4

data HappyAbsSyn t4 t5 t6
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6

action_0 (7) = happyShift action_3
action_0 (8) = happyShift action_4
action_0 (9) = happyShift action_5
action_0 (15) = happyShift action_6
action_0 (16) = happyShift action_7
action_0 (22) = happyShift action_8
action_0 (25) = happyShift action_9
action_0 (4) = happyGoto action_10
action_0 (5) = happyGoto action_11
action_0 _ = happyFail

action_1 (7) = happyShift action_3
action_1 (8) = happyShift action_4
action_1 (9) = happyShift action_5
action_1 (15) = happyShift action_6
action_1 (16) = happyShift action_7
action_1 (22) = happyShift action_8
action_1 (25) = happyShift action_9
action_1 (5) = happyGoto action_2
action_1 _ = happyFail

action_2 (10) = happyShift action_12
action_2 (11) = happyShift action_13
action_2 (12) = happyShift action_14
action_2 (13) = happyShift action_15
action_2 (14) = happyShift action_16
action_2 (24) = happyShift action_26
action_2 _ = happyFail

action_3 _ = happyReduce_14

action_4 _ = happyReduce_15

action_5 (7) = happyShift action_3
action_5 (8) = happyShift action_4
action_5 (9) = happyShift action_5
action_5 (15) = happyShift action_6
action_5 (16) = happyShift action_7
action_5 (22) = happyShift action_8
action_5 (25) = happyShift action_9
action_5 (5) = happyGoto action_25
action_5 _ = happyFail

action_6 (7) = happyShift action_3
action_6 (8) = happyShift action_4
action_6 (9) = happyShift action_5
action_6 (15) = happyShift action_6
action_6 (16) = happyShift action_7
action_6 (17) = happyShift action_21
action_6 (18) = happyShift action_22
action_6 (19) = happyShift action_23
action_6 (22) = happyShift action_8
action_6 (25) = happyShift action_9
action_6 (5) = happyGoto action_19
action_6 (6) = happyGoto action_24
action_6 _ = happyFail

action_7 (7) = happyShift action_3
action_7 (8) = happyShift action_4
action_7 (9) = happyShift action_5
action_7 (15) = happyShift action_6
action_7 (16) = happyShift action_7
action_7 (17) = happyShift action_21
action_7 (18) = happyShift action_22
action_7 (19) = happyShift action_23
action_7 (22) = happyShift action_8
action_7 (25) = happyShift action_9
action_7 (5) = happyGoto action_19
action_7 (6) = happyGoto action_20
action_7 _ = happyFail

action_8 (7) = happyShift action_3
action_8 (8) = happyShift action_4
action_8 (9) = happyShift action_5
action_8 (15) = happyShift action_6
action_8 (16) = happyShift action_7
action_8 (22) = happyShift action_8
action_8 (25) = happyShift action_9
action_8 (5) = happyGoto action_18
action_8 _ = happyFail

action_9 _ = happyReduce_13

action_10 (26) = happyAccept
action_10 _ = happyFail

action_11 (10) = happyShift action_12
action_11 (11) = happyShift action_13
action_11 (12) = happyShift action_14
action_11 (13) = happyShift action_15
action_11 (14) = happyShift action_16
action_11 (24) = happyShift action_17
action_11 _ = happyReduce_3

action_12 (7) = happyShift action_3
action_12 (8) = happyShift action_4
action_12 (9) = happyShift action_5
action_12 (15) = happyShift action_6
action_12 (16) = happyShift action_7
action_12 (22) = happyShift action_8
action_12 (25) = happyShift action_9
action_12 (5) = happyGoto action_38
action_12 _ = happyFail

action_13 (7) = happyShift action_3
action_13 (8) = happyShift action_4
action_13 (9) = happyShift action_5
action_13 (15) = happyShift action_6
action_13 (16) = happyShift action_7
action_13 (22) = happyShift action_8
action_13 (25) = happyShift action_9
action_13 (5) = happyGoto action_37
action_13 _ = happyFail

action_14 (7) = happyShift action_3
action_14 (8) = happyShift action_4
action_14 (9) = happyShift action_5
action_14 (15) = happyShift action_6
action_14 (16) = happyShift action_7
action_14 (22) = happyShift action_8
action_14 (25) = happyShift action_9
action_14 (5) = happyGoto action_36
action_14 _ = happyFail

action_15 (7) = happyShift action_3
action_15 (8) = happyShift action_4
action_15 (9) = happyShift action_5
action_15 (15) = happyShift action_6
action_15 (16) = happyShift action_7
action_15 (22) = happyShift action_8
action_15 (25) = happyShift action_9
action_15 (5) = happyGoto action_35
action_15 _ = happyFail

action_16 (7) = happyShift action_3
action_16 (8) = happyShift action_4
action_16 (9) = happyShift action_5
action_16 (15) = happyShift action_6
action_16 (16) = happyShift action_7
action_16 (22) = happyShift action_8
action_16 (25) = happyShift action_9
action_16 (5) = happyGoto action_34
action_16 _ = happyFail

action_17 (7) = happyShift action_3
action_17 (8) = happyShift action_4
action_17 (9) = happyShift action_5
action_17 (15) = happyShift action_6
action_17 (16) = happyShift action_7
action_17 (22) = happyShift action_8
action_17 (25) = happyShift action_9
action_17 (4) = happyGoto action_27
action_17 (5) = happyGoto action_11
action_17 _ = happyReduce_2

action_18 (10) = happyShift action_12
action_18 (11) = happyShift action_13
action_18 (12) = happyShift action_14
action_18 (13) = happyShift action_15
action_18 (14) = happyShift action_16
action_18 (23) = happyShift action_33
action_18 _ = happyFail

action_19 (10) = happyShift action_12
action_19 (11) = happyShift action_13
action_19 (12) = happyShift action_14
action_19 (13) = happyShift action_15
action_19 (14) = happyShift action_16
action_19 (20) = happyShift action_31
action_19 (21) = happyShift action_32
action_19 _ = happyFail

action_20 _ = happyReduce_11

action_21 (7) = happyShift action_3
action_21 (8) = happyShift action_4
action_21 (9) = happyShift action_5
action_21 (15) = happyShift action_6
action_21 (16) = happyShift action_7
action_21 (22) = happyShift action_8
action_21 (25) = happyShift action_9
action_21 (5) = happyGoto action_30
action_21 _ = happyFail

action_22 (7) = happyShift action_3
action_22 (8) = happyShift action_4
action_22 (9) = happyShift action_5
action_22 (15) = happyShift action_6
action_22 (16) = happyShift action_7
action_22 (22) = happyShift action_8
action_22 (25) = happyShift action_9
action_22 (5) = happyGoto action_29
action_22 _ = happyFail

action_23 (7) = happyShift action_3
action_23 (8) = happyShift action_4
action_23 (9) = happyShift action_5
action_23 (15) = happyShift action_6
action_23 (16) = happyShift action_7
action_23 (22) = happyShift action_8
action_23 (25) = happyShift action_9
action_23 (5) = happyGoto action_28
action_23 _ = happyFail

action_24 _ = happyReduce_12

action_25 _ = happyReduce_9

action_26 (7) = happyShift action_3
action_26 (8) = happyShift action_4
action_26 (9) = happyShift action_5
action_26 (15) = happyShift action_6
action_26 (16) = happyShift action_7
action_26 (22) = happyShift action_8
action_26 (25) = happyShift action_9
action_26 (4) = happyGoto action_27
action_26 (5) = happyGoto action_11
action_26 _ = happyFail

action_27 _ = happyReduce_1

action_28 (10) = happyShift action_12
action_28 (11) = happyShift action_13
action_28 (12) = happyShift action_14
action_28 (13) = happyShift action_15
action_28 (14) = happyShift action_16
action_28 _ = happyReduce_19

action_29 (10) = happyShift action_12
action_29 (11) = happyShift action_13
action_29 (12) = happyShift action_14
action_29 (13) = happyShift action_15
action_29 (14) = happyShift action_16
action_29 _ = happyReduce_20

action_30 (10) = happyShift action_12
action_30 (11) = happyShift action_13
action_30 (12) = happyShift action_14
action_30 (13) = happyShift action_15
action_30 (14) = happyShift action_16
action_30 _ = happyReduce_18

action_31 (7) = happyShift action_3
action_31 (8) = happyShift action_4
action_31 (9) = happyShift action_5
action_31 (15) = happyShift action_6
action_31 (16) = happyShift action_7
action_31 (22) = happyShift action_8
action_31 (25) = happyShift action_9
action_31 (5) = happyGoto action_40
action_31 _ = happyFail

action_32 (7) = happyShift action_3
action_32 (8) = happyShift action_4
action_32 (9) = happyShift action_5
action_32 (15) = happyShift action_6
action_32 (16) = happyShift action_7
action_32 (22) = happyShift action_8
action_32 (25) = happyShift action_9
action_32 (5) = happyGoto action_39
action_32 _ = happyFail

action_33 _ = happyReduce_10

action_34 (10) = happyShift action_12
action_34 (11) = happyShift action_13
action_34 _ = happyReduce_8

action_35 (10) = happyShift action_12
action_35 (11) = happyShift action_13
action_35 _ = happyReduce_7

action_36 (10) = happyShift action_12
action_36 (11) = happyShift action_13
action_36 _ = happyReduce_6

action_37 _ = happyReduce_5

action_38 _ = happyReduce_4

action_39 (10) = happyShift action_12
action_39 (11) = happyShift action_13
action_39 (12) = happyShift action_14
action_39 (13) = happyShift action_15
action_39 (14) = happyShift action_16
action_39 _ = happyReduce_17

action_40 (10) = happyShift action_12
action_40 (11) = happyShift action_13
action_40 (12) = happyShift action_14
action_40 (13) = happyShift action_15
action_40 (14) = happyShift action_16
action_40 _ = happyReduce_16

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 (HappyAbsSyn4  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_1 : happy_var_3
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 _
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  4 happyReduction_3
happyReduction_3 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  5 happyReduction_4
happyReduction_4 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (And happy_var_1 happy_var_3
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  5 happyReduction_5
happyReduction_5 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (Or happy_var_1 happy_var_3
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_3  5 happyReduction_6
happyReduction_6 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (If happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (Iff happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn5
		 (Xor happy_var_1 happy_var_3
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_2  5 happyReduction_9
happyReduction_9 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Not happy_var_2
	)
happyReduction_9 _ _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_3  5 happyReduction_10
happyReduction_10 _
	(HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (happy_var_2
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_2  5 happyReduction_11
happyReduction_11 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (A happy_var_2
	)
happyReduction_11 _ _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_2  5 happyReduction_12
happyReduction_12 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (E happy_var_2
	)
happyReduction_12 _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  5 happyReduction_13
happyReduction_13 (HappyTerminal (TokenVar happy_var_1))
	 =  HappyAbsSyn5
		 (Prop happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  5 happyReduction_14
happyReduction_14 _
	 =  HappyAbsSyn5
		 (TrueConst
	)

happyReduce_15 = happySpecReduce_1  5 happyReduction_15
happyReduction_15 _
	 =  HappyAbsSyn5
		 (FalseConst
	)

happyReduce_16 = happySpecReduce_3  6 happyReduction_16
happyReduction_16 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (U happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  6 happyReduction_17
happyReduction_17 (HappyAbsSyn5  happy_var_3)
	_
	(HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn6
		 (W happy_var_1 happy_var_3
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_2  6 happyReduction_18
happyReduction_18 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (X happy_var_2
	)
happyReduction_18 _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  6 happyReduction_19
happyReduction_19 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (G happy_var_2
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_2  6 happyReduction_20
happyReduction_20 (HappyAbsSyn5  happy_var_2)
	_
	 =  HappyAbsSyn6
		 (F happy_var_2
	)
happyReduction_20 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 26 26 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenTrue -> cont 7;
	TokenFalse -> cont 8;
	TokenNot -> cont 9;
	TokenAnd -> cont 10;
	TokenOr -> cont 11;
	TokenImplies -> cont 12;
	TokenIff -> cont 13;
	TokenXor -> cont 14;
	TokenExists -> cont 15;
	TokenAll -> cont 16;
	TokenNext -> cont 17;
	TokenFuture -> cont 18;
	TokenGlobally -> cont 19;
	TokenUntil -> cont 20;
	TokenWUntil -> cont 21;
	TokenLParen -> cont 22;
	TokenRParen -> cont 23;
	TokenSemi -> cont 24;
	TokenVar happy_dollar_dollar -> cont 25;
	_ -> happyError' (tk:tks)
	}

happyError_ 26 tk tks = happyError' tks
happyError_ _ tk tks = happyError' (tk:tks)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure    = return
    a <*> b = (fmap id a) <*> b
instance Monad HappyIdentity where
    return = HappyIdentity
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => [(Token)] -> HappyIdentity a
happyError' = HappyIdentity . parseError

parseSpecFromTokenStream tks = happyRunIdentity happySomeParser where
  happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseSpecification :: String -> [Formula]
parseSpecification s = parseSpecFromTokenStream $ scanTokens s

parseError :: [Token] -> a
parseError ts = error ("Parse error" ++ show ts)
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 


{-# LINE 13 "templates/GenericTemplate.hs" #-}


{-# LINE 46 "templates/GenericTemplate.hs" #-}









{-# LINE 67 "templates/GenericTemplate.hs" #-}


{-# LINE 77 "templates/GenericTemplate.hs" #-}










infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action


{-# LINE 155 "templates/GenericTemplate.hs" #-}

-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail  i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.

