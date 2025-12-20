# Function for compiling different programs

function compile () {

        src_file="$1"

        if [ "${src_file##*.}" == "c" ]; then
                if [ -z "$1" ] && [ -z "$2" ]; then
                        echo "Error; Usage is: compile <source_file_name>.c <optional_output_executable>"
                        return 1
                elif [ -z "$2" ]; then
                        echo "Compiling $1 into executable ${src_file%.*}..."
                        gcc "$1" -o "${src_file%.*}"

                        return 0
                fi

                echo "Compiling $1 into executable $2..."
                gcc "$1" -o "$2"

                return 0

	elif [ "${src_file##*.}" == "cpp" ]; then
                if [ -z "$1" ] && [ -z "$2" ]; then
                        echo "Error; Usage is: compile <source_file_name>.cpp <optional_output_executable>"
                        return 1
                elif [ -z "$2" ]; then
                        echo "Compiling $1 into executable ${src_file%.*}..."
                        g++ "$1" -o "${src_file%.*}"
                        return 0
                fi

                echo "Compiling $1 into executable $2..."
                g++ "$1" -o "$2"

                return 0

        elif [ "${src_file##*.}" == "rs" ]; then
                if [ -z "$1" ]; then
                        echo "Error: Usage is: compile <source_file_name>.rs"
                        return 1
                fi

                echo "Compiling $1 into executable ${src_file%.*}..."
                rustc "$1"

                return 0
	elif [ "${src_file##*.}" == "java" ]; then
                if [ -z "$1" ]; then
                        echo "Error: Usage is: compile <source_file_name>.java"
                        return 1
                fi

                echo "Compiling $1 into executable ${src_file%.*}..."
                javac "$1"

                return 0

        fi
}

# Function for compiling and executing different programs

function rcompile () {

        src_file="$1"

        if [ "${src_file##*.}" == "c" ]; then
                if [ -z "$1" ] && [ -z "$2" ]; then
                        echo "Error; Usage is: compile <source_file_name>.c <optional_output_executable>"
                        return 1
                elif [ -z "$2" ]; then
                        echo "Compiling $1 into executable ${src_file%.*}..."
                        gcc "$1" -o "${src_file%.*}"
                        echo -e "Running application...\n"
                        "./${src_file%.*}"

                        return 0
                fi

                echo "Compiling $1 into executable $2..."
                gcc "$1" -o "$2"
                echo -e "Running application...\n"
                "./$2"

                return 0

	elif [ "${src_file##*.}" == "cpp" ]; then
                if [ -z "$1" ] && [ -z "$2" ]; then
                        echo "Error; Usage is: compile <source_file_name>.cpp <optional_output_executable>"
                        return 1
                elif [ -z "$2" ]; then
                        echo "Compiling $1 into executable ${src_file%.*}..."
                        g++ "$1" -o "${src_file%.*}"
                        echo -e "Running application...\n"
                        "./${src_file%.*}"
                        return 0
                fi

                echo "Compiling $1 into executable $2..."
                g++ "$1" -o "$2"
                echo -e "Running application...\n"
                "./$2"

                return 0

	elif [ "${src_file##*.}" == "rs" ]; then
                if [ -z "$1" ]; then
                        echo "Error: Usage is: compile <source_file_name>.rs"
                        return 1
                fi

                echo "Compiling $1 into executable ${src_file%.*}..."
                rustc "$1"
                echo -e "Running application...\n"
                "./${src_name%.*}"

                return 0

        elif [ "${src_file##*.}" == "java" ]; then
                if [ -z "$1" ]; then
                        echo "Error: Usage is: compile <source_file_name>.java"
                        return 1
                fi

                echo "Compiling $1 into executable ${src_file%.*}..."
                javac "$1"
                echo -e "Running application...\n"
                java "${src_file%.*}"

                return 0

	fi
}

