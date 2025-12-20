# Trash bin for temporarily storing deleted items

function srm () {

        if [ -z "$1" ] && [ -z "$2" ]; then
                echo "Error: Usage is: tr <item_1> <item_2>"
                return 1
        fi

        echo "Moving $1 to trash..."
        mv "$1" ~/.trash/

        if [ -n "$2" ]; then
                echo "Moving $2 to trash..."
                mv "$2" ~/.trash/
        fi
}

# Function to clear .trash

function ctrash () {

        echo "Do you really wish to clear trash? [y/N]: "
        read choice

        if [[ "$choice" == "y" ]] || [[ "$choice" == "Y" ]]; then

                rm -rf ~/.trash/*

                echo "Trash has been cleared..."
                return 0

        elif [[ "$choice" == "N" ]] || [[ "$choice" == "n" ]]; then
                echo "Trash files not removed... exiting..."
                return 1

        else
                echo "Invalid option... exiting..."
                return 1
        fi
}

function btrash () {

        echo "Do you really wish to burn trash? [y/N]: "
        read choice

        if [[ "$choice" == "y" ]] || [[ "$choice" == "Y" ]]; then

                shopt -s dotglob
                rm -rf ~/.trash/*
                shopt -u dotglob

                echo "Trash has been burned..."
                return 0

        elif [[ "$choice" == "N" ]] || [[ "$choice" == "n" ]]; then
                echo "Trash files not removed... exiting..."
                return 1

        else
                echo "Invalid option... exiting..."
                return 1
        fi
}
