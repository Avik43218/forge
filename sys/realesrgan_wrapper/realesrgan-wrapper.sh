echo -e "\n----- REALESRGAN IMAGE UPSCALER -----\n"

echo "The following models are available:"
echo "	1. realesrgan-x4plus --> For general images"
echo "	2. realesrgan-x4plus-anime --> For anime images"
echo "	3. realesr-animevideov3 --> For animation videos"
echo "	4. realesrnet-x4plus"

read -p "Source file path: " SOURCE
read -p "Output file path: " OUTPUT
read -p "Output format: " FORMAT
read -p "Scaling: " SCALE
read -p "Model: " MODEL
read -p "GPU: " GPU

if [[ -z "$SOURCE" || -z "$OUTPUT" ]]; then
	echo "Error: SOURCE or OUTPUT paths cannot be empty!"
	exit 1
fi

if [[ -z "$FORMAT" ]]; then
	FORMAT="${OUTPUT##*.}"
fi

if [[ -z "$SCALE" ]]; then
	SCALE=4     # Default value
fi

if [[ -z "$MODEL" ]]; then
	echo "Error: A MODEL must be selected!"
	exit 1
else
	case "$MODEL" in
		"1")
			MODEL_NAME="realesrgan-x4plus"
			;;
		"2")
			MODEL_NAME="realesrgan-x4plus-anime"
			;;
		"3")
			MODEL_NAME="realesr-animevideov3"
			;;
		"4")
			MODEL_NAME="realesrnet-x4plus"
			;;
		*)
			;;
	esac

fi

if [[ -z "$GPU" ]]; then
	GPU=1       # Use dedicated GPU
fi

# The CLI command
realesrgan-ncnn-vulkan -m /usr/local/share/realesrgan/models -i "$SOURCE" -o "$OUTPUT" -f "$FORMAT" -s "$SCALE" -n "$MODEL_NAME" -g "$GPU" 2>&1 | sed -u '1,12d' | awk '{

	num = $1
	gsub(/%/, "", num)

	blocks = int(num / 2)

	bar = ""
	for(i=0; i<blocks; i++) bar = bar "="
	bar = bar ">"

	printf "\rProgress: [%-50s] %0.1f%% ", bar, num
	fflush(stdout)
} END {
	print "\nComplete!\n"
}'



