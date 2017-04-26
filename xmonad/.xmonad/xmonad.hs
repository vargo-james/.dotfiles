import XMonad
--import XMonad.Actions.Volume
import Data.Map (fromList)
import Data.Monoid (mappend)
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

myFocusedBorderColor = "#00AA00"

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig { --keys = keys defaultConfig `mappend`
--        \c -> fromList  [
--                ((0, xK_F1), toggleMute  >> return ()),
--                ((0, xK_F2), lowerVolume 4 >> return ()),
 --               ((0, xK_F3), raiseVolume 4 >> return ())
 --       ],
         manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = mod4Mask -- Rebind Mod to the super key
        , focusedBorderColor = myFocusedBorderColor
        } `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock; xset dpms force off")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
