CREATE proc [dbo].[autotest_Main]
as

/***********************
exec autotest_main
select * from autotesterror
where ErrorLevel = 'Error'
************************/

truncate table AutotestError

/******************************
Define the tables that are excluded from commenting rules
*******************************/
truncate table AutotestCommentExcludedTables

insert AutotestCommentExcludedTables (TableName) values ('AutotestError')
insert AutotestCommentExcludedTables (TableName) values ('BackfileImport')
insert AutotestCommentExcludedTables (TableName) values ('CPAgencyAddress')
insert AutotestCommentExcludedTables (TableName) values ('CPCaseWorker')
insert AutotestCommentExcludedTables (TableName) values ('CPCaseWorkerPhone')
insert AutotestCommentExcludedTables (TableName) values ('CPJoinCaseWorkerAgencyAddress')
insert AutotestCommentExcludedTables (TableName) values ('CPJoinCaseWorkerCaseWorkerPhone')
insert AutotestCommentExcludedTables (TableName) values ('CPPointInTimeSearchSetting')
insert AutotestCommentExcludedTables (TableName) values ('CPSmartFillKeywordMapping')
insert AutotestCommentExcludedTables (TableName) values ('DataMigratorStaging')
insert AutotestCommentExcludedTables (TableName) values ('ExternalDataSystemResult')
insert AutotestCommentExcludedTables (TableName) values ('ImportInformation')
insert AutotestCommentExcludedTables (TableName) values ('JoinApplicationUserConfiguration')
insert AutotestCommentExcludedTables (TableName) values ('JoinMainApplicantToDependantApplicant')
insert AutotestCommentExcludedTables (TableName) values ('LogEntryType')
insert AutotestCommentExcludedTables (TableName) values ('ParserIdentification')
insert AutotestCommentExcludedTables (TableName) values ('ParserKeyValue')
insert AutotestCommentExcludedTables (TableName) values ('ProgTextTableNorthwoods12483')
insert AutotestCommentExcludedTables (TableName) values ('PSPDocTypeSplit')
insert AutotestCommentExcludedTables (TableName) values ('PSPJoinDocSplitKeyword')
insert AutotestCommentExcludedTables (TableName) values ('refCashReceiptFieldType')
insert AutotestCommentExcludedTables (TableName) values ('refFieldNameRegEx')
insert AutotestCommentExcludedTables (TableName) values ('Report')
insert AutotestCommentExcludedTables (TableName) values ('RMS')
insert AutotestCommentExcludedTables (TableName) values ('RMSData')
insert AutotestCommentExcludedTables (TableName) values ('ScannedDocTypeMapping')
insert AutotestCommentExcludedTables (TableName) values ('SecurityGroup')
insert AutotestCommentExcludedTables (TableName) values ('SelfScanUsers')
insert AutotestCommentExcludedTables (TableName) values ('sysdiagrams')
insert AutotestCommentExcludedTables (TableName) values ('FormFavoriteDrawingLayer')

/*************************
All tables must have a primary key
************************/
insert AutotestError (ErrorText)
select 'Table ' + t.name + ' does not have a primary key'
from sys.tables t
where not exists (select *
				from sys.indexes i
				where t.object_id = i.object_id
				and i.is_primary_key = 1)

/*********************************
Tables with related audit tables
must have an insert, update, and delete trigger
********************************/
insert AutotestError (ErrorText)
select 'Table ' + t.name + ' is audited but does not have an insert trigger. Use pr__SYS_MakeAuditTableUITrigger to create the trigger.'
from	sys.tables t
where exists (select * from sys.tables au
				where au.name = t.name + 'Audit')
and	not exists (select *
				from	sys.triggers tr
				join 	sys.trigger_events ev
					on tr.object_id = ev.object_id
				where ev.type_desc = 'INSERT'
				and tr.parent_id = t.object_id)
				
insert AutotestError (ErrorText)
select 'Table ' + t.name + ' is audited but does not have an update trigger. Use pr__SYS_MakeAuditTableUITrigger to create the trigger.'
from	sys.tables t
where exists (select * from sys.tables au
				where au.name = t.name + 'Audit')
and	not exists (select *
				from	sys.triggers tr
				join 	sys.trigger_events ev
					on tr.object_id = ev.object_id
				where ev.type_desc = 'UPDATE'
				and tr.parent_id = t.object_id)
				
insert AutotestError (ErrorText)
select 'Table ' + t.name + ' is audited but does not have a delete trigger. Use pr__SYS_MakeAuditTableDeleteTrigger to create the trigger.'
from	sys.tables t
where exists (select * from sys.tables au
				where au.name = t.name + 'Audit')
and	not exists (select *
				from	sys.triggers tr
				join 	sys.trigger_events ev
					on tr.object_id = ev.object_id
				where ev.type_desc = 'DELETE'
				and tr.parent_id = t.object_id)
				
/********************************
All tables must have a description 
to allow auto-generation of the
data dictionary
********************************/
insert AutotestError (ErrorText, ErrorLevel)
select 'Table ' + t.name + ' has no description. Add an extended property with the name "MS_Description" to the table extended properties.'
		,'Error'
