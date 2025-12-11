#!/bin/bash
# Install application dependencies

echo "Installing application dependencies..."

cd /opt/app/app

# Ensure npm is available
export PATH=$PATH:/usr/bin

# Install production dependencies
npm install --production

echo "Dependencies installed successfully"
