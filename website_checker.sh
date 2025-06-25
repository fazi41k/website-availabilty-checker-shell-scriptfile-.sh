#!/bin/bash

# Function to check website availability
check_website() {
    local url=$1
    local logfile="website_status.log"

    # Send a GET request and measure response time
    response=$(curl -o /dev/null -s -w "%{http_code} %{time_total}\n" "$url")

    # Extract status code and response time
    status_code=$(echo "$response" | awk '{print $1}')
    response_time=$(echo "$response" | awk '{print $2}')

    # Log the result
    if [ "$status_code" -eq 200 ]; then
        echo "$(date): $url is UP. Response time: ${response_time}s" | tee -a "$logfile"
    else
        echo "$(date): $url is DOWN. Status code: $status_code" | tee -a "$logfile"
    fi
}

# Ensure a URL is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <website_url>"
    exit 1
fi

# Call the function with the provided URL
check_website "$1"
