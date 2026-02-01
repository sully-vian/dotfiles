# i3blocks config

This sis my i3blocks config. It is a collection of scripts that display various system information in the i3bar.

## Dependencies

- `acpi`: Used in [`battery.sh`](battery.sh) to get battery percentage.
- `awk`: Used in multiple scripts for text processing.
- `bc`: Used in [`cpu_usage.sh`](cpu_usage.sh) for floating-point arithmetic.
- `df`: Used in [`disk.sh`](disk.sh) to get disk usage.
- `free`: Used in [`memory.sh`](memory.sh) and [`swap.sh`](swap.sh) to get memory and swap usage.
- `grep`: Used in multiple scripts for text searching.
- `nmcli`: Used in [`network.sh`](network.sh) to get network information.
- `wpctl`: Used in [`volume.sh`](volume.sh) to get and set volume.
- `playerctl`: Used in [`mediaplayer.sh`](mediaplayer.sh) to control media players.
- `sed`: Used in [`cpu_usage.sh`](cpu_usage.sh) and [`disk.sh`](disk.sh) for text manipulation.
- `wget`: Used in [`network.sh`](network.sh) to get the public IP address.
- `xset`: Used in [`keyindicator.sh`](keyindicator.sh) to get keyboard states.
