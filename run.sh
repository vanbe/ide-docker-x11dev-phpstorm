#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
else
  echo "Warning: .env file not found."
fi

# Check if PROJECT_NAME is set
if [ -z "$PROJECT_NAME" ]; then
  echo "Error: PROJECT_NAME not defined in .env."
  exit 1
fi

CONTAINER_NAME="ide-phpstorm"
STACK_NAME=$PROJECT_NAME

export LOCAL_UID=$(id -u)
export LOCAL_GID=$(id -g)

start_ide() {
    echo "Starting PHPStorm IDE container..."
    xhost +local:
    docker compose -p $STACK_NAME -f ide/phpstorm/ide.docker-compose.yml up -d
    #all stack up
    #docker compose -p $STACK_NAME -f docker-compose.yml -f ide/phpstorm/ide.docker-compose.yml up -d
    echo "Waiting for container to initialize..."
    sleep 10
    if docker ps | grep -q $CONTAINER_NAME; then
        echo -e "\033[32mPHPStorm is running!\033[0m"
        echo "Attach to it using: docker attach ${CONTAINER_NAME}"
    else
        echo -e "\033[31mFailed to start PHPStorm container\033[0m"
        docker compose -p $STACK_NAME ps | grep $CONTAINER_NAME
        exit 1
    fi
}

stop_ide() {
    echo "Stopping PHPStorm IDE container..."
    docker stop $CONTAINER_NAME
    echo -e "\033[33mContainer stopped. Note: Your project files persist in volumes.\033[0m"
}

status_ide() {
    if docker ps | grep -q $CONTAINER_NAME; then
        echo -e "\033[32m● PHPStorm is running\033[0m"
        docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Ports}}" | grep $CONTAINER_NAME
    else
        echo -e "\033[33m● PHPStorm is not running\033[0m"
        if docker ps -a | grep -q $CONTAINER_NAME; then
            echo "Stopped container exists (safe to restart)"
        fi
    fi
}

case "$1" in
    start)
        start_ide
        ;;
    stop)
        stop_ide
        ;;
    restart)
        stop_ide
        start_ide
        ;;
    status)
        status_ide
        ;;
    help)
        echo "Usage: $0 {start|stop|restart|status}"
        echo "  start   - Launches PHPStorm IDE container"
        echo "  stop    - Stops the container (preserves volumes)"
        echo "  restart - Reboots the IDE environment"
        echo "  status  - Shows current state"
        echo "  help    - Show current help and command lists"
        exit 1
	;;
    *)
        start_ide
        ;;
esac
