function createTable {

  PS3="$1: "

  read -p "Table Name: " tableName

  if [[ -f $tableName ]]; then
    echo -e "$tableName already exist \n Try Again"
    createTable $1
  elif ! [[ $tableName =~ ^[a-zA-Z]{1,10}$ ]]; then
    echo -e "$tableName must start with char, min = 1 char & max = 10 char \n Try Again"
    createTable $1
  fi

  read -p "Number of columns: " colsNum

  if [[ colsNum -lt 1 ]]; then
    echo "Table must have columns!"
    select var in "Create again" "Go to table menu"; do
      case $REPLY in
      1) createTable $1 ;;
      *) tableOptions $1 ;;
      esac
    done
  fi

  counter=1
  sep="|"
  newLine="\n"
  PK="false"
  metaData="Name"$sep"Type"$sep"key"
  colNames=()

  while [[ $counter -le $colsNum ]]; do

    read -p "Name of column [$counter]: " colName

    #Prevent the user from entering a duplicate column name
    while [[ " ${colNames[*]} " =~ " ${colName} " ]]; do
      echo -e "Column's name cannot be duplicated, choose another name \n"

      read -p "Name of column [$counter]: " colName
    done

    #adding column name each iteration to the array
    colNames+=($colName)

    echo -e "Type of Column $colName: "

    select var in "int" "str"; do
      case $var in
      int)
        colType="int"
        break
        ;;
      str)
        colType="str"
        break
        ;;
      *) echo "$REPLY Is a wrong Choice" ;;
      esac
    done

    if [[ $PK == "false" ]]; then
      echo "Make it PK? "
      select var in "yes" "no"; do
        case $REPLY in
        1)
          PK="true"
          metaData+=$newLine$colName$sep$colType$sep$PK
          break
          ;;
        2)
          PK="false"
          metaData+=$newLine$colName$sep$colType$sep$PK
          break
          ;;
        *)
          echo "$REPLY Is wrong Choice"
          createTable $1
          ;;
        esac
      done
    else
      metaData+=$newLine$colName$sep$colType$sep$"false"
    fi

    if [[ $counter == $colsNum ]]; then
      temp=$temp$colName
    else
      temp=$temp$colName$sep
    fi
    ((counter++))
  done
  #
  colNames=()

  touch .$tableName
  echo -e $metaData >>.$tableName
  touch $tableName
  echo -e $temp >>$tableName

  if [[ $? == 0 ]]; then
    echo "Table Created Successfully"
    tableOptions $1
  else
    echo "Error Creating Table $tableName"
    tableOptions $1
  fi
}

function dropTable {
  echo -e "Enter Table Name: \c"
  read tableName
  rm -f $tableName .$tableName
  if [[ $? == 0 ]]; then
    echo "Table Dropped Successfully"
  else
    echo "Error Dropping Table $tableName"
  fi
  tableOptions $1
}