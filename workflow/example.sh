curl -X POST http://localhost:8080/api/workflow -H 'Content-Type: application/json' -d '{
    "name": "provision_server",
    "version": 1,
    "input": {
        "username": "***********",
        "password": "***********",
        "accountAlias": "MUC1",
        "dataCenter": "UC1",
        "groupName": "Default Group"
    }
}'