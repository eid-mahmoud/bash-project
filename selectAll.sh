function selectAll {
  PS="$1: "
  read -p "Enter Table Name: " tableName
  if ! [[ -f $tableName ]]; then
    echo "Table $tableName isn't exist, choose another Table"
    tableOptions $1
  fi

  column -t -s "|" $tableName
  selectMenu $tableName

}
