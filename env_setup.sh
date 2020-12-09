set -e

function create_react() {
    npx create-react-app $1 --template typescript
    npm i bootstrap axios
    npm start
}

function create_django() {
    django-admin startproject $1
}
function create_app() {
    django-admin startapp $1
}
function install_dependencies() {
    if !python -c 'import django; exit(not pkgutil.find_loader("django"))'; then
        pip install djangorestframework django-cors-headers django
    fi
    pip install djangorestframework django-cors-headers
}

function create_env() {
    read -p "project name: " project_name.
    read -p "react_app name: " react_name.
    read -p "django_project name: " django_name.
    read -p "django_app name: " django_app.
    mkdir $project_name
    cd $project_name && mkdir front-end back-end
    current_project="$(pwd)"
    cd front-end && create_react $react_name
    cd $current_project
    cd back-end && install_dependencies && create_django "$django_name" && create_app "$django_app"
}

create_env
