module Unholy.UnsafeSharedMemory where

import Control.Monad.Trans.Maybe
import Control.Monad.Trans.Class
import Foreign.C.Types
import Control.Exception
import Foreign.Marshal.Alloc
import Foreign.Ptr
import Foreign.Storable

foreign import ccall "initSharedMemory" initSharedMemory' :: CUInt -> CInt
initSharedMemory :: CUInt -> IO ()
initSharedMemory size = case (initSharedMemory' size) of
    0 -> ioError $ userError "Out of memory"
    1 -> return ()

foreign import ccall "resizeSharedMemory" resizeSharedMemory' :: CUInt -> CInt
resizeSharedMemory :: CUInt -> IO ()
resizeSharedMemory size = case (resizeSharedMemory' size) of
    0 -> ioError $ userError "Out of memory"
    1 -> return ()

foreign import ccall "getSharedMemorySize" getSharedMemorySize :: CUInt

foreign import ccall "writeSharedMemory" writeSharedMemory' :: CChar -> CUInt -> CInt
writeSharedMemory :: CChar -> CUInt -> IO ()
writeSharedMemory byte offset = case (writeSharedMemory' byte offset) of
    0 -> ioError $ userError "Out of bounds write"
    1 -> return ()

foreign import ccall "readSharedMemory" readSharedMemory' :: Ptr CChar -> CUInt -> CInt
readSharedMemory :: CUInt -> IO (Either CChar ())
readSharedMemory offset = alloca (handleCharPtr offset)
    where
        handleCharPtr :: CUInt -> Ptr CChar -> IO (Either CChar ())
        handleCharPtr offset ptr = case (readSharedMemory' ptr offset) of
            0 -> do
                e <- ioError $ userError "Out of bounds read"
                return (Right e)
            1 -> (peek ptr) >>= (return . Left)

foreign import ccall "freeSharedMemory" freeSharedMemory :: IO ()
