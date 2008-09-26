-- import System.Exit
import XMonad
import XMonad.Config (defaultConfig)
import XMonad.Actions.CycleWS
import XMonad.Actions.CopyWindow
import XMonad.Actions.WindowGo
import XMonad.Actions.DwmPromote
import qualified XMonad.Actions.FlexibleResize as Flex
--import XMonad.Layout.Gaps
-- import XMonad.Layout.LayoutCombinators -- hiding ( (|||) )
import XMonad.Layout.Grid
import XMonad.Layout.TwoPane
import XMonad.Layout.ThreeColumns
--import XMonad.Layout.MosaicAlt
import XMonad.Layout.Tabbed
--import XMonad.Layout.Combo
import XMonad.Layout.Maximize
import XMonad.Layout.NoBorders
--import XMonad.Layout.HintedTile
--import XMonad.Layout.WindowArranger
--import XMonad.Layout.ResizableTile
import XMonad.Layout.WindowNavigation
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.SetWMName
import qualified XMonad.StackSet as W
--import qualified Data.Map as M
import XMonad.Prompt
import XMonad.Prompt.Shell
--import XMonad.Prompt.Ssh
import XMonad.Prompt.Man
import XMonad.Prompt.Layout
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.XMonad
import XMonad.Util.EZConfig
import XMonad.Util.Run
--import XMonad.Util.Themes
--import XMonad.Layout.DecorationMadness
--import XMonad.Layout.Decoration
--import XMonad.Layout.LayoutCombinators


main = xmonad $ defaultConfig
       { manageHook = myManageHook <+> manageDocks
       , startupHook = setWMName "LG3D"
       , logHook    = ewmhDesktopsLogHook
       , layoutHook = ewmhDesktopsLayout
                      $ avoidStruts $ smartBorders myLayouts -- $ windowArrangeAll myLayouts
       , modMask    = mod4Mask
       , focusedBorderColor = "#ff0000"
       , borderWidth  =  3
       , terminal  =  "gnome-terminal"
       }
       `additionalKeysP` myKeys
--    `additionalMouseBindings` myMouse

myKeys :: [([Char], X ())]
myKeys =
    [ ("M-<Print>", spawn "scrot -d 2 ~/deskshot-$(date +%y%m%d_%H%M%S).png")
    --       , ("M-F1", sendMessage $ JumpToLayout "Tall")
    --       , ("M-F2", sendMessage $ JumpToLayout "Full")
--    , ("M-i", runInTerm "screen -D -R irc irssi")
    , ("M-<Return>", dwmpromote)
    , ("M-<F6>", shellPrompt defaultXPConfig)
    , ("M-<F1>", manPrompt defaultXPConfig)
    --       , ("M-<F7>", sshPrompt defaultXPConfig)
    , ("M-S-m" , workspacePrompt defaultXPConfig (windows . W.shift))
    , ("M-S-g", windowPromptGoto  defaultXPConfig)
    , ("M-S-b", windowPromptBring defaultXPConfig)
    , ("M-C-x", xmonadPrompt defaultXPConfig)
    --       , ((modMask x .|. shiftMask, xK_m     ), layoutPrompt defaultXPConfig)
    , ("M-b", sendMessage ToggleStruts)
    , ("M-z", toggleWS)
    --     , ("M-w", sendMessage MirrorExpand)
    --     , ("M-s", sendMessage MirrorShrink)
    , ("M-a", withFocused (sendMessage . maximizeRestore))
    --       , ("M-<Right>", nextWS)
    --       , ("M-<Left>", prevWS)
    , ("M-S-<Right>", shiftToNext)
    , ("M-S-<Left>", shiftToPrev)
    , ("M-<Up>", nextScreen)
    , ("M-<Down>",  prevScreen)
    , ("M-S-<Up>", nextScreen)
    , ("M-S-<Down>",  prevScreen)
       -- For WindowManager
       -- , ("M-C-s", sendMessage  Arrange)
       -- , ("M-C-S-s", sendMessage  DeArrange       )
       -- , ("M-C-<Left>", sendMessage (MoveLeft      1))
       -- , ("M-C-<Right>", sendMessage (MoveRight     1))
       -- , ("M-C-<Down>", sendMessage (MoveDown      1))
       -- , ("M-C-<Up>", sendMessage (MoveUp        1))
       -- , ("M-S-<Left>", sendMessage (IncreaseLeft  1))
       -- , ("M-S-<Right>", sendMessage (IncreaseRight 1))
       -- , ("M-S-<Down>", sendMessage (IncreaseDown  1))
       -- , ("M-S-<Up>", sendMessage (IncreaseUp    1))
       -- , ("M-C-S-<Left>", sendMessage (DecreaseLeft  1))
       -- , ("M-C-S-<Right>", sendMessage (DecreaseRight 1))
       -- , ("M-C-S-<Down>", sendMessage (DecreaseDown  1))
       -- , ("M-C-S-<Up>", sendMessage (DecreaseUp    1))
       -- For WindowNavigation
    , ("M-<Right>", sendMessage $ Go R)
    , ("M-<Left>", sendMessage $ Go L)
    , ("M-<Up>", sendMessage $ Go U)
    , ("M-<Down>", sendMessage $ Go D)
    , ("M-C-<Right>", sendMessage $ Swap R)
    , ("M-C-<Left>", sendMessage $ Swap L)
    , ("M-C-<Up>", sendMessage $ Swap U)
    , ("M-C-<Down>", sendMessage $ Swap D)
    -- For Xmonad.Actions.WindowGo
    , ("<F6>", runOrRaise "emacs-snapshot-gtk" (className =? "Emacs"))
    , ("<F5>", runOrRaise "firefox" (className =? "Firefox"))
--    , ("M-S-i" raiseMaybe (runInTerm "-title irssi" "irssi") (title =? "irssi"))
    ]
    ++
    [("M" ++ m ++ ('-':k:[]) , windows $ f i)
     | (i, k) <- zip myWorkspaces ['1'..'9']
    , (f, m) <- [(W.view, ""), (W.shift, "-S"), (copy, "-C-S")]]

myMouse :: [((ButtonMask, Button), Window -> X ())]
myMouse =
     [ ((mod1Mask, button3), (\w -> focus w >> Flex.mouseResizeWindow w
                              >> windows W.swapMaster))
     , ((mod1Mask, button1), (\w -> focus w >> mouseMoveWindow w
                              >> windows W.swapMaster))]

myManageHook :: ManageHook
myManageHook = composeAll
               [  className =? "Firefox-bin" --> doF (W.shift "web" )
               , className =? "Mplayer" -->  doFloat
               , className =? "Gcalctool" --> doFloat
               , className =? "Pidgin"  --> doFloat
               , className =? "Do" --> doFloat ]

myWorkspaces = map (:[]) ['1' .. '3']

myLayouts =
    windowNavigation (maximize
                      ( Tall 1 (3/100) (9/16)
--                        ||| mirrorTall
--                        ||| ResizableTall 1 (3/100) (1/2) []
                        ||| TwoPane (3/100) (1/2)
                        ||| ThreeCol 1 (3/100) (1/2)
                        ||| Grid
                        ||| simpleTabbed
                        ||| noBorders Full))

--myLayouts =  ||| Full
