SELECT u.username, u.displayname, u.jobcode, u.customproperty5 AS 'job title'
FROM users u
    JOIN user_accounts ua
     ON ua.userkey  = u.userkey 
     JOIN accounts a
     ON a.accountkey = ua.accountkey 
WHERE
u.statuskey = 1
       AND u.customproperty17 = xxx
       AND a.status IN ( '1', 'Manually Provisioned' )
       AND a.endpointkey = '2'
       AND u.employeetype = 'EMPLOYEE'
       AND u.jobcode IN ('Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx', 'Hxxxxxx')
