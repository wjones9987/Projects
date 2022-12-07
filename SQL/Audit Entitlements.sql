SELECT u.username, r.role_name, ev.entitlement_value, u.customproperty17 AS 'Division', u.customproperty19 AS 'Sector'

FROM roles r 
JOIN role_user_account rua
ON rua.rolekey = r.rolekey
JOIN role_entitlements re 
ON re.rolekey = rua.rolekey
JOIN entitlement_values ev
ON ev.entitlement_valuekey = re.entitlement_valuekey

JOIN users u 
ON u.userkey = rua.userkey

JOIN user_accounts ua
ON ua.userkey  = u.userkey
JOIN accounts a
ON a.accountkey = ua.accountkey 

LEFT JOIN account_entitlements1 ae1
ON ae1.accountkey = a.accountkey
AND ae1.entitlement_valuekey = re.entitlement_valuekey

WHERE ae1.accentkey IS NULL
AND a.endpointkey = '2'
AND r.customproperty1 IN ('jobCode role', 'div_jobCode role')
AND u.statuskey = 1
AND a.status IN ( '1', 'Manually Provisioned' )
AND ev.status = 1
AND entitlement_value LIKE '%OU=REI,DC=reicorpnet,DC=com%'