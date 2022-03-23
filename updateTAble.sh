#we need to check if the column was PK, then cannot accept null value

function updateTable {
  read -p "Enter Table Name: " tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    #upadate
     read -p "Enter Table Name: " tableName
    #tableOptions $1
  fi

  column -t -s "|" $tableName

  read -p "Enter Column name: " colName
while : ; do
  #take tne column number
  #colNum=$(awk -F'|' '{if(NR==1){for(i=1;i<=NF;i++){if("$i"=="'$colName'") print i}}}' $tableName)
  colNum=$(awk -F'|' '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' $tableName)
  if [[ -z $colNum ]] ; then
  #update
  
    echo "Not Found"
    read -p "Enter Column name: " colName
  else
  break;
    #tableOptions $1
  fi
done

read -p "Enter old value to replace: " oldVal
#if [[ $oldVal == "" ]]
  #echo "please set true value"
    #read -p "Enter old value to replace: " oldVal
#fi
  #check if the value entered by user is exist

  #checkVal=$(awk -F '|' '{if ("$'$colNum'"=="'$oldVal'") print $'$colNum'}' $tableName)
   checkVal=$(awk -F'|' '{if($'$colNum'=="'$oldVal'") print $'$colNum'}' $tableName)

  if [[ $checkVal == "" ]]; then
    echo "Value Not Found"
    column -t -s "|" $tableName
    #read -p "Enter old value to replace: " oldVal
      #column -t -s "|" $tableName
  fi
  read -p "Enter number of target row: " rowNum
   tableRows=$(awk 'END{print NR}' $tableName)
 
 while : ; do

  if [[ $rowNum -gt $tableRows ]] || [[ $rowNum -lt 2 ]] ; then
    echo "Out of Scope, choose again: "
    read -p "Enter number of target row: " rowNum
  else
  break;
  fi
  done

  read -p "Enter new value to set: " newVal

  #check if the colType matching the newVal Type
  colType=$(awk -F'|' '/'$colName'/ {print $2}' .$tableName)

  if [[ $colType == "int" ]]; then
    until [[ $newVal =~ ^[0-9]*$ ]]; do
      echo -e "Must be integer!!"
      read -p "Enter new value to set: " newVal
    done
  fi


  if [[ $colType == "str" ]]; then
    until [[ "$newVal" =~ ^[a-zA-Z]{1,10}$ ]]; do
      echo -e "Must be string, from 1-10 character!!"
      read -p "Enter new value to set: " newVal
    done
  fi

  awk  -F '|' -v v1="$oldVal" -v v2="$newVal" '{if(NR=="'$rowNum'"){sub(v1,v2);} print}' $tableName > temp && mv temp $tableName
  echo "Row Updated Successfully"
  tableOptions $1

}
