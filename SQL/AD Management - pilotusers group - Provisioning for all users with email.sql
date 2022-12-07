SELECT DISTINCT accounts.accountkey                     AS acctKey, 
                entitlement_values.entitlement_valuekey AS entvaluekey, 
                entitlement_values.entitlement_value    AS entvalue, 
                accounts.name                           AS accName, 
                users.userkey                           AS userKey,
                'Provision Access'
                Default_Action_For_Analytics 
FROM   users
       JOIN user_accounts 
         ON user_accounts.userkey  = users.userkey 
       JOIN accounts 
         ON accounts.accountkey = user_accounts.accountkey 
       JOIN endpoints 
         ON endpoints.endpointkey = accounts.endpointkey
       JOIN entitlement_types 
         ON entitlement_types.endpointkey = endpoints.endpointkey
       JOIN entitlement_values 
         ON entitlement_values.entitlementtypekey = entitlement_types.entitlementtypekey 
            AND entitlement_values.entitlement_value = 'CN=xxx_xxx_xxx_pilotusers,OU=Security,OU=Groups,OU=REI,DC=reicorpnet,DC=com'
       LEFT OUTER JOIN account_entitlements1 
                    ON accounts.accountkey = account_entitlements1.accountkey 
                       AND account_entitlements1.entitlement_valuekey = 
                           entitlement_values.entitlement_valuekey 
WHERE  account_entitlements1.entitlement_valuekey IS NULL
       AND users.statuskey = '1'
       AND accounts.status IN ( '1', 'Manually Provisioned' )
       AND accounts.endpointkey = '2'
       AND users.employeetype IN ( 'EMPLOYEE','CONTRACTOR') 
       AND accounts.customproperty22 IS NOT NULL
       AND entitlement_values.entitlement_value != 'CN=xxx_xxx_xxx_pilotusers,OU=Security,OU=Groups,OU=REI,DC=reicorpnet,DC=com'
