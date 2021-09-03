# https://netflix.github.io/conductor/configuration/taskdef/
# Retry Logic (FIXED, EXPONENTIAL_BACKOFF)
# Timeout Policy (RETRY, TIME_OUT_WF, ALERT_ONLY)
curl -X POST http://localhost:8080/api/metadata/taskdefs -H 'Content-Type: application/json' -d '[
    {
        "name": "get_bearer_token",
        "description": "retrives a bearer token from clc api",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "inputKeys": [
            "username",
            "password"
        ],
        "outputKeys": [
            "bearerToken"
        ],
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "get_group_id",
        "description": "looks up the group uuid associated with the name provided",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "inputKeys": [
            "accountAlias",
            "dataCenter",
            "bearerToken",
            "groupName"
        ],
        "outputKeys": [
            "groupId"
        ],
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "create_server",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "inputKeys": [
            "accountAlias",
            "groupId",
            "bearerToken",
            "dataCenter"
        ],
        "outputKeys": [
            "serverUUID"
        ],
        "ownerEmail": "william.molsbee@lumen.com"
    }
]'