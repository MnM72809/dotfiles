#!/bin/bash

# --- Configuration ---
readonly DIR="/home/moriaan/.config/led"
readonly LOGFILE="/tmp/tuya-hsl.log"
readonly IP_ADDRESS="192.168.1.58"

export TUYA_DEVICE_ID=bfab7d5c33314c9796c9p6
export TUYA_DEVICE_IP="$IP_ADDRESS"
export TUYA_LOCAL_KEY=$'OVAj#=\x60PR^7c-MNB'
export TUYA_VERSION="3.3"

# --- Fast Argument Parsing ---
no_calibration=false
positional_args=()

for arg in "$@"; do
    if [[ "$arg" == "--no-calibration" ]]; then
        no_calibration=true
    else
        positional_args+=("$arg")
    fi
done

# Ensure minimum required arguments
if [[ ${#positional_args[@]} -lt 4 ]]; then
    echo "Error: Missing arguments." >&2
    exit 1
fi

fmt="${positional_args[0]}"
v1="${positional_args[1]}"
v2="${positional_args[2]}"
v3="${positional_args[3]}"

# --- Fast Calibration ---
if $no_calibration; then
    calibrated="$v1 $v2 $v3"
else
    calibrated=$("$DIR/calibrate.py" "$v1" "$v2" "$v3")
fi

# --- Instant Execution (Attempt 1) ---
# Fire the command immediately to minimize perceived latency
python3 "$DIR/set_strip_color.py" "$fmt" $calibrated &>/dev/null &
tuya_pid=$! 

# --- Background Network Monitoring, Retry, & Logging ---
{
    # Check if the device is reachable
    if ! ping -c 1 -W 1 "$IP_ADDRESS" &>/dev/null; then
        notify-send "LED strip warning" "Device offline. Retrying in 10s..." --urgency=low --expire-time=2000
        
        # Kill the first attempt since the device is unreachable right now
        kill "$tuya_pid" 2>/dev/null
        
        sleep 10

        # Retry ping
        if ping -c 1 -W 1 "$IP_ADDRESS" &>/dev/null; then
            # Device is back online! Fire the command again
            python3 "$DIR/set_strip_color.py" "$fmt" $calibrated &>/dev/null &
            tuya_pid=$!
            wait "$tuya_pid" 2>/dev/null
        else
            # Still offline, log the error and abort
            echo "Error: LED strip ($IP_ADDRESS) offline after retry. Script aborted." > "$LOGFILE"
            notify-send "LED strip error" "Device offline. Connection timed out." --urgency=critical --expire-time=10000
            exit 1
        fi
    else
        # First attempt was successful, just wait for it to finish normally
        wait "$tuya_pid" 2>/dev/null
    fi

    # Write log upon successful completion (either first try or after retry)
    {
        echo "Format:        $fmt"
        echo "Values:        $v1 $v2 $v3"
        echo "Calibrated:    $calibrated"
    } > "$LOGFILE"

} & 

# Disown the background monitoring block so the shell exits instantly
disown

exit 0
