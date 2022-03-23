function dropColumn {

  read -p "Enter Table Name: " tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    tableOptions $1
  fi
  column -t -s '|' $tableName

  read -p "Enter column name: " colName

  #check if cloumn name exist
  colNum=$(awk -F'|' '{if(NR==1){for(i=1;i<=NF;i++){if($i=="'$colName'") print i}}}' $tableName)
  if [[ $colNum == "" ]]; then

    echo "Column doesn't exist, try again!"
    tableOptions $1
  fi

  #check if column is PK
  metaPK=$(awk -F'|' '{if("'$colName'"==$1) print $3}' .$tableName)
  if [ "$metaPK" == "true" ]; then
    echo "Cannot drop Primary Key!, choose another column"
    tableOptions $1
  fi

  #delete row from metaData file
  awk  '!/'$colName'/' .$tableName > temp && mv temp .$tableName

  #delete column from table
  cut -d"|" -f"$colNum" --complement $tableName >tmp && mv -f tmp $tableName

}
