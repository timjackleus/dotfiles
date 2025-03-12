#!/usr/bin/env fish

# Configuration
set -g next_day_lines 8  # Number of lines to display for next day (set to -1 for all)

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

# Function to format date from ISO string
function format_date
    set date_str $argv[1]
    # Extract date from ISO time string
    echo $date_str | string replace -r "(\d+)-(\d+)-(\d+)T.*" '$1-$2-$3'
end

# Function to fetch and process price data
function fetch_and_process_prices
    set api_url $argv[1]
    set is_next_day $argv[2]
    set current_hour $argv[3]
    set current_hour_index $argv[4]
    set found_current $argv[5]
    
    # Fetch data
    set response (curl -s -o /dev/null -w "%{http_code}" -L $api_url)
    
    # Check if the response is 200 (OK)
    if test $response -ne 200
        # If this is the next day and it's not available, just return
        if test "$is_next_day" = "true"
            return 1
        else
            echo "Error: Failed to fetch data from API (HTTP $response)"
            exit 1
        end
    end
    
    # Now actually get the data
    set data (curl -s -L $api_url)
    
    if test -z "$data"
        if test "$is_next_day" = "true"
            return 1
        else
            echo "Error: Failed to fetch data from API (empty response)"
            exit 1
        end
    end
    
    # Print header if this is the first day
    if test "$is_next_day" = "false"
        echo ""
        echo (set_color --bold)"Electricity Prices - SE3 Region - "(date +%Y-%m-%d)(set_color normal)
        echo ----------------------------------------
    else
        # Get the date from the first entry to show next day's date
        set next_day_date (echo $data | jq -r '.[0].time_start' | format_date)
        echo ""
        echo (set_color --bold)"Next Day - $next_day_date"(set_color normal)
        echo ----------------------------------------
    end
    
    # Process and display prices
    echo $data | jq -c '.[]' | while read -l price_data
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
        
        # Determine if this is current hour (only for current day)
        if test "$is_next_day" = "false"; and test $hour_start -eq $current_hour
            # Current hour - highlight with background
            echo -n (set_color --background=brblack --bold)" CURRENT "
            echo -n (set_color normal)" "
            echo -n (set_color --bold)$display_time(set_color normal)" "
            format_price $display_price
            echo ""
            set found_current true
        else if test "$is_next_day" = "false"; and test $found_current = false; and test $hour_start -eq (math $current_hour - 1)
            # Previous hour (only for current day)
            echo -n " PREVIOUS "$display_time" "
            format_price $display_price
            echo ""
        else if test "$is_next_day" = "false"; and test $found_current = true; and test $current_hour_index -lt 10
            # Next hours (up to 10) for current day
            set current_hour_index (math $current_hour_index + 1)
            echo -n "     NEXT "$display_time" "
            format_price $display_price
            echo ""
        else if test "$is_next_day" = "true"
            # For next day, show limited number of hours based on configuration
            # If next_day_lines is -1, show all hours
            if test $next_day_lines -eq -1; or test $current_hour_index -lt $next_day_lines
                echo -n "          "$display_time" "
                format_price $display_price
                echo ""
                set current_hour_index (math $current_hour_index + 1)
            end
        end
    end
    
    return 0
end

# Get current date in YYYY/MM-DD format
set year (date +%Y)
set month (date +%m)
set day (date +%d)

# Calculate next day
set next_day_timestamp (date -v+1d +%s)
set next_year (date -r $next_day_timestamp +%Y)
set next_month (date -r $next_day_timestamp +%m)
set next_day (date -r $next_day_timestamp +%d)

# API URLs
set current_day_url "https://www.elprisetjustnu.se/api/v1/prices/$year/$month-$day"_SE3.json
set next_day_url "https://www.elprisetjustnu.se/api/v1/prices/$next_year/$next_month-$next_day"_SE3.json

# Parse JSON and find current hour
set current_hour (date +%H)
set current_hour_index 0
set found_current false
set next_day_hour_index 0  # Separate counter for next day hours

echo "Fetching electricity prices for SE3 region..."

# Fetch and process current day
fetch_and_process_prices $current_day_url "false" $current_hour $current_hour_index $found_current

# Try to fetch and process next day
fetch_and_process_prices $next_day_url "true" $current_hour $next_day_hour_index $found_current

echo ""
echo "Tip: Lower prices are green, medium are yellow, high are red"
