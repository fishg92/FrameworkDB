CREATE TABLE [dbo].[AgencyLOB] (
    [pkAgencyLOB]   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AgencyLOBName] VARCHAR (100) NOT NULL,
    [fkAgency]      DECIMAL (18)  NOT NULL,
    [LUPUser]       VARCHAR (50)  NULL,
    [LUPDate]       DATETIME      NULL,
    [CreateUser]    VARCHAR (50)  NULL,
    [CreateDate]    DATETIME      NULL,
    [fkSupervisor]  DECIMAL (18)  CONSTRAINT [DF_AgencyLOB_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_AgencyLOB] PRIMARY KEY CLUSTERED ([pkAgencyLOB] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAgency]
    ON [dbo].[AgencyLOB]([fkAgency] ASC);


GO
CREATE Trigger [dbo].[tr_AgencyLOBAudit_d] On [dbo].[AgencyLOB]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AgencyLOBAudit dbTable
Inner Join deleted d ON dbTable.[pkAgencyLOB] = d.[pkAgencyLOB]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AgencyLOBAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAgencyLOB]
	,[AgencyLOBName]
	,[fkAgency]
	,[fkSupervisor]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAgencyLOB]
	,[AgencyLOBName]
	,[fkAgency]
	,[fkSupervisor]
From  Deleted
GO
CREATE Trigger [dbo].[tr_AgencyLOBAudit_UI] On [dbo].[AgencyLOB]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

Update AgencyLOB
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AgencyLOB dbTable
	Inner Join Inserted i on dbtable.pkAgencyLOB = i.pkAgencyLOB
	Left Join Deleted d on d.pkAgencyLOB = d.pkAgencyLOB
	Where d.pkAgencyLOB is null

Update AgencyLOB
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AgencyLOB dbTable
	Inner Join Deleted d on dbTable.pkAgencyLOB = d.pkAgencyLOB
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AgencyLOBAudit dbTable
Inner Join inserted i ON dbTable.[pkAgencyLOB] = i.[pkAgencyLOB]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AgencyLOBAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAgencyLOB]
	,[AgencyLOBName]
	,[fkAgency]
	,[fkSupervisor]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAgencyLOB]
	,[AgencyLOBName]
	,[fkAgency]
	,[fkSupervisor]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds a record and the configuration information for the various different levels of benefits that an agency provides.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'pkAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Level of Benefits name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'AgencyLOBName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key tot he Agency Config table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'fkAgency';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the user that is the supervisor for this level of benefits', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyLOB', @level2type = N'COLUMN', @level2name = N'fkSupervisor';

