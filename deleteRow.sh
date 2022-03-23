#this function has issues


function deleteRow {

  PS3="[$1: ] "
  read -p "Enter Table Name: " tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    tableOptions $1
  fi
  column -t -s '|' $tableName

  read -p "Enter value where you want to delete the row at: " value

  #print row number of this occurrence
  rowNum=$(awk '/'$value'/ {print NR}' $tableName)
  if [[ $rowNum == "" ]]; then
    echo "Value doesn't exist, try again"
    tableOptions $1

  fi
  #print every row except with the matching pattern
  awk  '!/'$value'/' $tableName >  temp && mv temp $tableName
    if [[ $? == 0 ]]; then
    echo "Row deleted successfully"
  fi

}