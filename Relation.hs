-----------------------------------------------------------------------------
-- |
-- Module      :  Data.Relation
-- Copyright   :  (c) DD.  2012
--                (c) LFL. 2009
-- License     :  BSD-style
-- Maintainer  :  Drew Day<drewday@gmail.com>
-- Stability   :  experimental
-- Portability :  portable
--
-- Relations are modeled as assciations between two elements.
--
-- Relations offer efficient search for any of the two elements.
--
-- Unlike "Data.Map", an element ca be associated more than once.
--
-- The two purposes of this structure are:
--  
-- 1. Associating elements
--
-- 2. Provide efficient searches for either of the two elements.
--
-- Since neither 'map' nor 'fold' are implemented, you /must/ convert
-- the structure to a list to process sequentially.
--
--
module Relation (

   -- * The @Relation@ Type

   Relation ()  

   -- *  Provided functionality:
 
   -- ** Questions

 , size         --  # Tuples in the relation?
 , null         --  Is empty?

   -- ** Construction

 , empty        --  Construct an empty relation.
 , fromList     --  Relation <- []
 , singleton    --  Construct a relation with a single element.

   -- ** Operations

 , union        --  Union of two relations.
 , unions       --  Union on a list of relations.
 , insert       --  Insert a tuple to the relation.
 , delete       --  Delete a tuple from the relation.
   -- The Set of values associated with a value in the domain.
 , lookupDom     
   -- The Set of values associated with a value in the range.
 , lookupRan    
 , memberDom    --  Is the element in the domain?
 , memberRan    --  Is the element in the range?
 , member       --  Is the tuple   in the relation?
 , notMember    
 
   -- ** Conversion

 , toList       --  Construct a list from a relation
   --  Extract the elements of the range to a Set.
 , dom          
   --  Extract the elements of the domain to a Set.
 , ran

   -- ** Utilities

 , compactSet --  Compact a Set of Maybe's.
  
 -- $selectops
 , (|$>) -- Restrict the range according to a subset. PICA.
  
 , (<$|) -- Restrict the domain according to a subset. PICA.

 , (<|)  -- Domain restriction. Z.

 , (|>)  -- Range restriction. z.

   -- Not implemented 
     --   filter :: (a -> b -> Bool) -> Relation a b -> Relation a b
     --   map

  , (*)
  , (+)
  , closure
  , map
     
)

where

import           Prelude           hiding (null, (*), (+), (<=), map)
import qualified Prelude as Pre ((+), map)

import qualified Data.Map     as M
import qualified Data.Set     as S
import           Data.Maybe        (isJust, fromJust, fromMaybe)

-- |
-- This implementation avoids using @"S.Set (a,b)"@ because
-- it it is necessary to search for an item without knowing both @D@ and @R@.
--
-- In "S.Set", you must know both values to search.
--
-- Thus, we have are two maps to updated together.
--
-- 1. Always be careful with the associated set of the key.
--
-- 2. If you union two relations, apply union to the set of values.
--
-- 3. If you subtract, take care when handling the set of values.
--
-- As a multi-map, each key is asscoated with a Set of values v.
-- 
-- We do not allow the associations with the 'empty' Set.
--

data Relation a b  = Relation { domain ::  M.Map a (S.Set b)
                              , range  ::  M.Map b (S.Set a)
                              }

    deriving (Show, Eq, Ord)
    

-- * Functions about relations


-- The size is calculated using the domain.
-- |  @size r@ returns the number of tuples in the relation.

size    ::  Relation a b -> Int
size r  =   M.fold ((Pre.+) . S.size) 0 (domain r)



-- | Construct a relation with no elements.

empty   ::  Relation a b 
empty   =   Relation M.empty M.empty


  
-- |
-- The list must be formatted like: [(k1, v1), (k2, v2),..,(kn, vn)].

fromList    ::  (Ord a, Ord b) => [(a, b)] -> Relation a b
fromList xs =
    Relation 
        { domain =  M.fromListWith S.union $ snd2Set    xs
        , range   =  M.fromListWith S.union $ flipAndSet xs
        } 
    where  
       snd2Set    = Pre.map ( \(x,y) -> (x, S.singleton y) ) 
       flipAndSet = Pre.map ( \(x,y) -> (y, S.singleton x) )


-- |
-- Builds a List from a Relation.
toList   ::  Relation a b -> [(a,b)]
toList r =   concatMap
               ( \(x,y) -> zip (repeat x) (S.toList y) )
               ( M.toList . domain $ r)
  
  

-- | 
-- Builds a 'Relation' consiting of an association between: @x@ and @y@.

singleton      ::  a -> b -> Relation a b
singleton x y  =   Relation 
                     { domain = M.singleton x (S.singleton y) 
                     , range   = M.singleton y (S.singleton x)
                     }



-- | The 'Relation' that results from the union of two relations: @r@ and @s@.

(+) ::  (Ord a, Ord b) 
      =>  Relation a b -> Relation a b -> Relation a b
(+) =  union

union ::  (Ord a, Ord b) 
      =>  Relation a b -> Relation a b -> Relation a b

