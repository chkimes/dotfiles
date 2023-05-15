dateval=$(date +'%Y-%m-%d %l:%M:%S %p')
battery=$(cat /sys/class/power_supply/BAT1/capacity)
status=$(cat /sys/class/power_supply/BAT1/status)

statusEmoji=" "
if [ $status = "Charging" ]; then
	statusEmoji="↑"
elif [ $status = "Discharging" ]; then
	statusEmoji="↓"
fi

echo "$battery%$statusEmoji🔋 $dateval"
