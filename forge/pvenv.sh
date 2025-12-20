# Function to activate/deactivate Python virtual environment

function pvenv () {
        if [ -z "$1" ] && [ -z "$2" ]; then
                echo "Error: Usage is: pvenv <activation_or_deactivation_flag> <venv_name>"
                return 1
        fi

        if [[ "$1" == "-a" ]]; then
                source "$2"/bin/activate
                return 0
        elif [[ "$1" == "-d" ]]; then
                deactivate
                return 0
        elif [[ "$1" == "-c" ]]; then
                python3 -m venv "$2"
                echo "Created vitual environment..."
                return 0
	elif [[ "$1" == "-D" ]]; then
                if [ -z "$VIRTUAL_ENV" ]; then
                        echo "Do you really wish to delete the virtual environment? [y/N]: "
                        read choice

                        if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
                                rm -rf "$2"
                                echo "Virtual environment deleted..."
                                return 0
                        else
                                echo "Virtual environment retained..."
                        fi
                else
                        echo "Virtual environment still activated... deactivate it first..."
                fi
        fi
}

