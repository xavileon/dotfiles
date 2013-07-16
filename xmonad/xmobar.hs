Config {
    font = "xft:Ubuntu-M:size=9:antialias=true",
    commands = [Run Cpu ["-L","3","-H","50","--normal","green","--high","red"] 9, 
                Run Memory ["-t","Mem: <usedratio>%"] 9,
                Run Swap [] 9,
                Run Network "wlan0" ["-L","0","-H","32","--normal","green","--high","red"] 9,
                Run Com "uname" ["-s","-r"] "" 36000,
                Run StdinReader
                ],
    sepChar = "%",
    alignSep = "}{",
    template = " %StdinReader% }{ %cpu% %memory% %swap% | %wlan0% | %uname%"
}
