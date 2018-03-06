module Main where

import Unholy.UnsafeSharedMemory
import Foreign.C.String
import Foreign.C.Types
import Control.Monad

ohMyGod :: IO ()
ohMyGod = do
    mapM_ (uncurry writeSharedMemory) cCharIndexedList
    return ()
    where
        cCharList = map (castCharToCChar) "oh no"
        cCharIndexedList = zip cCharList ([0..] :: [CUInt])

imSoSorry :: IO ()
imSoSorry = (sequence charList) >>= putStrLn
    where
        cCharIndexes = [0..4] :: [CUInt]

        readCCharList :: [IO (Either CChar ())]
        readCCharList = map readSharedMemory cCharIndexes

        handleEither :: Either CChar () -> Char
        handleEither (Left char) = castCCharToChar char
        handleEither (Right _) = ' ' -- for lack of better error handling

        charList :: [IO Char]
        charList = map (liftM handleEither) readCCharList

thisWasAMistake :: IO ()
thisWasAMistake = freeSharedMemory

main :: IO ()
main = do
    initSharedMemory 1024
    ohMyGod
    imSoSorry
    thisWasAMistake
