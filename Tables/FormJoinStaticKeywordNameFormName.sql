CREATE TABLE [dbo].[FormJoinStaticKeywordNameFormName] (
    [pkFormJoinStaticKeywordNameFormName] DECIMAL (18) NOT NULL,
    [fkFormName]                          DECIMAL (18) NOT NULL,
    [fkFormStaticKeywordName]             DECIMAL (18) NOT NULL,
    [LUPUser]                             VARCHAR (50) NULL,
    [LUPDate]                             DATETIME     NULL,
    [CreateUser]                          VARCHAR (50) NULL,
    [CreateDate]                          DATETIME     NULL,
    CONSTRAINT [PK_FormJoinStaticKeywordNameFormName] PRIMARY KEY CLUSTERED ([pkFormJoinStaticKeywordNameFormName] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName_fkFormStaticKeywordName]
    ON [dbo].[FormJoinStaticKeywordNameFormName]([fkFormName] ASC, [fkFormStaticKeywordName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormStaticKeywordName_fkFormName]
    ON [dbo].[FormJoinStaticKeywordNameFormName]([fkFormStaticKeywordName] ASC, [fkFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormJoinStaticKeywordNameFormNameAudit_d] On [dbo].[FormJoinStaticKeywordNameFormName]
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
From FormJoinStaticKeywordNameFormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinStaticKeywordNameFormName] = d.[pkFormJoinStaticKeywordNameFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinStaticKeywordNameFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinStaticKeywordNameFormName]
	,[fkFormName]
	,[fkFormStaticKeywordName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinStaticKeywordNameFormName]
	,[fkFormName]
	,[fkFormStaticKeywordName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinStaticKeywordNameFormNameAudit_UI] On [dbo].[FormJoinStaticKeywordNameFormName]
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

Update FormJoinStaticKeywordNameFormName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinStaticKeywordNameFormName dbTable
	Inner Join Inserted i on dbtable.pkFormJoinStaticKeywordNameFormName = i.pkFormJoinStaticKeywordNameFormName
	Left Join Deleted d on d.pkFormJoinStaticKeywordNameFormName = d.pkFormJoinStaticKeywordNameFormName
	Where d.pkFormJoinStaticKeywordNameFormName is null

Update FormJoinStaticKeywordNameFormName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinStaticKeywordNameFormName dbTable
	Inner Join Deleted d on dbTable.pkFormJoinStaticKeywordNameFormName = d.pkFormJoinStaticKeywordNameFormName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinStaticKeywordNameFormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinStaticKeywordNameFormName] = i.[pkFormJoinStaticKeywordNameFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinStaticKeywordNameFormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinStaticKeywordNameFormName]
	,[fkFormName]
	,[fkFormStaticKeywordName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinStaticKeywordNameFormName]
	,[fkFormName]
	,[fkFormStaticKeywordName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table passes through to the keywords in the various document management systems to connect them to Pilot Forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'pkFormJoinStaticKeywordNameFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormStaticKeywordName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'fkFormStaticKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinStaticKeywordNameFormName', @level2type = N'COLUMN', @level2name = N'CreateDate';

