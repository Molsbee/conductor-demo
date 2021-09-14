curl -X POST http://localhost:8080/api/metadata/taskdefs -H 'Content-Type: application/json' -d '[
	{
        "name": "dynamic_customer_setup",
        "description": "create dynamic set of tasks and input for those tasks",
        "retryCount": 0,
        "retryLogic": "FIXED",
        "ownerEmail": "william.molsbee@lumen.com"
    },
    {
        "name": "dynamic_customer_setup_join",
        "description": "join task for customer setup",
        "retryCount": 0,
        "retryLogic": "FIXED",
        "ownerEmail": "william.molsbee@lumen.com"
    }
]'