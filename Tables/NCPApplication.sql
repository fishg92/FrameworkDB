CREATE TABLE [dbo].[NCPApplication] (
    [pkNCPApplication]         DECIMAL (18)  NOT NULL,
    [ApplicationName]          VARCHAR (100) NOT NULL,
    [CurrentVersion]           VARCHAR (50)  NULL,
    [AssemblyName]             VARCHAR (100) NULL,
    [Registered]               BIT           NULL,
    [DefaultAppOrder]          INT           NULL,
    [LUPUser]                  VARCHAR (50)  NULL,
    [LUPDate]                  DATETIME      NULL,
    [CreateUser]               VARCHAR (50)  NULL,
    [CreateDate]               DATETIME      NULL,
    [ShowInMenu]               BIT           NULL,
    [MinimumFunctionalityOnly] BIT           NULL,
    CONSTRAINT [PK_NCPApplication] PRIMARY KEY CLUSTERED ([pkNCPApplication] ASC)
);


GO
CREATE Trigger [dbo].[tr_NCPApplicationAudit_UI] On [dbo].[NCPApplication]
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

Update NCPApplication
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From NCPApplication dbTable
	Inner Join Inserted i on dbtable.pkNCPApplication = i.pkNCPApplication
	Left Join Deleted d on d.pkNCPApplication = d.pkNCPApplication
	Where d.pkNCPApplication is null

Update NCPApplication
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From NCPApplication dbTable
	Inner Join Deleted d on dbTable.pkNCPApplication = d.pkNCPApplication
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From NCPApplicationAudit dbTable
Inner Join inserted i ON dbTable.[pkNCPApplication] = i.[pkNCPApplication]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NCPApplicationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNCPApplication]
	,[ApplicationName]
	,[CurrentVersion]
	,[AssemblyName]
	,[Registered]
	,[DefaultAppOrder]
	,[ShowInMenu]
	,[MinimumFunctionalityOnly]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkNCPApplication]
	,[ApplicationName]
	,[CurrentVersion]
	,[AssemblyName]
	,[Registered]
	,[DefaultAppOrder]
	,[ShowInMenu]
	,[MinimumFunctionalityOnly]

From  Inserted
GO
CREATE Trigger [dbo].[tr_NCPApplicationAudit_d] On [dbo].[NCPApplication]
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
From NCPApplicationAudit dbTable
Inner Join deleted d ON dbTable.[pkNCPApplication] = d.[pkNCPApplication]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NCPApplicationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNCPApplication]
	,[ApplicationName]
	,[CurrentVersion]
	,[AssemblyName]
	,[Registered]
	,[DefaultAppOrder]
	,[ShowInMenu]
	,[MinimumFunctionalityOnly]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkNCPApplication]
	,[ApplicationName]
	,[CurrentVersion]
	,[AssemblyName]
	,[Registered]
	,[DefaultAppOrder]
	,[ShowInMenu]
	,[MinimumFunctionalityOnly]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table to store system information about the client install', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'pkNCPApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Application name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'ApplicationName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Current version of the application', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'CurrentVersion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The DLL that drives the application', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'AssemblyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not the application is registered', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'Registered';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to order the applications in the UI', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'DefaultAppOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the application be shown in the menu?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'ShowInMenu';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the application set to a minimum functionality mode (for apps that other apps rely on, but haven''t been purchased, for example)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPApplication', @level2type = N'COLUMN', @level2name = N'MinimumFunctionalityOnly';

