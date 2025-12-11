#!/bin/bash
# Start the Node.js application

echo "Starting Node.js application..."

cd /opt/app/app

# Set environment variables
export NODE_ENV=production
export PORT=3000

# Start the application in the background
nohup node server.js > /var/log/devops-app.log 2>&1 &

# Save the PID for later
echo $! > /var/run/devops-app.pid

# Wait a moment for the app to start
sleep 3

echo "Application started with PID: $(cat /var/run/devops-app.pid)"
