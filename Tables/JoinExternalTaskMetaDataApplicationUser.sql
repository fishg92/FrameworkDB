CREATE TABLE [dbo].[JoinExternalTaskMetaDataApplicationUser] (
    [pkJoinExternalTaskMetaDataApplicationUser] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkExternalTaskMetaData]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                         DECIMAL (18) NOT NULL,
    [UserRead]                                  BIT          CONSTRAINT [DF_JoinExternalTaskMetaDataApplicationUser_UserRead] DEFAULT ((0)) NOT NULL,
    [UserReadNote]                              BIT          CONSTRAINT [DF_JoinExternalTaskMetaDataApplicationUser_UserReadNote] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskMetaDataApplicationUser] PRIMARY KEY CLUSTERED ([pkJoinExternalTaskMetaDataApplicationUser] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkExternalTaskMetaData_fkApplicationUser]
    ON [dbo].[JoinExternalTaskMetaDataApplicationUser]([fkExternalTaskMetaData] ASC, [fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinExternalTaskMetaDataApplicationUser]([fkApplicationUser] ASC)
    INCLUDE([fkExternalTaskMetaData]);


GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataApplicationUserAudit_UI] On [dbo].[JoinExternalTaskMetaDataApplicationUser]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From JoinExternalTaskMetaDataApplicationUserAudit dbTable
Inner Join inserted i ON dbTable.[pkJoinExternalTaskMetaDataApplicationUser] = i.[pkJoinExternalTaskMetaDataApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataApplicationUser]
	,[fkExternalTaskMetaData]
	,[fkApplicationUser]
	,[UserRead]
	,[UserReadNote]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkJoinExternalTaskMetaDataApplicationUser]
	,[fkExternalTaskMetaData]
	,[fkApplicationUser]
	,[UserRead]
	,[UserReadNote]

From  Inserted
GO
CREATE Trigger [dbo].[tr_JoinExternalTaskMetaDataApplicationUserAudit_d] On [dbo].[JoinExternalTaskMetaDataApplicationUser]
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
From JoinExternalTaskMetaDataApplicationUserAudit dbTable
Inner Join deleted d ON dbTable.[pkJoinExternalTaskMetaDataApplicationUser] = d.[pkJoinExternalTaskMetaDataApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into JoinExternalTaskMetaDataApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkJoinExternalTaskMetaDataApplicationUser]
	,[fkExternalTaskMetaData]
	,[fkApplicationUser]
	,[UserRead]
	,[UserReadNote]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkJoinExternalTaskMetaDataApplicationUser]
	,[fkExternalTaskMetaData]
	,[fkApplicationUser]
	,[UserRead]
	,[UserReadNote]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table pulls information from an external source of task metatdata (such as a DMS''s workflow) to associate it with an individual user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser', @level2type = N'COLUMN', @level2name = N'pkJoinExternalTaskMetaDataApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to meta data in some external workflow system for a task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser', @level2type = N'COLUMN', @level2name = N'fkExternalTaskMetaData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not the user has read the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser', @level2type = N'COLUMN', @level2name = N'UserRead';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not the user has read the associated note for the task', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinExternalTaskMetaDataApplicationUser', @level2type = N'COLUMN', @level2name = N'UserReadNote';

