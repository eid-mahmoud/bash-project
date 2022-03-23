function dropDatabase {
  read -p "Enter Database Name: " database

  if [[ -d ./DBMS/$database ]]; then
    echo -e "\e[1;41m Confirm?\e[0m"

    select yn in "Yes" "No"; do
      case $REPLY in
      1)
        rm -r ./DBMS/$database
        echo -e "\e[1;46m Database Dropped Successfully\e[0m"
        main break
        ;;
      2) main ;;
      *)
        echo "$REPLY Is invalid Choice, try again"
        dropDatabase
        ;;
      esac
    done
  else
    echo -e "\e[1;41m Database Not found\e[0m"
    main
  fi
}