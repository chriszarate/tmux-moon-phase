#!/usr/bin/env bash

# moonphase
# =======
#
# Based on a dotfiles script by John Krueger:
# https://github.com/jtmkrueger/dotfiles
#
# This script calculates current moon phase, and returns an
# appropriate emoji. Nice for the tmux status bar.

get_moon_phase() {
	local lp newmoon now phase phase_number

	lp=2551443
	now=$(date -u +"%s")
	newmoon=592500
	phase="(($now - $newmoon) % $lp)"
	phase_number=$((((phase / 86400) + 1)*100000))

	if   [ $phase_number -lt 184566 ];  then echo "🌑|new moon"
	elif [ $phase_number -lt 553699 ];  then echo "🌒|waxing crescent"
	elif [ $phase_number -lt 922831 ];  then echo "🌓|first quarter"
	elif [ $phase_number -lt 1291963 ]; then echo "🌔|waxing gibbous"
	elif [ $phase_number -lt 1661096 ]; then echo "🌕|full moon"
	elif [ $phase_number -lt 2030228 ]; then echo "🌖|waning gibbous"
	elif [ $phase_number -lt 2399361 ]; then echo "🌗|last quarter"
	elif [ $phase_number -lt 2768493 ]; then echo "🌘|waning crescent"
	else
		echo "🌑|new moon"
	fi
}

get_tmux_option() {
	local option_value

	option_value=$(tmux show-option -gqv "$1")

	if [ -z "$option_value" ]; then
		echo "$2"
	else
		echo "$option_value"
	fi
}

update_status() {
	local moon_data status_value

	moon_data=(${moon_phase//|/ })
	status_value="$(get_tmux_option "$1")"
	status_value="${status_value/$moon_phase_placeholder/${moon_data[0]}}"
	status_value="${status_value/$moon_phase_text_placeholder/${moon_data[1]} ${moon_data[2]}}"

	tmux set-option -gq "$1" "$status_value"
}

# Substitutions
moon_phase_placeholder="\#{moon_phase}"
moon_phase_text_placeholder="\#{moon_phase_text}"

moon_phase=$(get_moon_phase)
update_status "status-left"
update_status "status-right"
