module Main where

import System.IO (hSetBuffering, stdout, BufferMode(..))
import Data.Char (toUpper)

main =
    do
    initialiseIO
    getType

getOs = 
    do
    putStrLn $ "known OSs = " ++ show allOSs
    os <- getElement "operating system"
    putStrLn $ show os ++ " is of type: " ++ show (os2OSType os)

getType = 
    do
    putStrLn $ "Known Types = " ++ show allTypes
    ost <- getElement "operating system type"
    putStrLn $ show (ost2OS ost) ++ " is an example of a " ++ show ost ++ " OS"

initialiseIO =
    do
    hSetBuffering stdout NoBuffering
        -- ensure any console output is shown asap

data OS = ANDROID | IOS | MACOSX | WINDOWS8 | WP8 | VXWORKS
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)
data OSType = DESKTOP | EMBEDDED | MOBILE
    deriving (Show, -- default formatting
              Read, -- default parsing
              Eq,   -- default equality testing
              Bounded, -- default minBound and maxBound
              Enum) -- default sequencing (needed for .. ranges)

allOSs :: [OS] -- ie it is a list of OS elements
allOSs = [minBound .. maxBound]
allTypes :: [OSType]
allTypes = [minBound .. maxBound]

os2OSType ANDROID = MOBILE
os2OSType IOS = MOBILE
os2OSType MACOSX = DESKTOP
os2OSType WINDOWS8 = DESKTOP
os2OSType WP8 = MOBILE
os2OSType VXWORKS = EMBEDDED

ost2OS MOBILE = ANDROID
ost2OS DESKTOP = MACOSX
ost2OS EMBEDDED = VXWORKS

getElement elementTypeName =
    keepTrying
    where
    keepTrying =
        do
        showPrompt
        line <- getLine -- get whatever user types as a string
        let lineUpperCase = map toUpper line -- convert each character to upper case
        case reads lineUpperCase of -- attempt to parse the string
                -- after converting all characters to upper case
            [] -> -- no valid interpretation of the line as an element
                do
                reportError
                keepTrying -- try again - using recursion
            ((e,_) : _) -> -- at least one interpretation - it is given the name e
                    -- underscore here means "anything - its value does not matter"
                return e -- type of e is derived from context
                        -- where getElement is used
    showPrompt =
        putStr ("Input one " ++ elementTypeName ++ ": ")
    reportError =
        putStrLn ("Invalid " ++ elementTypeName ++ ", try again")
