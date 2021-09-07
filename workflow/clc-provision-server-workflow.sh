# https://netflix.github.io/conductor/configuration/workflowdef/
# "failureWorkflow" will allow you to call a workflow for any possible cleanup
curl -X POST http://localhost:8080/api/metadata/workflow -H 'Content-Type: application/json' -d '{
    "name": "provision_server",
    "description": "Provisions a server in CLC based on a subset of the required input parameters",
    "version": 1,
    "tasks": [
        {
            "name": "get_bearer_token",
            "taskReferenceName": "get_bearer_token",
            "type": "SIMPLE",
            "inputParameters": {
                "username": "${workflow.input.username}",
                "password": "${workflow.input.password}"
            }
        },
        {
            "name": "get_group_id",
            "taskReferenceName": "get_group_id",
            "type": "SIMPLE",
            "inputParameters": {
                "accountAlias": "${workflow.input.accountAlias}",
                "dataCenter": "${workflow.input.dataCenter}",
                "bearerToken": "${get_bearer_token.output.bearerToken}",
                "groupName": "${workflow.input.groupName}"
            }
        },
        {
            "name": "create_server",
            "taskReferenceName": "create_server",
            "type": "SIMPLE",
            "inputParameters": {
                "accountAlias": "${workflow.input.accountAlias}",
                "groupId": "${get_group_id.output.groupId}",
                "bearerToken": "${get_bearer_token.output.bearerToken}",
                "dataCenter": "${workflow.input.dataCenter}"
            }
        }
    ],
    "outputParameters": {
        "serverUUID": "${create_server.output.serverUUID}"
    },
    "restartable": true,
    "workflowStatusListenerEnabled": false,
    "schemaVersion": 2,
    "ownerEmail": "william.molsbee@lumen.com"
}'