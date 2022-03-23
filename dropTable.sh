#update
function dropTable {
    #update
  echo -e "Enter Table Name: \c"
  read tableName
  if [[ ! -f $tableName ]] ; 
  then 
  echo -e "\e[1;41m please enter the real table\e[0m";
  echo -e "Enter Table Name: \c"
  read tableName
  fi

  if [[ $? == 0 ]]; then
  
  echo -e "\e[1;41m Confirm?\e[0m"

    select yn in "Yes" "No"; do
      case $REPLY in
       1)
        rm -f $tableName .$tableName
        echo -e "\e[1;46m Table Dropped Successfully\e[0m"
        tableOptions break
        ;;
        2) tableOptions  ;;
      *)
        echo "$REPLY Error Dropping Table, try again $tableName"
        dropTable
        ;;
         esac
    done

  fi
  tableOptions $1
}
