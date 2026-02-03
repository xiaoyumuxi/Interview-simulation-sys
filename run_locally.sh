#!/bin/bash

# Validate Java Version
JAVA_VER=$(java -version 2>&1 | head -n 1 | awk -F '"' '{print $2}')
# shellcheck disable=SC2071
if [[ "$JAVA_VER" < "21" ]]; then
    echo "Error: Java 21 or higher is required. Found $JAVA_VER"
    exit 1
fi

# Set Local Environment Variables
export POSTGRES_USER=yaoyao
export POSTGRES_PASSWORD=105822 # Using password from application.yml
export POSTGRES_DB=interview_guide
export REDIS_HOST=localhost
export APP_STORAGE_ENDPOINT=http://localhost:9000
export APP_STORAGE_ACCESS_KEY=minioadmin
export APP_STORAGE_SECRET_KEY=minioadmin
export APP_STORAGE_BUCKET=interview-guide

# Check if port 8080 is in use and kill it if user agrees
PID=$(lsof -t -i:8080)
if [ -n "$PID" ]; then
    echo "Warning: Port 8080 is already in use by process $PID."
    read -p "Do you want to kill this process? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        kill -9 $PID
        echo "Process $PID killed."
    else
        echo "Please free port 8080 manually."
        exit 1
    fi
fi

echo "Starting Backend..."
./gradlew bootRun
