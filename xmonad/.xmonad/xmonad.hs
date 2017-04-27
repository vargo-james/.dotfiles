import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Prompt
import XMonad.Actions.Search
import System.IO

myFocusedBorderColor = "#00AA00" -- Green

-- Apps
myWebBrowser = "firefox-esr"
private = "-private-window"
myEmacs = "emacs"
-- Screenshot
makeScreenShot = "scrot"
-- Lock and turn off the screen.
myLockCommand = "xscreensaver-command -lock; xset dpms force off"
-- Volume Commands
setVolume = "amixer set Master "
myMute = setVolume ++ "mute"
myUnmute = setVolume ++ "unmute"
myRaiseVolume = setVolume ++ "10%+"
myLowerVolume = setVolume ++ "10%-"
-- Background
resetBackground = "safe"
slideShow = "random-slides ~/.extras/curves"

-- Hooks
myTitleColor = "green"
myTitleMaxLength = 30
myLogHook handle = dynamicLogWithPP xmobarPP {
              ppOutput = hPutStrLn handle,
              ppTitle  = 
                xmobarColor myTitleColor "" . shorten myTitleMaxLength
            }


main = do
  xmproc <- spawnPipe "xmobar"

  xmonad $ defaultConfig { 
    -- hooks
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = avoidStruts  $  layoutHook defaultConfig,
    logHook = myLogHook xmproc,
    -- Rebind the mod key to the super key
    modMask = mod4Mask,

    -- Basic Configuration
    focusedBorderColor = myFocusedBorderColor
  } `additionalKeys` [ 
      -- Launching Applications
      ((mod4Mask, xK_w), safeSpawnProg myWebBrowser),
      ((mod4Mask .|. shiftMask, xK_w), safeSpawn myWebBrowser [private]),
      ((mod4Mask, xK_e), safeSpawnProg myEmacs),
      -- Web Search
      ((mod4Mask, xK_g), promptSearch greenXPConfig google),
      --
      -- Screen Lock
      ((mod4Mask .|. shiftMask, xK_z), unsafeSpawn myLockCommand),
      -- Screen Shot
      ((0, xK_Print), unsafeSpawn makeScreenShot),
      -- Volume Control
      ((mod4Mask .|. shiftMask, xK_m), unsafeSpawn myMute),
      ((mod4Mask .|. shiftMask, xK_u), unsafeSpawn myUnmute),
      ((mod4Mask, xK_Up), unsafeSpawn myRaiseVolume),
      ((mod4Mask, xK_Down), unsafeSpawn myLowerVolume),
      -- Background commands
      ((mod4Mask, xK_s), unsafeSpawn resetBackground),
      ((mod4Mask .|. controlMask, xK_x), unsafeSpawn slideShow)
    ]
