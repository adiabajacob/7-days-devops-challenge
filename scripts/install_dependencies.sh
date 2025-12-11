#!/bin/bash
# Install application dependencies

echo "Installing application dependencies..."
echo "Current directory: $(pwd)"

cd /opt/app/app

# Ensure we have the right path for npm/node
export PATH=$PATH:/usr/bin:/usr/local/bin

echo "Check node version:"
node --version
echo "Check npm version:"
npm --version

# Install production dependencies
# unsafe-perm required for some packages when running as pseudo-user
npm install --production --unsafe-perm

echo "Dependencies installed successfully"
