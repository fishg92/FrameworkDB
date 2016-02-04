CREATE TABLE [dbo].[FormQuickListFormName] (
    [pkFormQuickListFormName] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkFormName]              DECIMAL (18)  NOT NULL,
    [fkFormUser]              DECIMAL (18)  NOT NULL,
    [QuickListFormName]       VARCHAR (255) NOT NULL,
    [DateAdded]               SMALLDATETIME CONSTRAINT [DF_FormQuickListFormName_DateAdded] DEFAULT (getdate()) NOT NULL,
    [Inactive]                TINYINT       CONSTRAINT [DF_FormQuickListFormName_InActive] DEFAULT ((0)) NOT NULL,
    [FormOrder]               INT           NOT NULL,
    [LUPUser]                 VARCHAR (50)  NULL,
    [LUPDate]                 DATETIME      NULL,
    [CreateUser]              VARCHAR (50)  NULL,
    [CreateDate]              DATETIME      NULL,
    [fkCPClientCase]          DECIMAL (18)  NULL,
    [fkCPClient]              DECIMAL (18)  NULL,
    CONSTRAINT [PK_FormQuickListFormName] PRIMARY KEY CLUSTERED ([pkFormQuickListFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormUser]
    ON [dbo].[FormQuickListFormName]([fkFormUser] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPClientCase]
    ON [dbo].[FormQuickListFormName]([fkCPClientCase] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkCPClient]
    ON [dbo].[FormQuickListFormName]([fkCPClient] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormName]
    ON [dbo].[FormQuickListFormName]([fkFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormQuickListFormNameAudit_UI] On [dbo].[FormQuickListFormName]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

if	update([fkFormName])
or	update([fkFormUser])
or	update([QuickListFormName])
or	update([DateAdded])
or	update([Inactive])
or	update([fkCPClientCase])
or	update([fkCPClient])
Begin
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

	Update FormQuickListFormName
		 Set [CreateUser] = @AuditUser
		,[CreateDate] = @Date
		,[LUPUser] = @AuditUser
		,[LUPDate] = @Date
		From FormQuickListFormName dbTable
		Inner Join Inserted i on dbtable.pkFormQuickListFormName = i.pkFormQuickListFormName
		Left Join Deleted d on d.pkFormQuickListFormName = d.pkFormQuickListFormName
		Where d.pkFormQuickListFormName is null

	Update FormQuickListFormName
		 Set [CreateUser] = d.CreateUser
		,[CreateDate] = d.CreateDate
		,[LUPUser] = @AuditUser
		,[LUPDate] = @Date
		From FormQuickListFormName dbTable
		Inner Join Deleted d on dbTable.pkFormQuickListFormName = d.pkFormQuickListFormName
	--End date current audit record
	Update dbTable
		Set AuditEndDate = @Date
	From FormQuickListFormNameAudit dbTable
	Inner Join inserted i ON dbTable.[pkFormQuickListFormName] = i.[pkFormQuickListFormName]
	Where dbTable.AuditEndDate is null

	--create new audit record
	Insert into FormQuickListFormNameAudit
		(
		AuditStartDate
		, AuditEndDate
		, AuditUser
		, AuditMachine
		, AuditDeleted
		,[pkFormQuickListFormName]
		,[fkFormName]
		,[fkFormUser]
		,[QuickListFormName]
		,[DateAdded]
		,[Inactive]
		,[FormOrder]

		)
		Select
		@Date
		, AuditEndDate = null
		, @AuditUser
		, @AuditMachine
		, AuditDeleted = 0
		,[pkFormQuickListFormName]
		,[fkFormName]
		,[fkFormUser]
		,[QuickListFormName]
		,[DateAdded]
		,[Inactive]
		,[FormOrder]

	From  Inserted
End
GO
CREATE Trigger [dbo].[tr_FormQuickListFormNameAudit_d] On [dbo].[FormQuickListFormName]
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
From FormQuickListFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormQuickListFormName] = d.[pkFormQuickListFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListFormName]
	,[fkFormName]
	,[fkFormUser]
	,[QuickListFormName]
	,[DateAdded]
	,[Inactive]
	,[FormOrder]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormQuickListFormName]
	,[fkFormName]
	,[fkFormUser]
	,[QuickListFormName]
	,[DateAdded]
	,[Inactive]
	,[FormOrder]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User-selected name for forms in favorites list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'pkFormQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkFormUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User-selected name for form in favorites list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'QuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date this item was added to the user''s favorites list', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'DateAdded';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to mark the favorite as inactive', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'Inactive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Display order of the item', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'FormOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'fk to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'fk to CPClient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListFormName', @level2type = N'COLUMN', @level2name = N'fkCPClient';

