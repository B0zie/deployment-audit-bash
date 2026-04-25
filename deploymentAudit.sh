#!/bin/bash
#Auther:Robert Fisher


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


#MENU
echo "MENU"
echo "======"
echo "1)Audit file types"
echo "2)"
echo "3)"
read -p "Choose: " choice

case $choice in
  1)
      fileTypeCount
      (fileTypeCount)> task1Output.txt
  ;;
  *)
   echo Some menu options are not available
  ;;
esac

