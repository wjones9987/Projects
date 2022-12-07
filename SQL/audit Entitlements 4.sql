SELECT u.displayname, ev.entitlement_value
FROM roles r 
JOIN role_entitlements re 
ON re.rolekey = r.rolekey  
JOIN entitlement_values ev
ON ev.entitlement_valuekey = re.entitlement_valuekey
JOIN account_entitlements1 ae1
ON ae1.entitlement_valuekey = ev.entitlement_valuekey
JOIN accounts a 
ON ae1.accountkey = a.accountkey
JOIN user_accounts ua 
ON ua.accountkey = a.accountkey
JOIN users u 
ON ua.userkey = u.userkey 
WHERE ev.status = 1
AND u.statuskey = 1
AND ev.entitlement_value NOT IN (
    SELECT ev.entitlement_value
    FROM users u 
    JOIN user_accounts ua 
    ON ua.userkey = u.userkey
    JOIN accounts a 
    ON ua.accountkey = a.accountkey
    JOIN account_entitlements1 ae1
    ON ae1.accountkey = a.accountkey
    JOIN entitlement_values ev
    ON ae1.entitlement_valuekey = ev.entitlement_valuekey
    WHERE a.endpointkey = '2'
    AND a.status IN ( '1', 'Manually Provisioned' )
    )










