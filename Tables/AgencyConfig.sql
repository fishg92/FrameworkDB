CREATE TABLE [dbo].[AgencyConfig] (
    [pkAgencyConfig] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AgencyName]     VARCHAR (100) NOT NULL,
    [LUPUser]        VARCHAR (50)  NULL,
    [LUPDate]        DATETIME      NULL,
    [CreateUser]     VARCHAR (50)  NULL,
    [CreateDate]     DATETIME      NULL,
    [fkSupervisor]   DECIMAL (18)  CONSTRAINT [DF_AgencyConfig_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_AgencyConfig] PRIMARY KEY CLUSTERED ([pkAgencyConfig] ASC)
);


GO
CREATE Trigger [dbo].[tr_AgencyConfigAudit_UI] On [dbo].[AgencyConfig]
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

Update AgencyConfig
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AgencyConfig dbTable
	Inner Join Inserted i on dbtable.pkAgencyConfig = i.pkAgencyConfig
	Left Join Deleted d on d.pkAgencyConfig = d.pkAgencyConfig
	Where d.pkAgencyConfig is null

Update AgencyConfig
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AgencyConfig dbTable
	Inner Join Deleted d on dbTable.pkAgencyConfig = d.pkAgencyConfig
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AgencyConfigAudit dbTable
Inner Join inserted i ON dbTable.[pkAgencyConfig] = i.[pkAgencyConfig]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AgencyConfigAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAgencyConfig]
	,[AgencyName]
	,[fkSupervisor]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAgencyConfig]
	,[AgencyName]
	,[fkSupervisor]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AgencyConfigAudit_d] On [dbo].[AgencyConfig]
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
From AgencyConfigAudit dbTable
Inner Join deleted d ON dbTable.[pkAgencyConfig] = d.[pkAgencyConfig]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AgencyConfigAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAgencyConfig]
	,[AgencyName]
	,[fkSupervisor]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAgencyConfig]
	,[AgencyName]
	,[fkSupervisor]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains agency configuration information, including a full agency name, and the ApplicationUser who is the agency supervisor.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'pkAgencyConfig';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Long form of the name of the agency', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'AgencyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key identifying the user that is the agency supervisor', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AgencyConfig', @level2type = N'COLUMN', @level2name = N'fkSupervisor';

