SELECT DISTINCT 
                a.accountkey AS acctKey, 
                ev.entitlement_valuekey AS entvaluekey, 
                ev.entitlement_value    AS entvalue, 
                a.name AS accName, 
                u.displayname, 
                u.jobcode, 
                u.customproperty5 AS 'job title',
                u.userkey AS userKey,
                'Provision Access'
                Default_Action_For_Analytics 
FROM users u
    JOIN user_accounts ua
     ON ua.userkey  = u.userkey 
     JOIN accounts a
     ON a.accountkey = ua.accountkey
    JOIN endpoints e 
     ON e.endpointkey = a.endpointkey
    JOIN entitlement_types et
     ON et.endpointkey = e.endpointkey
    JOIN entitlement_values ev 
     ON ev.entitlementtypekey = et.entitlementtypekey 
    AND ev.entitlement_value = 'CN=app_RSA_Store,OU=Security,OU=Groups,OU=REI,DC=reicorpnet,DC=com'
WHERE
u.statuskey = 1
       AND u.customproperty19 = 'R'
       AND a.status IN ( '1', 'Manually Provisioned' )
       AND a.endpointkey = '2'
       AND u.employeetype = 'EMPLOYEE'
       AND u.jobcode IN ( 'R511002', 'R511003', 'R511004', 'R511005', 'R519004', 'R521007', 'R601009', 'R601007', 'R511000', 'R609014', 'R951032', 'U9514201', 'U9501201' )