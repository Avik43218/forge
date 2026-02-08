# Function to open applications

function open () {

        if [ -z "$1" ] && [ -z "$2" ]; then
                echo "Error: Usage is: open <optional '-d' flag for dGPU> <application_name>"
                return 1
        elif [ -z "$2" ]; then
                GPU_NAME="<Integrated GPU Name>"
                NOW=$(date +"%Y-%m-%d %H:%M:%S")

                "$1"

                if [ -e ~/.open.log ]; then
                        echo "$NOW    $1            $GPU_NAME" | tee -a ~/.open.log
                else
                        touch ~/.open.log
                        echo "$NOW    $1            $GPU_NAME" | tee -a ~/.open.log

                fi

	elif [ -n "$1" ] && [ -n "$2" ] && [ "$1" == "-d" ]; then
                GPU_NAME="<Dedicated GPU Name>"
                NOW=$(date +"%Y-%m-%d %H:%M:%S")

                prime-run "$2"

                if [ -e ~/.open.log ]; then
                        echo "$NOW    $2            $GPU_NAME" | tee -a ~/.open.log
                else
                        touch ~/.open.log
                        echo "$NOW    $2            $GPU_NAME" | tee -a ~/.open.log

                fi
        fi
}
