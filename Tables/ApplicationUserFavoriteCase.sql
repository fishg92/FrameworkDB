CREATE TABLE [dbo].[ApplicationUserFavoriteCase] (
    [pkApplicationUserFavoriteCase] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]             DECIMAL (18) NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    CONSTRAINT [PK_ApplicationUserFavoriteCase] PRIMARY KEY CLUSTERED ([pkApplicationUserFavoriteCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ApplicationUserFavoriteCase]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPClientCase]
    ON [dbo].[ApplicationUserFavoriteCase]([fkCPClientCase] ASC);


GO
CREATE Trigger [dbo].[tr_ApplicationUserFavoriteCaseAudit_UI] On [dbo].[ApplicationUserFavoriteCase]
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
From ApplicationUserFavoriteCaseAudit dbTable
Inner Join inserted i ON dbTable.[pkApplicationUserFavoriteCase] = i.[pkApplicationUserFavoriteCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserFavoriteCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserFavoriteCase]
	,[fkApplicationUser]
	,[fkCPClientCase]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkApplicationUserFavoriteCase]
	,[fkApplicationUser]
	,[fkCPClientCase]

From  Inserted
GO
CREATE Trigger [dbo].[tr_ApplicationUserFavoriteCaseAudit_d] On [dbo].[ApplicationUserFavoriteCase]
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
From ApplicationUserFavoriteCaseAudit dbTable
Inner Join deleted d ON dbTable.[pkApplicationUserFavoriteCase] = d.[pkApplicationUserFavoriteCase]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserFavoriteCaseAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserFavoriteCase]
	,[fkApplicationUser]
	,[fkCPClientCase]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkApplicationUserFavoriteCase]
	,[fkApplicationUser]
	,[fkCPClientCase]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Joins case case workers (in ApplicationUser) to a set of cases that they want to keep working on.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserFavoriteCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key (that is a candidate for removal)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserFavoriteCase', @level2type = N'COLUMN', @level2name = N'pkApplicationUserFavoriteCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserFavoriteCase', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserFavoriteCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';

