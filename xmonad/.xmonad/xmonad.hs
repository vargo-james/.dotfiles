import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Spacing
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Prompt
import XMonad.Actions.Search
import System.IO

myFocusedBorderColor = "#00AA00" -- Green
myNormalBorderColor = "#000000" -- Black

-- Apps
myWebBrowser = "firefox-esr"
private = "-private-window"
myEmacs = "emacs"
-- Screenshot
makeScreenShot = "scrot"
makeWindowScreenShot = "scrot -u"

-- Lock and turn off the screen.
myLockCommand = "xscreensaver-command -lock; xset dpms force off"
-- Volume Commands
setVolume = "amixer set Master "
myMute = setVolume ++ "mute"
myUnmute = setVolume ++ "unmute"
myRaiseVolume = setVolume ++ "10%+"
myLowerVolume = setVolume ++ "10%-"
-- Background
resetBackground = "default-bg"
crazyBackground = "crazy-bg"
backgroundSlideShow = "random-slides ~/.extras/curves"

-- Hooks
myLogHook handle = dynamicLogWithPP xmobarPP {
    ppSep = " | ",
    ppOutput = hPutStrLn handle,
    ppOrder = \(ws:_:t:_) -> [ws,t],
    ppTitle  = 
      xmobarColor myTitleColor "" . shorten myTitleMaxLength
  }
  where myTitleColor = "green"
        myTitleMaxLength = 30

-- Window padding
-- Layout Hook
myLayoutHook = avoidStruts . spacing padding . layoutHook
  where padding = 0


main = do
  xmproc <- spawnPipe "xmobar"

  xmonad $ defaultConfig { 
    -- hooks
    manageHook = manageDocks <+> manageHook defaultConfig,
    layoutHook = myLayoutHook defaultConfig,
    --layoutHook = spacing padding $ (avoidStruts  $ layoutHook defaultConfig),
    logHook = myLogHook xmproc,
    -- Rebind the mod key to the super key
    modMask = mod4Mask,

    -- Basic Configuration
    focusedBorderColor = myFocusedBorderColor,
    normalBorderColor = myNormalBorderColor
    --workspaces = ["shell", "web", "emacs", "empty"]
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
      ((controlMask, xK_Print), unsafeSpawn makeWindowScreenShot),
      -- Volume Control
      ((mod4Mask .|. shiftMask, xK_m), unsafeSpawn myMute),
      ((mod4Mask .|. shiftMask, xK_u), unsafeSpawn myUnmute),
      ((mod4Mask, xK_Up), unsafeSpawn myRaiseVolume),
      ((mod4Mask, xK_Down), unsafeSpawn myLowerVolume),
      -- Background commands
      ((mod4Mask, xK_s), unsafeSpawn resetBackground),
      ((mod4Mask .|. controlMask, xK_s), unsafeSpawn crazyBackground),
      ((mod4Mask .|. controlMask, xK_x), unsafeSpawn backgroundSlideShow)
    ]
