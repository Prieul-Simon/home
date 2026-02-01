function help.disk_space() {
    echo "The following command may be sufficient for monitoring disk space use/available"
    echo "> df -h"
}
function help.battery() {
    echo "> acpi -V"
    echo "> upower -i /org/freedesktop/UPower/devices/battery_BAT1"
}
function help.battery.clipboard.acpi() {
    echo "acpi -V" | cb
}
function help.battery.clipboard.upower() {
    echo "upower -i /org/freedesktop/UPower/devices/battery_BAT1" | cb
}
