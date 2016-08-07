module Paths_seiji_tools (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/home/nesachirou/dev/seiji-tools/.stack-work/install/x86_64-linux/lts-6.10/7.10.3/bin"
libdir     = "/home/nesachirou/dev/seiji-tools/.stack-work/install/x86_64-linux/lts-6.10/7.10.3/lib/x86_64-linux-ghc-7.10.3/seiji-tools-0.1.0.0-JqMLd3RoigsJ1A7CPurlWI"
datadir    = "/home/nesachirou/dev/seiji-tools/.stack-work/install/x86_64-linux/lts-6.10/7.10.3/share/x86_64-linux-ghc-7.10.3/seiji-tools-0.1.0.0"
libexecdir = "/home/nesachirou/dev/seiji-tools/.stack-work/install/x86_64-linux/lts-6.10/7.10.3/libexec"
sysconfdir = "/home/nesachirou/dev/seiji-tools/.stack-work/install/x86_64-linux/lts-6.10/7.10.3/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "seiji_tools_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "seiji_tools_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "seiji_tools_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "seiji_tools_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "seiji_tools_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
