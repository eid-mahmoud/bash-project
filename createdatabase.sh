function createDatabase {

  read -p "Enter Database Name: " database

  if [[ -d ./DBMS/$database ]]; then
    echo -e "\e[1;41m Database $database already exist \e[0m"
    main
  elif [[ $database =~ ^[a-zA-Z]{1,10}$ ]]; then
    mkdir ./DBMS/$database
    echo -e "\e[1;46m Database Created Successfully \e[0m"
    main
  else
    echo -e "\e[1;41m $database must start with char, min = 1 char & max = 10 character\e[0m"
    main
  fi

}