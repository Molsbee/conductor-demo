curl -X POST http://localhost:8080/api/workflow -H 'Content-Type: application/json' -d '{
    "name": "setup_customer",
    "version": 1,
    "input": {
        "sites": ["Site1", "Site2", "Site3"]
    }
}'