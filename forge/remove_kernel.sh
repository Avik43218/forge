# Function to remove older kernels

function remove_kernel () {
        KERNEL_VERSION="$1"
        CURRENT_KERNEL=$(uname -r)

        if [ -z "$1" ]; then
                echo "Error: Usage is: remove_kernel <kernel_version>"
                return 1
        fi

        if [[ "$CURRENT_KERNEL" != "$KERNEL_VERSION" ]]; then
                sudo dnf remove kernel*"$KERNEL_VERSION"
                echo "Removing kernel-$KERNEL_VERSION..."
        else
                echo "Cannot remove the current kernel..."
                return 1
        fi

}
