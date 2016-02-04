CREATE TABLE [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue] (
    [pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormStaticKeywordName]                               DECIMAL (18) NOT NULL,
    [fkFormStaticKeywordValue]                              DECIMAL (18) NOT NULL,
    [fkFormName]                                            DECIMAL (18) NOT NULL,
    [LUPUser]                                               VARCHAR (50) NULL,
    [LUPDate]                                               DATETIME     NULL,
    [CreateUser]                                            VARCHAR (50) NULL,
    [CreateDate]                                            DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormStaticKeywordNameFormStaticKeywordValue] PRIMARY KEY CLUSTERED ([pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormName_fkFormStaticKeywordName]
    ON [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue]([fkFormName] ASC, [fkFormStaticKeywordName] ASC)
    INCLUDE([fkFormStaticKeywordValue]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormStaticKeywordName]
    ON [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue]([fkFormStaticKeywordName] ASC)
    INCLUDE([fkFormName], [fkFormStaticKeywordValue]);


GO
CREATE NONCLUSTERED INDEX [fkFormStaticKeywordValue]
    ON [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue]([fkFormStaticKeywordValue] ASC)
    INCLUDE([fkFormName], [fkFormStaticKeywordName]);


GO
CREATE Trigger [dbo].[tr_FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit_d] On [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue]
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
From FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] = d.[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
	,[fkFormStaticKeywordName]
	,[fkFormStaticKeywordValue]
	,[fkFormName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
	,[fkFormStaticKeywordName]
	,[fkFormStaticKeywordValue]
	,[fkFormName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit_UI] On [dbo].[FormJoinFormStaticKeywordNameFormStaticKeywordValue]
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

Update FormJoinFormStaticKeywordNameFormStaticKeywordValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormStaticKeywordNameFormStaticKeywordValue dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = i.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue
	Left Join Deleted d on d.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = d.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue
	Where d.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue is null

Update FormJoinFormStaticKeywordNameFormStaticKeywordValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormStaticKeywordNameFormStaticKeywordValue dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue = d.pkFormJoinFormStaticKeywordNameFormStaticKeywordValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue] = i.[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormStaticKeywordNameFormStaticKeywordValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
	,[fkFormStaticKeywordName]
	,[fkFormStaticKeywordValue]
	,[fkFormName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormStaticKeywordNameFormStaticKeywordValue]
	,[fkFormStaticKeywordName]
	,[fkFormStaticKeywordValue]
	,[fkFormName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table defines the relationship between static form keywords and their values.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormStaticKeywordNameFormStaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormStaticKeywordName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'fkFormStaticKeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormStaticKeywordValue', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'fkFormStaticKeywordValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to FormName', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'fkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormStaticKeywordNameFormStaticKeywordValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

