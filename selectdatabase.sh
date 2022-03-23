function selectDatabase {

  read -p "Enter Database Name: " database

  if [[ -d ./DBMS/$database ]]; then
    cd ./DBMS/$database
    echo -e "\e[1;46m Database $database has been selected \e[0m"
    tableOptions $database
  else
    echo -e "\e[1;41m Database $database not exist \e[0m"
    main
  fi
}