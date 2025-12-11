#!/bin/bash
# Validate that the application is running and healthy

echo "Validating application health..."
echo "Waiting for app to initialize..."
sleep 10

MAX_RETRIES=20
RETRY_COUNT=0
URL="http://localhost:3000/health"

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    # Try to hit the health endpoint
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)
    
    if [ "$HTTP_STATUS" == "200" ]; then
        echo "✅ Application is healthy! (HTTP $HTTP_STATUS)"
        exit 0
    fi
    
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo "Attempt $RETRY_COUNT/$MAX_RETRIES - Status: $HTTP_STATUS - Waiting..."
    sleep 5
done

echo "❌ Application health check failed after $MAX_RETRIES attempts"
# Check logs to see what happened
echo "Server logs:"
tail -n 50 /home/ec2-user/devops-app.log
exit 1