union r s       =  
    Relation 
      { domain =  M.unionWith S.union (domain r) (domain s)
      , range   =  M.unionWith S.union (range   r) (range   s)
      }


---------------------------------------------------------------
-- |
-- This fragment provided by:
--
-- @
-- \  Module      :  Data.Map
-- \  Copyright   :  (c) Daan Leijen 2002
-- \                 (c) Andriy Palamarchuk 2008
-- \  License     :  BSD-style
-- \  Maintainer  :  libraries\@haskell.org
-- \  Stability   :  provisional
-- \  Portability :  portable
-- @
--
--
foldlStrict         ::  (a -> b -> a) -> a -> [b] -> a
foldlStrict f z xs  =   case xs of
      []     -> z
      (x:xx) -> let z' = f z x in seq z' (foldlStrict f z' xx)
---------------------------------------------------------------


-- | Union a list of relations using the 'empty' relation.

unions       ::  (Ord a, Ord b) => [Relation a b] -> Relation a b

unions       =   foldlStrict union empty



-- | Insert a relation @ x @ and @ y @ in the relation @ r @

insert       ::  (Ord a, Ord b) 
             =>  a -> b -> Relation a b -> Relation a b

insert x y r =  -- r { domain = domain', range = range' } 
                Relation domain' range'
  where 
   domain'  =  M.insertWith S.union x (S.singleton y) (domain r)
   range'    =  M.insertWith S.union y (S.singleton x) (range   r)


-- $deletenotes 
-- 
-- The deletion is not difficult but is delicate:
--
-- @
--   r = { domain {  (k1, {v1a, v3})
--                 ,  (k2, {v2a})
--                 ,  (k3, {v3b, v3})
--                 }
--       , range   {  (v1a, {k1}
--                 ,  (v2a, {k2{
--                 ,  (v3 , {k1, k3}
--                 ,  (v3b, {k3}
--                 }
--      }
-- @
--
--   To delete (k,v) in the relation do:
--    1. Working with the domain:
--       1a. Delete v from the Set VS associated with k.
--       1b. If VS is empty, delete k in the domain.
--    2. Working in the range:
--       2a. Delete k from the Set VS associated with v.
--       2b. If VS is empty, delete v in the range. 
--         
--

-- |  Delete an association in the relation.
delete       ::  (Ord a, Ord b) 
             =>  a -> b -> Relation a b -> Relation a b

delete x y r  =  r { domain = domain', range = range' } 
   where 
   domain'   =  M.update (erase y) x (domain r)
   range'     =  M.update (erase x) y (range   r)
   erase e s =  if  S.singleton e == s
                     then  Nothing
                     else  Just $ S.delete e s
  
-- | The Set of values associated with a value in the domain.

lookupDom     ::  Ord a =>  a -> Relation a b -> Maybe (S.Set b)
lookupDom x r =   M.lookup  x  (domain r)



-- | The Set of values associated with a value in the range.

lookupRan     ::  Ord b =>  b -> Relation a b -> Maybe (S.Set a)
lookupRan y r =   M.lookup  y  (range   r)



-- | True if the element @ x @ exists in the domain of @ r @.

memberDom     ::  Ord a =>  a -> Relation a b -> Bool
memberDom x r =   isJust $ lookupDom x r



-- | True if the element exists in the range.

memberRan     ::  Ord b =>  b -> Relation a b -> Bool
memberRan y r =   isJust $ lookupRan y r



-- | 
-- True if the relation @r@ is the 'empty' relation.
null    ::  Relation a b -> Bool
null r  =   M.null $ domain r  
-- Before 2010/11/09 null::Ord b =>  Relation a b -> Bool

(<=) :: (Ord a, Ord b) => Relation a b -> Relation a b -> Bool
(<=) = subseteq

subseteq :: (Ord a, Ord b) => Relation a b -> Relation a b -> Bool
subseteq r r' = foldl (\x y -> x && member (fst y) (snd y) r') True (toList r)



-- | True if the relation contains the association @x@ and @y@

member       ::  (Ord a, Ord b) =>  a -> b -> Relation a b -> Bool
member x y r =   case lookupDom x r of
                      Just s  ->  S.member y s
                      Nothing ->  False
    


-- | True if the relation /does not/ contain the association @x@ and @y@

notMember       ::  (Ord a, Ord b) =>  a -> b -> Relation a b -> Bool
notMember x y r =   not $ member x y r



-- | Returns the domain in the relation, as a Set, in its entirety.

dom            ::  Relation a b -> S.Set a
dom r          =   M.keysSet (domain r)



-- | Returns the range of the relation, as a Set, in its entirety.

ran            ::  Relation a b -> S.Set b
ran r          =   M.keysSet (range   r)



-- |
-- A compact set of sets the values of which can be @Just (Set x)@ or @Nothing@.
--
-- The cases of 'Nothing' are purged.
--
-- It is similar to 'concat'.
compactSet ::  Ord a => S.Set (Maybe (S.Set a)) -> S.Set a

compactSet =   S.fold ( S.union . fromMaybe S.empty ) S.empty



-- $selectops
--
-- Primitive implementation for the /right selection/ and /left selection/ operators.
--
-- PICA provides both operators:
--        '|>'  and  '<|' 
-- and    '|$>' and '<$|'
--
-- in this library, for working with Relations and OIS (Ordered, Inductive Sets?).
--
-- PICA exposes the operators defined here, so as not to interfere with the abstraction
-- of the Relation type and because having access to Relation hidden components is a more
-- efficient implementation of the operation of restriction.
--
-- @
--     (a <$| b) r 
-- 
--       denotes: for every element     @b@ from the Set      @B@,
--                select an element @a@     from the Set @A@     ,
--                              if  @a@ 
--                   is related to      @b@
--                   in @r@
-- @
--
-- @
--     (a |$> b) r
-- 
--       denotes: for every element @a@      from the Set @A@    ,
--                select an element     @b@  from the Set     @B@,
--                              if  @a@ 
--                   is related to      @b@
--                   in @r@
-- @
--
-- With regard to domain restriction and range restriction operators
-- of the language, those are described differently and return the domain or the range.

-- | 
-- @(Case b <| r a)@
--
(<$|)          ::  (Ord a, Ord b) 
               =>  S.Set a -> S.Set b -> Relation a b -> S.Set a

(as <$| bs) r  =   as `S.intersection` generarAS bs

    where  generarAS = compactSet . S.map (`lookupRan` r) 
   
    -- The subsets of the domain (a) associated with each @b@
    -- such that @b@ in @B@ and (b) are in the range of the relation.
    -- The expression 'S.map' returns a set of @Either (S.Set a)@.


-- | 
-- @( Case a |> r b )@
(|$>)          ::  (Ord a, Ord b) 
               =>  S.Set a -> S.Set b -> Relation a b -> S.Set b

(as |$> bs) r  =   bs `S.intersection`  generarBS as

    where  generarBS = compactSet . S.map (`lookupDom` r) 



-- | Domain restriction for a relation. Modeled on z.

(<|) :: (Ord a, Ord b) => S.Set a -> Relation a b  -> Relation a b

s <| r  =  fromList $ concatMap
               ( \(x,y) -> zip (repeat x) (S.toList y) )
               ( M.toList domain' )
    where
    domain'  =  M.unions . Pre.map filtrar . S.toList $ s
    filtrar x =  M.filterWithKey (\k _ -> k == x) dr
    dr        =  domain r  -- just to memoize the value


-- | Range restriction for a relation. Modeled on z.

(|>) :: (Ord a, Ord b) => Relation a b -> S.Set b -> Relation a b

r |> t =  fromList $ concatMap
               ( \(x,y) -> zip (S.toList y) (repeat x) )
               ( M.toList range' )
    where
    range'    =  M.unions . Pre.map filtrar . S.toList $ t
    filtrar x =  M.filterWithKey (\k _ -> k == x) rr
    rr        =  range r   -- just to memoize the value


-- Note:
--  
--    As you have seen this implementation is expensive in terms
--    of storage. Information is registered twice.
--    For the operators |> and <| we follow a pattern used in
--    the @fromList@ constructor and @toList@ flattener:
--    It is enough to know one half of the Relation (the domain or
--    the range) to create to other half.
--    
-- 



-- Added by Nicolas Ricci
--
-- These methods expand on the module capabilities to fit the need of the tool

(*) :: (Ord a, Ord b, Ord c) => Relation a b -> Relation b c -> Relation a c
(*) = compose

compose :: (Ord a, Ord b, Ord c) => Relation a b -> Relation b c -> Relation a c
compose r r' = fromList cmp
  
    where cmp = [(a,c) |  a <- S.toList $ dom r, 
                          c <- S.toList $ ran r', 
                          not $ S.null $ S.intersection (img a r) (preimg c r')]


-- Auxiliary
img     ::  Ord a =>  a -> Relation a b -> S.Set b
img x r =   case M.lookup  x  (domain r) of
              Nothing -> S.empty
              (Just s) -> s

-- | The Set of values associated with a value in the range.
preimg     ::  Ord b =>  b -> Relation a b -> S.Set a
preimg y r =  case  M.lookup  y  (range   r) of
                Nothing -> S.empty
                (Just s) -> s



closure :: (Ord a) => Relation a a -> Relation a a
closure r = let r' = r + (r * r) in
              let iden = fromList [(x,x) | x <- S.toList (dom r `S.union` ran r)] in
              if r' <= r then r' + iden else closure r'



map :: (Ord a, Ord b) => (a -> b) -> Relation a a -> Relation b b
map f r =  fromList $ Pre.map (\p -> (f $ fst p, f $ snd p)) $ toList r


{-
aa = fromList [(1,2),(4,2),(2,5)]

bb = fromList [(2,3),(1,7),(2,5)]

cc :: Relation Int Int
cc = fromList [(i,i Pre.+ 1) | i <- [0..5]]

dd = fromList [(1,2),(2,3),(4,2),(1,7),(2,5)]

ed = fromList [(1,2),(2,3),(1,7),(2,5)]






-}




