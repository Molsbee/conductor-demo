curl -X PUT http://localhost:8080/api/metadata/workflow -H 'Content-Type: application/json' -d '[{
    "name": "setup_customer_dynamic_fork",
    "taskReferenceName": "setup_customer_dynamic_fork",
    "tasks": [
        {
            "name": "dynamic_customer_setup",
            "taskReferenceName": "dynamic_customer_setup",
            "type": "SIMPLE",
            "inputParameters": {
                "sites": "${workflow.input.sites}"
            }
        },
        {
            "name": "dynamic_customer_setup_tasks",
            "taskReferenceName": "dynamic_customer_setup_tasks",
            "inputParameters": {
                "dynamicTasks": "${dynamic_customer_setup.output.dynamicTasksJSON}",
                "dynamicTasksInput": "${dynamic_customer_setup.output.dynamicTasksInputJSON}"
            },
            "type": "FORK_JOIN_DYNAMIC",
            "dynamicForkTasksParam": "dynamicTasks",
            "dynamicForkTasksInputParamName": "dynamicTasksInput"
        },
        {
            "name": "dynamic_customer_setup_join",
            "taskReferenceName": "dynamic_customer_setup_join",
            "type": "JOIN",
            "joinOn": ["${dynamic_customer_setup.output.joinTaskReferenceNames}"]
        }
    ],
    "ownerEmail": "william.molsbee@lumen.com"
}]'


curl -X POST http://localhost:8080/api/workflow -H 'Content-Type: application/json' -d '{
    "name": "setup_customer_dynamic_fork",
    "version": 1,
    "input": {
        "sites": ["Site1", "Site2", "Site3"]
    }
}'




{
   "forkedTaskDefs": [
      {
         "name": "sub_workflow_Site1",
         "taskReferenceName": "sub_workflow_Site1",
         "inputParameters": {
            "site": "Site1"
         },
         "type": "SUB_WORKFLOW",
         "decisionCases": {},
         "defaultCase": [],
         "forkTasks": [],
         "startDelay": 0,
         "subWorkflowParam": {
            "name": "setup_customer_workflow",
            "version": 0,
            "workflowDefinition": {
               "name": "setup_customer_workflow",
               "description": "setup customer in openstack and morpheus",
               "version": 0,
               "tasks": [
                  {
                     "name": "openstack_create_domain",
                     "taskReferenceName": "openstack_create_domain_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_project",
                     "taskReferenceName": "openstack_create_project_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_user",
                     "taskReferenceName": "openstack_create_user_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_group",
                     "taskReferenceName": "openstack_create_group_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_set_permissions",
                     "taskReferenceName": "openstack_set_permissions_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_cloud",
                     "taskReferenceName": "morpheus_create_cloud_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_tenant_group",
                     "taskReferenceName": "morpheus_create_tenant_group_Site1",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  }
               ],
               "inputParameters": [],
               "outputParameters": {},
               "schemaVersion": 0,
               "restartable": true,
               "workflowStatusListenerEnabled": false,
               "timeoutPolicy": "ALERT_ONLY",
               "timeoutSeconds": 0,
               "variables": {}
            }
         },
         "joinOn": [],
         "optional": false,
         "defaultExclusiveJoinTask": [],
         "asyncComplete": false,
         "loopOver": [],
         "retryLogic": "UNSPECIFIED"
      },
      {
         "name": "sub_workflow_Site2",
         "taskReferenceName": "sub_workflow_Site2",
         "inputParameters": {
            "site": "Site2"
         },
         "type": "SUB_WORKFLOW",
         "decisionCases": {},
         "defaultCase": [],
         "forkTasks": [],
         "startDelay": 0,
         "subWorkflowParam": {
            "name": "setup_customer_workflow",
            "version": 0,
            "workflowDefinition": {
               "name": "setup_customer_workflow",
               "description": "setup customer in openstack and morpheus",
               "version": 0,
               "tasks": [
                  {
                     "name": "openstack_create_domain",
                     "taskReferenceName": "openstack_create_domain_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_project",
                     "taskReferenceName": "openstack_create_project_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_user",
                     "taskReferenceName": "openstack_create_user_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_group",
                     "taskReferenceName": "openstack_create_group_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_set_permissions",
                     "taskReferenceName": "openstack_set_permissions_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_cloud",
                     "taskReferenceName": "morpheus_create_cloud_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_tenant_group",
                     "taskReferenceName": "morpheus_create_tenant_group_Site2",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  }
               ],
               "inputParameters": [],
               "outputParameters": {},
               "schemaVersion": 0,
               "restartable": true,
               "workflowStatusListenerEnabled": false,
               "timeoutPolicy": "ALERT_ONLY",
               "timeoutSeconds": 0,
               "variables": {}
            }
         },
         "joinOn": [],
         "optional": false,
         "defaultExclusiveJoinTask": [],
         "asyncComplete": false,
         "loopOver": [],
         "retryLogic": "UNSPECIFIED"
      },
      {
         "name": "sub_workflow_Site3",
         "taskReferenceName": "sub_workflow_Site3",
         "inputParameters": {
            "site": "Site3"
         },
         "type": "SUB_WORKFLOW",
         "decisionCases": {},
         "defaultCase": [],
         "forkTasks": [],
         "startDelay": 0,
         "subWorkflowParam": {
            "name": "setup_customer_workflow",
            "version": 0,
            "workflowDefinition": {
               "name": "setup_customer_workflow",
               "description": "setup customer in openstack and morpheus",
               "version": 0,
               "tasks": [
                  {
                     "name": "openstack_create_domain",
                     "taskReferenceName": "openstack_create_domain_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_project",
                     "taskReferenceName": "openstack_create_project_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_user",
                     "taskReferenceName": "openstack_create_user_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_create_group",
                     "taskReferenceName": "openstack_create_group_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "openstack_set_permissions",
                     "taskReferenceName": "openstack_set_permissions_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_cloud",
                     "taskReferenceName": "morpheus_create_cloud_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  },
                  {
                     "name": "morpheus_create_tenant_group",
                     "taskReferenceName": "morpheus_create_tenant_group_Site3",
                     "inputParameters": {
                        "site": "${workflow.input.site}"
                     },
                     "type": "SIMPLE",
                     "decisionCases": {},
                     "defaultCase": [],
                     "forkTasks": [],
                     "startDelay": 0,
                     "joinOn": [],
                     "optional": false,
                     "defaultExclusiveJoinTask": [],
                     "asyncComplete": false,
                     "loopOver": [],
                     "retryLogic": "UNSPECIFIED"
                  }
               ],
               "inputParameters": [],
               "outputParameters": {},
               "schemaVersion": 0,
               "restartable": true,
               "workflowStatusListenerEnabled": false,
               "timeoutPolicy": "ALERT_ONLY",
               "timeoutSeconds": 0,
               "variables": {}
            }
         },
         "joinOn": [],
         "optional": false,
         "defaultExclusiveJoinTask": [],
         "asyncComplete": false,
         "loopOver": [],
         "retryLogic": "UNSPECIFIED"
      }
   ],
   "forkedTasks": [
      "sub_workflow_Site1",
      "sub_workflow_Site2",
      "sub_workflow_Site3"
   ]
}