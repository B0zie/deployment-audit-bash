#!/bin/bash
#Auther:Robert Fisher


#Task 1
function fileTypeCount() {
   declare -a count
   #Needs to not search through .git
   #needs to not include my script in the sum
   for f in $(find . -type f); do
     #fileType=${f##*\.}
     #echo $fileType
     echo $f   
   done

 
}


#MENU
echo "MENU"
echo "======"
echo "1) Count file types"
echo "2)"
echo "3)"
read -p "Choose: " choice

case $choice in
  1)
      fileTypeCount
  ;;
  *)
   echo Some menu options are not available
  ;;
esac

