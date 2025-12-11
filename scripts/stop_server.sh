#!/bin/bash
# Stop the running Node.js application

echo "Stopping Node.js application..."

# Find and kill the Node.js process
pkill -f "node server.js" || true

# Also try to kill any process on port 3000
fuser -k 3000/tcp 2>/dev/null || true

# Wait a moment for the process to stop
sleep 2

echo "Application stopped successfully"
