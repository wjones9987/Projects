SELECT u.username, u.displayname, u.jobcode, u.customproperty5 AS 'job title'
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
    AND ev.entitlement_value = 'CN=app_xxx_xxx,OU=Security,OU=Groups,OU=REI,DC=reicorpnet,DC=com'
WHERE
u.statuskey = 1
       AND u.customproperty19 = 'R'
       AND a.status IN ( '1', 'Manually Provisioned' )
       AND a.endpointkey = '2'
       AND u.employeetype = 'EMPLOYEE'
       AND u.jobcode IN ( 'Rxxxxxx', 'Rxxxxxx', 'Rxxxxxx', 'Rxxxxxx', 'Rxxxxxx', 'Rxxxxxx', 'Uxxxxxx' )
