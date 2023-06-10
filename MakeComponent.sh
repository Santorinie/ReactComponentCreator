echo "--------------- Welcome to React TypeScript Component Creator v1.0 by benikee. ---------------\n\n"

SCRIPT_DIR="/usr/local/lib"
BASE_SOURCE_NAME="ComponentBase.txt"
COMPONENTS_FOLDER_BASE="$(pwd)"
COMPONENT_EXISTS=true

function getStringVariant() {
    local string="$1"
    local isToUpper="$2"

    if [ $isToUpper = true ]; then
        first_letter=$(echo "${componentName:0:1}" | tr  '[:lower:]' '[:upper:]')
        rest_of_string="${componentName:1}"
        echo "$first_letter$rest_of_string\c"
    else
        first_letter=$(echo "${componentName:0:1}" | tr  '[:upper:]' '[:lower:]')
        rest_of_string="${componentName:1}"
        echo "$first_letter$rest_of_string\c"
    fi
}

read -p "Would you like to use the default components folder: ($COMPONENTS_FOLDER_BASE/src/components)? (y/n): " folder_ans

if ! [ "$folder_ans" = "" -o "$folder_ans" = "y" ]; then
    read -p "Please enter a project path where you want the Wizard to put your new component!: " COMPONENTS_FOLDER_BASE
fi

cd "$COMPONENTS_FOLDER_BASE"

if ! [ -d "./src/components" ]; then
    read -p "The /src/components folder doesn't exists inside your project folder. Do you want me to create one for you? (y/n): " CREATE_ANS

    if [ "$CREATE_ANS" = "" -o "$CREATE_ANS" = "y" ]; then
        mkdir -p src/components
        cd ./src/components
    else
        echo "I can't cope with your shit bro."
        exit
    fi
else
    cd ./src/components
fi

while [ "$COMPONENT_EXISTS" = true ]
do

read -p "Please enter the name of the new component: " componentName

if [ "$componentName" = "" ]; then
    echo "Press ctrl+c to exit the script."
    continue
fi

componentNameCapital=$(getStringVariant $componentName true)

if [ -d "$componentNameCapital" ]; then
    echo "Error: The component already exitst!"
else
    COMPONENT_EXISTS=false
fi

done

componentNameLower=$(getStringVariant $componentName false)

mkdir "$componentNameCapital"
cd "$componentNameCapital"
cp $SCRIPT_DIR/$BASE_SOURCE_NAME .
touch "$componentNameLower".module.css

sed -i -E "s/base/$componentNameLower/" ComponentBase.txt
sed -i -E "s/Base/$componentNameCapital/" ComponentBase.txt
mv ComponentBase.txt "$componentNameCapital".tsx
rm -rf ComponentBase.txt-E

echo "Component created successfully!"