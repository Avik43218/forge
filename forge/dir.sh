# Function to create a directory and move to it

function dir () {
        if [ -d "$1" ]; then
                echo "Directory already exists... moving to it..."
                cd "$1"
                return 0

        else
                echo "Creating directory $1 and moving to it..."
                mkdir "$1" && cd "$1"
                return 0
        fi
}

