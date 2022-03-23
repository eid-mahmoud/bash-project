function selectColumn {
  PS="[$1: ] "
  read -p "Enter Table Name: " tableName
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    selectMenu $1
  fi
  echo -e "\t >> Table's meta data << \n \t \c"
  column -t -s '|' $tableName | sed -n '1p'

  read -p "Enter Column Number: " colNum

  until [[ $colNum =~ ^[0-9]*$ ]]; do
    echo "Enter Number Only..!"
    read -p "Enter Column Number: " colNum
  done
  awk 'BEGIN{FS="|"}{print $'$colNum'}' $tableName
  selectMenu $tableName
}

