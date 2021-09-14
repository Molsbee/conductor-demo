curl -X POST http://localhost:8080/api/metadata/taskdefs -H 'Content-Type: application/json' -d '[
    {
        "name": "openstack_create_domain",
        "description": "creates the domain in specified openstack cluster",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "inputKeys": [],
        "outputKeys": [],
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "openstack_create_project",
        "description": "create a project within openstack",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "openstack_create_user",
        "description": "create a user within openstack",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "openstack_create_group",
        "description": "create a group within openstack",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "openstack_set_permissions",
        "description": "sets permissions within openstack",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "morpheus_create_cloud",
        "description": "create a cloud within morpheus",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "morpheus_create_tenant_group",
        "description": "create a tenant group in morpheus",
        "retryCount": 3,
        "retryLogic": "FIXED",
        "retryDelaySeconds": 10,
        "timeoutPolicy": "TIME_OUT_WF",
        "ownerEmail": "william.molsbee@lumen.com"
    },
]'