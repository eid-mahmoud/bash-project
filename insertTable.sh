
function insert {
  read -p "Table Name: " tableName

  if ! [[ -f $tableName ]]; then
    echo "Table $tableName doesn't exist ,choose another Table"
    #update
    read -p "Table Name: " tableName
    #tableOptions $1
  fi

  #showing meta data(first line) of table to user
  echo -e "\t >> Table's meta data << \n \t \c"
  column -t -s '|' $tableName | sed -n '1p'

  echo -e "\n"

  colsNum=$(awk 'END{print NR}' .$tableName)
  sep="|"
  newLine="\n"

  for ((i = 2; i <= $colsNum; i++)); do
    colName=$(awk 'BEGIN{FS="|"}{ if(NR=='$i') print $1}' .$tableName)
    colType=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $2}' .$tableName)
    colKey=$(awk 'BEGIN{FS="|"}{if(NR=='$i') print $3}' .$tableName)
    read -p "$colName [$colType] = " data

    # Validate Input
    if [[ $colType == "int" ]]; then
      until [[ $data =~ ^[0-9]*$ ]]; do
        echo -e "Must be integer!"
        read -p "$colName [$colType] = " data
      done
    fi

    if [[ $colType == "str" ]]; then
      until [[ $data =~ ^[a-zA-Z]{1,10}$ ]]; do
        echo -e "Must be string, from 1-10 character!"
        read -p "$colName [$colType] = " data
      done
    fi

    if [[ $colKey == "true" ]]; then
      while [[ true ]]; do
        if [[ $data =~ ^[$(awk -F'|' 'BEGIN{ORS=" "}{if(NR != 1)print $(('$i'-1))}' $tableName)]$ ]]; then
          echo -e "PK values cannot be duplicated!"
        else
          break
        fi
        echo -e "$colName [$colType] = \c"
        read data
      done
    fi

    #Set row
    if [[ $i == $colsNum ]]; then
      row=$row$data$newLine
    else
      row=$row$data$sep
    fi
  done
  #don't add newLine by default, cause this will make empty lines when insert again
  echo -e $row"\c" >>$tableName
  if [[ $? == 0 ]]; then
    echo "Data Inserted Successfully"
  else
    echo "Error Inserting Data into Table $tableName"
  fi
  row=""
  tableOptions $1
}
