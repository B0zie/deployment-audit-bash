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
         echo "Option unavailable :("
      ;;
      5)
         echo "Option unavailable :("
      ;;
      [Qq])
         exitProgram=true
      ;;
      *)
        echo Some menu options are not available
      ;;
   esac
done
