CREATE TABLE [dbo].[AutoFillDataView] (
    [pkAutoFillDataView]          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkAutoFillDataSource]        DECIMAL (18)  NOT NULL,
    [FriendlyName]                VARCHAR (100) NOT NULL,
    [TSql]                        VARCHAR (MAX) NOT NULL,
    [LupUser]                     VARCHAR (50)  NULL,
    [LupDate]                     DATETIME      NULL,
    [CreateUser]                  VARCHAR (50)  NULL,
    [CreateDate]                  DATETIME      NULL,
    [IgnoreProgramTypeSecurity]   TINYINT       NULL,
    [IgnoreSecuredClientSecurity] TINYINT       NULL,
    CONSTRAINT [PK_AutoFillDataView] PRIMARY KEY CLUSTERED ([pkAutoFillDataView] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutoFillDataSource]
    ON [dbo].[AutoFillDataView]([fkAutoFillDataSource] ASC);


GO
CREATE Trigger [dbo].[tr_AutoFillDataViewAudit_UI] On [dbo].[AutoFillDataView]
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

Update AutoFillDataView
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataView dbTable
	Inner Join Inserted i on dbtable.pkAutoFillDataView = i.pkAutoFillDataView
	Left Join Deleted d on d.pkAutoFillDataView = d.pkAutoFillDataView
	Where d.pkAutoFillDataView is null

Update AutoFillDataView
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From AutoFillDataView dbTable
	Inner Join Deleted d on dbTable.pkAutoFillDataView = d.pkAutoFillDataView
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From AutoFillDataViewAudit dbTable
Inner Join inserted i ON dbTable.[pkAutoFillDataView] = i.[pkAutoFillDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataView]
	,[fkAutoFillDataSource]
	,[FriendlyName]
	,[TSql]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkAutoFillDataView]
	,[fkAutoFillDataSource]
	,[FriendlyName]
	,[TSql]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]

From  Inserted
GO
CREATE Trigger [dbo].[tr_AutoFillDataViewAudit_d] On [dbo].[AutoFillDataView]
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
From AutoFillDataViewAudit dbTable
Inner Join deleted d ON dbTable.[pkAutoFillDataView] = d.[pkAutoFillDataView]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into AutoFillDataViewAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkAutoFillDataView]
	,[fkAutoFillDataSource]
	,[FriendlyName]
	,[TSql]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkAutoFillDataView]
	,[fkAutoFillDataSource]
	,[FriendlyName]
	,[TSql]
	,[IgnoreProgramTypeSecurity]
	,[IgnoreSecuredClientSecurity]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Specific representation of the data in the corresponding AutoFillDataSource', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'pkAutoFillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutoFillDataSource table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'fkAutoFillDataSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Common name of this data view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Query syntax applied to associated AutoFillDataSource to extract data', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'TSql';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'LupDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to indicate if program type security settings are bypassed for this view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'IgnoreProgramTypeSecurity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to indicate if secured clients are always included in this data view', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutoFillDataView', @level2type = N'COLUMN', @level2name = N'IgnoreSecuredClientSecurity';

