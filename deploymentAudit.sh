#!/bin/bash
#Auther:Robert Fisher
exitProgram=false



#Task 1
#Note there is some extra logic because i wanted to upload to git
#and i had to find a way to ignore the repo files
function fileTypeCount() {
  countArr=()
  typeArr=()
  fList=""
   for d in ./* ; do
      dirName=${d##*\.}
      if [[ $d != ".git" && -d $d ]] ; then
          for f in $(find $d/* -type f); do
             fileType=${f##*\.}
             typeArr+=(".$fileType")
          done
      fi
    done
    

    for ((i=0; i < ${#typeArr[*]}; i++)); do
       lastIt=(${#typeArr[*]}-1)
       if [[ $i -eq $lastIt ]]; then
          fList+="${typeArr[i]}"
       else
          fList+="${typeArr[i]}\n"
       fi
    done
    echo "=====File Audit====="
    echo -e $fList|sort|uniq -c|sort -n 
       
}

#Task2
function fileScan() {
warnList=()
   for d in ./* ; do
        dirName=${d##*\.}
        dirName=${dirName#/}
        #if the dir is not git we do find 
        if [[ $d != ".git" && -d $d ]] ; then
            for f in $(find $d/* -type f); do
                fileName=${f##*/}
               if [[ $(echo $f | grep 'debug') ]];then
                 warnList+=("$dirName/$fileName")
               elif [[ $(echo $f | grep '\.bak') || $(echo $f | grep '\.old') || $(echo $f | grep '\.tmp') ]];then
                 warnList+=("$dirName/$fileName")
               fi
            done
        fi
   done
   echo "==Suspicious Files======"
   echo ${warnList[*]}|tr " " "\n"|awk '{print "WARNING: suspicious file detected - " $0}'

}

#task3
function cmdScan() {

 output=""
   for d in ./* ; do
        dirName=${d##*\.}
        #if the dir is not git we do find
        if [[ $d != ".git" && -d $d ]] ; then
            for f in $(find $d/* -type f); do
                fileName=${f##*/}
                if [[ $(echo $f | grep '.sh') ]]; then
                  if [[ $(cat $f| grep 'rm -rf') ]]; then
                    output+="$fileName: uses dangerous command rm -rf\n"
                  fi 
                  if [[ $(cat $f| grep 'scp') ]]; then
                    output+="$fileName: uses dangerous command scp\n"
                  fi
                  if [[ $(cat $f| grep 'curl') ]]; then
                    output+="$fileName: uses dangerous command curl\n"
                  fi
                  if [[ $(cat $f| grep 'sudo') ]]; then
                    output+="$fileName: uses dangerous command sudo\n"
                  fi 
                fi
            done
        fi
   done
  echo -e $output
}

#task4
function logScan() {
   output=""
   for f in $(find ./logs -type f);do
      fileName=${f##*/}
      if [[ $fileName == "access.log" ]]; then
         output+="\nUnique I.P. connections = "
         output+="$(cat $f |grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'| sort | uniq | wc -l)\n"
         output+="==Top Site Visits==\n"
         output+="$(cat $f | grep -Eo '/[a-zA-Z0-9_]*\.html'|sort|uniq -c| sort -nr | head -n 3)\n"
      elif [[ $fileName == "error.log" ]]; then
         output+="==File does not exist==\n"
         output+="$(cat $f | grep  'File does not exist')\n"
      fi
   done
   
   echo -e "$output"
}

#task5
function configScan() {
   output="====Potentail Secrets in Files=====\n"
   for d in ./* ; do
        dirName=${d##*\.}
        #if the dir is not git we do find
        if [[ $d != ".git" && -d $d ]] ; then
            for f in $(find $d/* -type f); do
                fileName=${f##*/}
                fileType=${f##*\.}
                if [[ $fileType == "env" || $fileType == "conf" || $fileType == "json" || $fileType == "pem" ]]; then
                   
                   secret=$(cat $f | grep -E '[Ss][Ee][Cc][Rr][Ee][Tt]')
                   password=$(cat $f | grep -E '[Pp][Aa][Ss]{2}[Ww][Oo][Rr][Dd]')
                   private=$(cat $f | grep -E '[Pp][Rr][Ii][Vv][Aa][Tt][Ee]')

                   if [[ $secret || $password || $private ]];then
                      output+="\n$fileName\n"
                      if [[ $secret ]];then
                         output+="$secret\n"
                      fi
                      if [[ $password ]];then
                         output+="$password\n"
                      fi
                      if [[ $private ]];then
                         output+="$private\n" 
                      fi
                   fi
                fi
            done
            
        fi
   done
   echo -e "$output"
}

#Main Program LOOP
until [[ $exitProgram == true ]]; do
   #MENU
   echo "MENU"
   echo "======"
   echo "1) Audit file types"
   echo "2) Scan for Suspicious Files"
   echo "3) Scan for Dangerous commands "
   echo "4) Scan for traffic/error patterns "
   echo "5) Scan for secrets "
   echo "Q) Hit Q to Quit "
   read -p "Choose: " choice

   case $choice in
      1)
         (fileTypeCount)> task1Output.txt && cat task1Output.txt
      ;;
      2) 
         
         (fileScan)> task2Output.txt && cat task2Output.txt
      ;;
      3)
         (cmdScan)> task3Output.txt && cat task3Output.txt
      ;;
      4)
         (logScan)> task4Output.txt && cat task4Output.txt
      ;;
      5)
         (configScan)> task5Output.txt && cat task5Output.txt
      ;;
      [Qq])
         exitProgram=true
      ;;
      *)
        echo :::Improper Input:::
      ;;
   esac
done
