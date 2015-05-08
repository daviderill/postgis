-- Objects loaded
SELECT c.relname As item_type, 
    COALESCE(proc.proname,typ.typname, cd.relname, op.oprname, 
        'CAST(' || cs.typname || ' AS ' || ct.typname || ') ', opcname, opfname) As item_name,
    COALESCE(proc.proisagg,false) As is_agg, oidvectortypes(proc.proargtypes) As arg_types
FROM pg_depend As d INNER JOIN pg_extension As e
    ON d.refobjid = e.oid INNER JOIN pg_class As c ON
        c.oid = d.classid
        LEFT JOIN pg_proc AS proc ON proc.oid = d.objid
        LEFT JOIN pg_type AS typ ON typ.oid = d.objid
        LEFT JOIN pg_class As cd ON cd.oid = d.objid
        LEFT JOIN pg_operator As op ON op.oid = d.objid
        LEFT JOIN pg_cast AS ca ON ca.oid = d.objid
        LEFT JOIN pg_type AS cs ON ca.castsource = cs.oid
        LEFT JOIN pg_type AS ct ON ca.casttarget = ct.oid
        LEFT JOIN pg_opclass As oc ON oc.oid = d.objid
        LEFT JOIN pg_opfamily As ofa ON ofa.oid = d.objid
WHERE d.deptype = 'e' and e.extname = 'postgis'
ORDER BY item_type, item_name;