FROM            sysobjects t 
LEFT OUTER JOIN sys.extended_properties td 
    ON          td.major_id = t.id 
    AND         td.minor_id = 0 
    AND         td.name = 'MS_Description' 
WHERE t.type = 'u'
and t.name not like '%Audit'
and t.name not like 'CPImport%'
and not exists (	select	*
					from	AutotestCommentExcludedTables
					where TableName = t.name)
and td.value is null
ORDER BY    t.name


/********************************
All columns must have a description 
to allow auto-generation of the
data dictionary
********************************/
insert AutotestError (ErrorText, ErrorLevel)
SELECT 'Column ' + t.name + '.' + c.name + ' has no description. This is required to allow auto-generation of the data dictionary.'
		,'Error'
FROM            sysobjects t 
INNER JOIN  syscolumns c 
    ON          c.id = t.id 
LEFT OUTER JOIN sys.extended_properties cd 
    ON          cd.major_id = c.id 
    AND         cd.minor_id = c.colid 
    AND         cd.name = 'MS_Description' 
WHERE t.type = 'u'
and t.name not like '%Audit'
and t.name not like 'CPImport%'
and cd.value is null
and not exists (	select	*
					from	AutotestCommentExcludedTables
					where TableName = t.name)
ORDER BY    t.name, c.colorder 


/********************************
Column definitions must be consistent
between parent and audit tables
********************************/
insert AutotestError (ErrorText)
select 'Column definition for ' + c.name + ' is inconsistent between tables ' + t.name + ' and ' + t.name + 'Audit.'
from	sys.tables t
join sys.tables au
	on au.name = t.name + 'Audit'
join sys.columns c
	on t.object_id = c.object_id
where c.name not in ('LUPUser','LUPDate','CreateUser','CreateDate','DataChecksum')
and not exists (	select	*
					from	sys.columns ac
					where ac.object_id = au.object_id
					and ac.name = c.name
					and ac.system_type_id = c.system_type_id
					and ac.user_type_id = c.user_type_id
					and ac.max_length >= c.max_length
					and ac.precision = c.precision
					and ac.scale = c.scale
					and
						(
							ac.is_nullable = c.is_nullable
							or
							ac.is_nullable = 1
						)
					)
and not exists (	select	*
					from	AutotestCommentExcludedTables
					where TableName = t.name)

/********************************
Foreign keys must be indexed
********************************/
insert AutotestError (ErrorText)
select 'foreign key ' + c.name + ' is not indexed on table ' + t.name
from sys.tables t
join sys.columns c
	on t.object_id = c.object_id
where c.name like 'fk%'
and t.name not like '%Audit'
and exists (select * from sys.tables pt
			where pt.name = substring(c.name,3,100))
and not exists (select *
				from sys.index_columns ic
				where ic.object_id = t.object_id
				and ic.column_id = c.column_id
				and ic.index_column_id = 1
				and ic.is_included_column = 0)
/** Excluded tables **/
and t.name not in 
	(
		'CPImportLog'
		,'DataMigratorStaging'
	)
order by t.name, c.name	

/*********************************************
Duplicate indexes are not permitted
*******************************************/
insert AutotestError (ErrorText)
SELECT	'Table ' 
		+ object_name(i1.object_id)
		+ ' has a duplicate index definition. '
		+ 'Indexes ' + i1.name + ' and ' + i2.name
		+ ' have duplicate functionality. The index with the fewest number of columns should be deleted.'
		--, OBJECT_NAME(i1.object_id)     AS  'Table'
  --      ,i1.name                AS  'Index'
  --      ,i2.name                AS  'Duplicate Index'
FROM sys.indexes    i1,
     sys.indexes    i2
WHERE i1.index_id NOT IN (0,255)
  AND i2.index_id NOT IN (0,255)
  AND i1.object_id    = i2.object_id
  AND i1.index_id <> i2.index_id
  AND NOT EXISTS (SELECT *
                  FROM sysindexkeys  ik1,
                       sysindexkeys  ik2
                  WHERE ik1.id     = i1.object_id
                    AND ik1.id     = ik2.id
                    AND ik1.indid  = i1.index_id
                    AND ik2.indid  = i2.index_id
                    AND ik1.keyno  = ik2.keyno
                    AND ik1.colid <> ik2.colid)
and
	(
		(
			/* One of the indexes is primary key
			and the other index contains the same columns */
			(i1.is_primary_key = 1 or i2.is_primary_key = 1)
			and
			0 =        (SELECT  MAX(ik1.keyno) - MAX(ik2.keyno)
					  FROM sysindexkeys  ik1,
						   sysindexkeys  ik2
					  WHERE ik1.id     = i1.object_id
						AND ik1.id     = ik2.id
						AND ik1.indid  = i1.index_id
						AND ik2.indid  = i2.index_id)
		)
		or
		/* Neither of the indexes is a primary key */
		(
			i1.is_primary_key = 0
			and
			i2.is_primary_key = 0
		)
     )