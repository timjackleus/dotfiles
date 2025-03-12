#!/usr/bin/env fish

# Function to format the price with color based on value
function format_price
    set price $argv[1]
    
    # Color coding based on price
    if test $price -lt 1
        # Green for low prices
        set_color green
    else if test $price -lt 2
        # Yellow for medium prices
        set_color yellow
    else
        # Red for high prices
        set_color red
    end
    
    # Print the price with SEK/kWh
    echo -n "$price SEK/kWh"
    set_color normal
end

# Function to format time
function format_time
    set time_str $argv[1]
    # Extract hours and minutes from ISO time string
    echo $time_str | string replace -r ".*T(\d+):(\d+).*" '$1:$2'
end

# Get current date in YYYY/MM-DD format
set year (date +%Y)
set month (date +%m)
set day (date +%d)

# API URL
set api_url "https://www.elprisetjustnu.se/api/v1/prices/$year/$month-$day"_SE3.json

# Fetch data
echo "Fetching electricity prices for SE3 region..."
set response (curl -s $api_url)

if test -z "$response"
    echo "Error: Failed to fetch data from API"
    exit 1
end

# Parse JSON and find current hour
set current_hour (date +%H)
set current_hour_index 0
set found_current false

# Print header
echo ""
echo (set_color --bold)"Electricity Prices - SE3 Region - "(date +%Y-%m-%d)(set_color normal)
echo "----------------------------------------"

# Process and display prices
echo $response | jq -c '.[]' | while read -l price_data
    # Extract data
    set sek_price (echo $price_data | jq -r '.SEK_per_kWh')
    set time_start (echo $price_data | jq -r '.time_start')
    set time_end (echo $price_data | jq -r '.time_end')
    
    # Format time for display
    set display_time (format_time $time_start)" - "(format_time $time_end)
    
    # Check if this is the current hour
    set hour_start (echo $time_start | string replace -r ".*T(\d+):.*" '$1')
    
    # Round price to 2 decimal places for display
    set display_price (printf "%.2f" $sek_price)
    
    # Determine if this is current hour
    if test $hour_start -eq $current_hour
        # Current hour - highlight with background
        echo -n (set_color --background=brblack --bold)" CURRENT "
        echo -n (set_color normal)" "
        echo -n (set_color --bold)$display_time(set_color normal)" "
        format_price $display_price
        echo ""
        set found_current true
    else if test $found_current = false; and test $hour_start -eq (math $current_hour - 1)
        # Previous hour
        echo -n " PREVIOUS "$display_time" "
        format_price $display_price
        echo ""
    else if test $found_current = true; and test $current_hour_index -lt 10
        # Next hours (up to 10)
        set current_hour_index (math $current_hour_index + 1)
        echo -n "     NEXT "$display_time" "
        format_price $display_price
        echo ""
    end
end

echo ""
echo "Tip: Lower prices are green, medium are yellow, high are red"
