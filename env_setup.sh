set -e

create_react() {
    npm i bootstrap axios typescript
    npx create-react-app . --template typescript
    npm start
}

create_django_project() {
    django-admin startproject .
}
create_django_app() {
    django-admin startapp $1
}
install_dependencies() {
    if !python -c 'import django; exit(not pkgutil.find_loader("django"))'; then
        pip install djangorestframework django-cors-headers django
    fi
    pip install djangorestframework django-cors-headers
}

create_env() {
    current_project="$(pwd)"
    read -p "project name: " project_name
    read -p "django_app name: " django_app
    if [ ! -e $current_project/$project_name ]; then
        mkdir $project_name
    fi
    cd $project_name && mkdir frontend backend
    cd frontend && create_react
    cd $current_project
    cd backend && install_dependencies && create_django_project && create_django_app
}
create_env
