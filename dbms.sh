#!/bin/bash

. ./selectdatabase.sh
. ./createdatabase.sh
. ./dropDatabase.sh
. ./createTable.sh
. ./dropTable.sh
. ./insertTable.sh
. ./updateTAble.sh
. ./dropColumn.sh
. ./deleteRow.sh
. ./selectRow.sh
. ./selectAll.sh

Cyan='\033[1;36m'   # Cyan color code
Blue='\033[1;34m'   # Blue color code
Yellow='\033[1;33m' # Yellow color code
RED='\033[1;31m'    # Red color code
Green='\033[1;32m'  # Green color Green
NC='\033[0m'        # No Color
reset=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
blue=$(tput setb 4)

#######what is shopt and -s and extglob ##searh!!!!!!!!!
shopt -s extglob
export LC_COLLATE=C

mkdir DBMS 2>/dev/null
clear
echo -e "\t \t \e[1;46m ------------- WELCOME TO OUR DBMS ENGINE------------ \e[0m"

function main {
  PS3="Choice: "
  select choice in "Connect To Database" "Create Database" "Drop Database" "List Databases" "Exit"; do
    case $REPLY in
    1) selectDatabase ;;
    2) createDatabase ;;
    3) dropDatabase ;;
    4)
      ls ./DBMS
      main
      ;;
    5) exit ;;
    *)
      echo -e " $REPLY \e[1;41m is not one of the choices \e[0m"
      main
      ;;
    esac
  done
}





function tableOptions {
  PS3="$1 : "

  select choice in "Show All Tables" "Create Table" "Insert Into Table" "Select From Table" "Update Table" "Drop Column" "Delete Row" "Drop Table" "Back To Main Menu" "Exit"; do
    case $REPLY in
    1)
      ls .
      tableOptions $1
      ;;
    2) createTable $1 ;;
    3) insert $1 ;;
    4)
      clear
      selectMenu $1
      ;;
    5) updateTable $1 ;;
    6) dropColumn $1 ;;
    7) deleteRow $1 ;;
    8) dropTable $1 ;;
    9)
      clear
      cd ../.. 2>>./.error.log
      main
      ;;
    10) exit ;;
    *)
      echo "$REPLY Is wrong Choice "
      tableOptions "$1"
      ;;
    esac
  done
}






function selectMenu {
  echo -e "\n\t\t+---------------Select Menu--------------------+"
  PS3="$1: "
  select var in "Select All Columns" "Select Specific Column" "Back To Tables Menu" "Back To Main Menu" "Exit"; do
    case $REPLY in
    1) selectAll $1 ;;
    2) selectColumn $1 ;;
    3)
      clear
      tableOptions $1
      ;;
    4)
      clear
      cd ../..
      main
      ;;
    5) exit ;;
    *)
      echo "$REPLY Is wrong Choice "
      selectMenu $1
      ;;
    esac
  done
}




main
