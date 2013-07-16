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
myWorkspaces = [ "dev", "web", "social", "media", "games" ] ++ map show [6..9]

-- Width of the window border in pixels.
myBorderWidth = 1

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window.

myManageHook :: ManageHook
myManageHook = composeAll
    [ className =? "Iceweasel" --> doShift "web",
      className =? "Pidgin" --> doShift "social" ]

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

myLayout = ( (spacing 1 $ Tall 1 (3/100) (1/2)) ||| 
             (spacing 1 $ Mirror (Tall 1 (3/100) (1/2))) |||
             tabbed shrinkText tabConfig
           )


-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
main = do
    spawn "nitrogen --restore"
    spawn "cb-compositor --start"
    xmproc <- spawnPipe "xmobar ~/.xmonad/xmobar.hs"
    tint2 <- spawnPipe "tint2"
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
