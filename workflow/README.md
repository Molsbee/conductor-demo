CLC Rest API Workflow

## Login (get bearer token)
Method:   POST 
Endpoint: https://api.ctl.io/v2/authentication/login
#### Request
```javascript
{
   	"username":"demouser1",
   	"password":"mypassword"
}
```
#### Response
```javascript
{
    "userName": "user@email.com",
    "accountAlias": "ALIAS",
    "locationAlias": "DC1",
    "roles": [
        "AccountAdmin",
        "ServerAdmin"
    ],
    "bearerToken": "[LONG TOKEN VALUE]"
}
```

## Lookup Group ID
Method:   GET 
Endpoint: https://api.ctl.io/v2/datacenters/{accountAlias}/{dataCenter}?groupLinks=true
### Response
```javascript
{
  "id": "DC1",
  "name": "DC FRIENDLY NAME",
  "links": [
    {
      "rel": "self",
      "href": "/v2/datacenters/ALIAS/DC1"
    },
    {
      "rel":"group",
      "href":"/v2/groups/ALIAS/54faef9c2bfd41d6b30f787567f9b0d4",
      "id":"54faef9c2bfd41d6b30f787567f9b0d4",
      "name":"DC1 Hardware"
    }
  ]
}
```

METHOD:   GET
Endpoint: https://api.ctl.io/v2/groups/{accountAlias}/{groupId}
### Response
```javascript
{
  "id": "2a5c0b9662cf4fc8bf6180f139facdc0",
  "name": "Web Applications",
  "description": "public facing web apps",
  "locationId": "WA1",
  "type": "default",
  "status": "active",
  "serversCount": 2,
  "groups": [
    {
      "id": "31d13f501459411ba59304f3d47486eb",
      "name": "Training Environment",
      "description": "Temporary servers",
      "locationId": "WA1",
      "type": "default",
      "status": "active",
      "serversCount": 0,
      "groups": [],
      "links": [
        {
          "rel":"createGroup",
          "href":"/v2/groups/acct",
          "verbs":[
            "POST"
          ]
        },
        {
          "rel":"createServer",
          "href":"/v2/servers/acct",
          "verbs":[
            "POST"
          ]
        },
        {
          "rel": "self",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb",
          "verbs":[
            "GET",
            "PATCH",
            "DELETE"
          ]
        },
        {
          "rel": "parentGroup",
          "href": "/v2/groups/acct/231c3f3fec0e46499290b351199d555f",
          "id": "231c3f3fec0e46499290b351199d555f"
        },
        {
          "rel": "defaults",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb/defaults",
          "verbs":[
            "GET",
            "POST"
          ]
        },  
        {
          "rel": "billing",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb/billing"
        },
        {
          "rel": "archiveGroupAction",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb/archive"
        },
        {
          "rel": "statistics",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb/statistics"
        },
        {
          "rel":"upcomingScheduledActivities",
          "href":"/v2/groups/acct/8a03fcae8dd65411b05f00505682315a/upcomingScheduledActivities"
        },
        {
          "rel":"horizontalAutoscalePolicyMapping",
          "href":"/v2/groups/acct/31d13f501459411ba59304f3d47486eb/horizontalAutoscalePolicy",
          "verbs":[
            "GET",
            "PUT",
            "DELETE"
          ]
        },
        {
          "rel": "scheduledActivities",
          "href": "/v2/groups/acct/31d13f501459411ba59304f3d47486eb/scheduledActivities"
          "verbs":[
            "GET",
            "POST"
          ]
        }
      ]
    }
  ],
  "links":[
    {
      "rel": "self",
      "href": "/v2/groups/acct/2a5c0b9662cf4fc8bf6180f139facdc0"
    },
    {
      "rel": "parentGroup",
      "href": "/v2/groups/acct/540494152d0c4a9ab61869562b4c1471",
      "id": "540494152d0c4a9ab61869562b4c1471"
    },
    {
      "rel": "billing",
      "href": "/v2/groups/acct/2a5c0b9662cf4fc8bf6180f139facdc0/billing"
    },
    {
      "rel": "archiveGroupAction",
      "href": "/v2/groups/acct/2a5c0b9662cf4fc8bf6180f139facdc0/archive"
    },
    {
      "rel": "statistics",
      "href": "/v2/groups/acct/2a5c0b9662cf4fc8bf6180f139facdc0/statistics"
    },
    {
      "rel": "scheduledActivities",
      "href": "/v2/groups/acct/2a5c0b9662cf4fc8bf6180f139facdc0/scheduledActivities"
    },
    {
      "rel": "server",
      "href": "/v2/servers/acct/wa1acctpre7101",
      "id": "WA1ACCTPRE7101"
    },
    {
      "rel": "server",
      "href": "/v2/servers/btdi/wa1acctpre7202",
      "id": "WA1ACCTPRE7202"
    }
  ],
  "changeInfo": {
    "createdDate": "2012-12-17T01:17:17Z",
    "createdBy": "user@domain.com",
    "modifiedDate": "2014-05-16T23:49:25Z",
    "modifiedBy": "user@domain.com"
  },
  "customFields": [
    {
      "id": "22f002123e3b46d9a8b38ecd4c6df7f9",
      "name": "Cost Center",
      "value": "IT-DEV",
      "displayValue": "IT-DEV"
    },
    {
      "id": "58f83af6123846769ee6cb091ce3561e",
      "name": "CMDB ID",
      "value": "1100003",
      "displayValue": "1100003"
    }
  ]
}
```


## Create Server
Method:   POST 
Endpoint: https://api.ctl.io/v2/servers/{accountAlias}
#### Request
```javascript
{
  "name": "web",
  "description": "My web server",
  "groupId": "2a5c0b9662cf4fc8bf6180f139facdc0",
  "sourceServerId": "RHEL-6-64-TEMPLATE",
  "password": "P@ssw0rd1",
  "cpu": 2,
  "memoryGB": 4,
  "ttl": "2014-12-17T01:17:17Z"
}
```
#### Response
```javascript
{
  "server":"web",
  "isQueued":true,
  "links":[
    {
      "rel":"status",
      "href":"/v2/operations/alias/status/wa1-12345",
      "id":"wa1-12345"
    },
    {
      "rel":"self",  
      "href":"/v2/servers/alias/8134c91a66784c6dada651eba90a5123?uuid=True",
      "id":"8134c91a66784c6dada651eba90a5123",
      "verbs":[
        "GET"
      ]
    }
  ]
}
```

## Poll for Completion

## Add Public IP Address