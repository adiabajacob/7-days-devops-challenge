#!/bin/bash
# Validate that the application is running and healthy

echo "Validating application health..."

MAX_RETRIES=10
RETRY_COUNT=0

while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    # Try to hit the health endpoint
    HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:3000/health)
    
    if [ "$HTTP_STATUS" == "200" ]; then
        echo "✅ Application is healthy! (HTTP $HTTP_STATUS)"
        exit 0
    fi
    
    RETRY_COUNT=$((RETRY_COUNT + 1))
    echo "Attempt $RETRY_COUNT/$MAX_RETRIES - Waiting for application to start..."
    sleep 5
done

echo "❌ Application health check failed after $MAX_RETRIES attempts"
exit 1
