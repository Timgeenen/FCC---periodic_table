PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else

  if [[ $1 =~ ^[0-9]+$ ]]
  then
    REL=$($PSQL "SELECT * FROM elements WHERE atomic_number = '$1'");
    read X BAR SYMBOL BAR NAME <<< $REL
    DATA=$($PSQL "SELECT * FROM properties WHERE atomic_number = $1");
    read ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID <<< $DATA
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID");

  elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
  then
    REL=$($PSQL "SELECT * FROM elements WHERE symbol = '$1'");
    read X BAR SYMBOL BAR NAME <<< $REL
    DATA=$($PSQL "SELECT * FROM properties WHERE atomic_number = $X");
    read ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID<<< $DATA
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID");

  else
    REL=$($PSQL "SELECT * FROM elements WHERE name = '$1'");
    read X BAR SYMBOL BAR NAME <<< $REL
    DATA=$($PSQL "SELECT * FROM properties WHERE atomic_number = $X");
    read ATOMIC_NUMBER BAR ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT BAR TYPE_ID<<< $DATA
    TYPE=$($PSQL "SELECT type FROM types WHERE type_id = $TYPE_ID");

  fi
  if [[ -z $DATA ]]
  then
    echo I could not find that element in the database.
  else
    echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius.
  fi
fi