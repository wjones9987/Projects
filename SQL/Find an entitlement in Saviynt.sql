SELECT ev.entitlement_value AS 'Group Name', e.endpointname
FROM account_entitlements1 ae1
JOIN entitlement_values ev
ON ae1.entitlement_valuekey = ev.entitlement_valuekey
JOIN accounts a
ON a.accountkey = ae1.accountkey
JOIN endpoints e
ON a.endpointkey = e.endpointkey
WHERE e.endpointkey in ('1', '2')
AND ev.entitlement_value LIKE '%SCS%';
