SELECT u.username, u.displayname, u.jobcode, u.customproperty5 AS 'job title'
FROM users u
    JOIN user_accounts ua
     ON ua.userkey  = u.userkey 
     JOIN accounts a
     ON a.accountkey = ua.accountkey 
WHERE
u.statuskey = 1
       AND u.customproperty17 = 774
       AND a.status IN ( '1', 'Manually Provisioned' )
       AND a.endpointkey = '2'
       AND u.employeetype = 'EMPLOYEE'
       AND u.jobcode IN ('H401180', 'H409062', 'H501169', 'H519038', 'H519060', 'H519088', 'H519094', 'H519095', 'H519106', 'H519107', 'H519114', 'H609027', 'H709018', 'H901666', 'H901841', 'H909270', 'H909287', 'H909288', 'H909289', 'H909290', 'H909291', 'H909292', 'H909293', 'H909316', 'H909351', 'H909378', 'H909406', 'H909440', 'H909479', 'H909487', 'H909498', 'H951818')
