#! /bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ ! $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $1 =~ ^[0-9]+$ ]]
  then
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING (type_id) WHERE (symbol = '$1') OR (name = '$1')")
    
  else
    ELEMENT=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING (type_id) WHERE atomic_number = $1")
    
fi

if [[ -z $ELEMENT ]]
then
  echo "I could not find that element in the database."
else
  echo $ELEMENT | while read NUMBER BAR NAME BAR SYMBOL BAR TYPE BAT ATOMIC_MASS BAR MELTING_POINT BAR BOILING_POINT
  do
  echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  done
fi

fi