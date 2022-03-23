
function selectRow {

  PS3="[$1: ] "
  read -p "Enter Table Name: " tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    tableOptions $1
  fi

  column -t -s '|' $tableName

  read -p "Enter column name: " colName
  colNum=$(awk -F'|' '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'")print i}}}' $tableName)

  if [[ $colNum == "" ]]; then
    echo "Value doesn't exist, try again"
    selectMenu $1
  fi

  read -p "Enter value in a row you want to select: " value

  #print the row of this occurrence
  rowNum=$(awk '/'$value'/ {print $0}' $tableName)

}