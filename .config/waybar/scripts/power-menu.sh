#!/bin/bash

# Script to perform various actions based on a given argument.
# Inspired by the provided menu-actions dictionary.

# Function to perform actions based on the given command
execute_action() {
  local action="$1"

  case "$action" in
	"lock")
	  echo "Locking session..."
	  loginctl lock-session
	  ;;
    "shutdown")
      echo "Shutting down..."
      pkill -15 spotify
      hyprshutdown -p 'shutdown now'
      ;;
    "reboot")
      echo "Rebooting..."
      pkill -15 spotify
      hyprshutdown -p 'reboot'
      ;;
    "suspend")
      echo "Suspending..."
      systemctl suspend
      ;;
    "hibernate")
      echo "Hibernating..."
      systemctl hibernate
      ;;
    "windows")
      echo "Rebooting to Windows..."
      sudo grub-reboot 2
      pkill -15 spotify
      hyprshutdown -p 'reboot'
      ;;
    "windows_hibernate")
	  echo "Hibernating... (Next boot is Windows)"
      sudo grub-reboot 2
      systemctl hibernate
	  ;;
	"exit")
	  echo "Exiting hyprland..."
	  pkill -15 spotify
	  hyprshutdown
	  ;;
    *)
      echo "Invalid action: $action"
      ;;
  esac
}

# Check if an argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 [action]"
  echo "Available actions:"
  echo "  lock                - Locks the session"
  echo "  shutdown            - Shuts down the system"
  echo "  reboot              - Reboots the system"
  echo "  suspend             - Suspends the system"
  echo "  hibernate           - Hibernates the system"
  echo "  windows             - Reboots to Windows"
  echo "  windows_hibernate   - Hibernates, next boot is windows"
  echo "  exit                - Exits hyprland"
  exit 1
fi

# Execute the specified action
execute_action "$1"

exit 0
