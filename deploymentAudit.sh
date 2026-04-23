#!/bin/bash
#Auther:Robert Fisher



#Task 1
function countDepDir() {
   oldCount=0
   htmlCount=0
   phpCount=0
   envCount=0
   jsonCount=0
   confCount=0
   pemCount=0
   logCount=0
   shCount=0
   jsCount=0
   mdCount=0
   cssCount=0
   bakCount=0
   tmpCount=0
   
   #each dir
for f in $(find . -type f); do
   case $f
      ".old")
           ;;
      ".html")
            ;;
      ".php")
           ;;
      ".env")
           ;;
      ".json")
            ;;
       ".conf")
            ;;
       ".pem")
           ;;
       ".log")
           ;;
       ".sh")
            ;;
        ".js")
           ;; 
       ".md")
           ;;
       ".css")
           ;; 
       ".bak")
          ;;
       ".tmp")
         ;;
           *)
         ;;
   esac

done

 
}

countDepDir
