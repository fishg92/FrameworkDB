CREATE TABLE [dbo].[Configuration] (
    [pkConfiguration] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [Grouping]        VARCHAR (200)  NOT NULL,
    [ItemKey]         VARCHAR (200)  NOT NULL,
    [ItemValue]       NVARCHAR (300) NOT NULL,
    [ItemDescription] VARCHAR (300)  NOT NULL,
    [AppID]           INT            NOT NULL,
    [Sequence]        INT            CONSTRAINT [DF_Configuration_Sequence] DEFAULT ((1)) NOT NULL,
    [LUPUser]         VARCHAR (50)   NULL,
    [LUPDate]         DATETIME       NULL,
    [CreateUser]      VARCHAR (50)   NULL,
    [CreateDate]      DATETIME       NULL,
    CONSTRAINT [PK_Configuration] PRIMARY KEY NONCLUSTERED ([pkConfiguration] ASC)
);


GO
CREATE Trigger [dbo].[tr_ConfigurationAudit_d] On [dbo].[Configuration]
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
From ConfigurationAudit dbTable
Inner Join deleted d ON dbTable.[pkConfiguration] = d.[pkConfiguration]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ConfigurationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkConfiguration]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkConfiguration]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ConfigurationAudit_UI] On [dbo].[Configuration]
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

Update Configuration
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Configuration dbTable
	Inner Join Inserted i on dbtable.pkConfiguration = i.pkConfiguration
	Left Join Deleted d on d.pkConfiguration = d.pkConfiguration
	Where d.pkConfiguration is null

Update Configuration
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From Configuration dbTable
	Inner Join Deleted d on dbTable.pkConfiguration = d.pkConfiguration
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ConfigurationAudit dbTable
Inner Join inserted i ON dbTable.[pkConfiguration] = i.[pkConfiguration]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ConfigurationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkConfiguration]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkConfiguration]
	,[Grouping]
	,[ItemKey]
	,[ItemValue]
	,[ItemDescription]
	,[AppID]
	,[Sequence]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Configuration information for the application. Where the information in this table is repeated in external configuration files, it should be because the client needs to have some configuration information before they can connect to the server.

This is a table that is a candidate for refactoring at some point as well as general pruning.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'pkConfiguration';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Configuration grouping for these options.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'Grouping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human-readable identifier of the property that is being configured.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'ItemKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of the property being configured.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'ItemValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Longer description of the property being set.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'ItemDescription';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application ID for the property', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'AppID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ordering number for how properties should be listed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'Sequence';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Configuration', @level2type = N'COLUMN', @level2name = N'CreateDate';

