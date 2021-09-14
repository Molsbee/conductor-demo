curl -X PUT http://localhost:8080/api/metadata/workflow -H 'Content-Type: application/json' -d '[{
    "name": "setup_customer",
    "taskReferenceName": "setup_customer",
    "tasks": [
        {
            "name": "set_variable_test",
            "taskReferenceName": "set_variable_test",
            "type": "SET_VARIABLE",
            "inputParameters": {
                "iteration": 0
            }
        },
        {
            "name": "setup_customer_loop",
            "taskReferenceName": "setup_customer_loop",
            "type": "DO_WHILE",
            "inputParameters": {
                "siteCount": "${workflow.input.sites.length()}"
            },
            "loopCondition": "if ($.setup_customer_loop.iteration < $.siteCount) { true; } else { false; }",
            "loopOver": [
                {
                    "name": "openstack_create_domain",
                    "taskReferenceName": "openstack_create_domain",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "openstack_create_project",
                    "taskReferenceName": "openstack_create_project",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "openstack_create_user",
                    "taskReferenceName": "openstack_create_user",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "openstack_create_group",
                    "taskReferenceName": "openstack_create_group",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "openstack_set_permissions",
                    "taskReferenceName": "openstack_set_permissions",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "morpheus_create_cloud",
                    "taskReferenceName": "morpheus_create_cloud",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "morpheus_create_tenant_group",
                    "taskReferenceName": "morpheus_create_tenant_group",
                    "type": "SIMPLE",
                    "inputParameters": {
                        "sites": "${workflow.input.sites}",
                        "iteration": "${workflow.variables.iteration}"
                    }
                },
                {
                    "name": "update_iteration_count",
                    "taskReferenceName": "update_iteration_count",
                    "type": "SET_VARIABLE",
                    "inputParameters": {
                        "iteration": "${setup_customer_loop.output.iteration}"
                    }
                }
            ]
        }
    ],
    "ownerEmail": "william.molsbee@lumen.com"
}]'