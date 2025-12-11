#!/bin/bash
# Start the Node.js application

echo "Starting Node.js application..."

cd /opt/app/app

# Ensure we have the right path
export PATH=$PATH:/usr/bin:/usr/local/bin

# Set environment variables
export NODE_ENV=production
export PORT=3000

# Start the application in the background
# Use full path to node to be safe
NODE_PATH=$(which node)
echo "Using node at: $NODE_PATH"

# Start with nohup
# Start with nohup
LOG_FILE="/home/ec2-user/devops-app.log"
PID_FILE="/home/ec2-user/devops-app.pid"

nohup $NODE_PATH server.js > $LOG_FILE 2>&1 &

# Save the PID
PID=$!
echo $PID > $PID_FILE

echo "Application started with PID: $PID"
sleep 5

# Check if it's still running
if ps -p $PID > /dev/null; then
   echo "Process $PID is running"
   exit 0
else
   echo "Process $PID failed to start"
   # Print last few lines of log
   tail -n 20 /home/ec2-user/devops-app.log
   exit 1
fi
