import XMonad
import XMonad.Config.Xfce
import XMonad.Hooks.DebugKeyEvents
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Spacing
import XMonad.Layout.Tabbed
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- define workspace names
myWorkspaces = [ "term", "web", "folders", "social", "media", "games", "vms" ] ++ map show [8..9]

-- Width of the window border in pixels.
myBorderWidth = 1

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window.

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Iceweasel" --> doShift "web",
      (className =? "Iceweasel" <&&> resource =? "Dialog") --> doFloat,  -- Float Firefox dialogs
      className =? "Firefox" --> doShift "web",
      (className =? "Firefox" <&&> resource =? "Dialog") --> doFloat,  -- Float Firefox dialogs
      className =? "Google-chrome" --> doShift "web",
      (className =? "Google-chrome" <&&> resource =? "Dialog") --> doFloat,  -- Float Firefox dialogs
      className =? "Skype" --> doShift "social",
      className =? "Xchat" --> doShift "social",
      className =? "Spotify" --> doShift "media",
      className =? "Thunar" --> doShift "folders",
      className =? "VirtualBox" --> doShift "vms" ]

------------------------------------------------------------------------

-- Color of current window title in xmobar.
xmobarTitleColor = "#FFB6B0"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#CEFFAC"


-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig = defaultTheme {
    activeBorderColor = "#040404",
    activeTextColor = "#CEFFAC",
    activeColor = "#000000",
    inactiveBorderColor = "#7C7C7C",
    inactiveTextColor = "#EEEEEE",
    inactiveColor = "#000000"
}

myLayout = ( (spacing 3 $ Tall 1 (3/100) (1/2)) ||| 
             (spacing 3 $ Mirror (Tall 1 (3/100) (1/2))) |||
             tabbed shrinkText tabConfig
           )


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
main = do
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    xmonad defaultConfig {
        -- basic stuff
        borderWidth = myBorderWidth,
        focusedBorderColor = "gray",
        normalBorderColor = "black",
        focusFollowsMouse  = myFocusFollowsMouse,
        workspaces = myWorkspaces,

        -- hooks, layouts
        manageHook = manageDocks <+> myManageHook,
        handleEventHook = debugKeyEvents <+> docksEventHook,
        layoutHook = avoidStruts $ myLayout,
        logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc,
              ppTitle = xmobarColor "green" "" . shorten 50,
              ppLayout = const "" 
            }
    }
