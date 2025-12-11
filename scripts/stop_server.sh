#!/bin/bash
# Stop the running Node.js application

echo "Stopping Node.js application..."

# Find and kill the Node.js process
PID_FILE="/home/ec2-user/devops-app.pid"

if [ -f "$PID_FILE" ]; then
    PID=$(cat "$PID_FILE")
    echo "Killing process $PID"
    kill $PID || true
    rm "$PID_FILE"
else
    echo "No PID file found at $PID_FILE"
    pkill -f "node server.js" || true
fi

# Also try to kill any process on port 3000
fuser -k 3000/tcp 2>/dev/null || true

# Wait a moment for the process to stop
sleep 2

echo "Application stopped successfully"
