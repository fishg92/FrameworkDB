CREATE TABLE [dbo].[FormJoinFormComboNameFormComboValue] (
    [pkFormJoinFormComboNameFormComboValue] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkFormComboName]                       DECIMAL (18) NOT NULL,
    [fkFormComboValue]                      DECIMAL (18) NOT NULL,
    [LUPUser]                               VARCHAR (50) NULL,
    [LUPDate]                               DATETIME     NULL,
    [CreateUser]                            VARCHAR (50) NULL,
    [CreateDate]                            DATETIME     NULL,
    CONSTRAINT [PK_FormJoinFormComboNameFormComboValue] PRIMARY KEY CLUSTERED ([pkFormJoinFormComboNameFormComboValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormComboName_fkFormComboValue]
    ON [dbo].[FormJoinFormComboNameFormComboValue]([fkFormComboName] ASC, [fkFormComboValue] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkFormComboValue]
    ON [dbo].[FormJoinFormComboNameFormComboValue]([fkFormComboValue] ASC)
    INCLUDE([fkFormComboName]);


GO
CREATE Trigger [dbo].[tr_FormJoinFormComboNameFormComboValueAudit_d] On [dbo].[FormJoinFormComboNameFormComboValue]
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
From FormJoinFormComboNameFormComboValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormJoinFormComboNameFormComboValue] = d.[pkFormJoinFormComboNameFormComboValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormComboNameFormComboValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormComboNameFormComboValue]
	,[fkFormComboName]
	,[fkFormComboValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormJoinFormComboNameFormComboValue]
	,[fkFormComboName]
	,[fkFormComboValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormJoinFormComboNameFormComboValueAudit_UI] On [dbo].[FormJoinFormComboNameFormComboValue]
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

Update FormJoinFormComboNameFormComboValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormComboNameFormComboValue dbTable
	Inner Join Inserted i on dbtable.pkFormJoinFormComboNameFormComboValue = i.pkFormJoinFormComboNameFormComboValue
	Left Join Deleted d on d.pkFormJoinFormComboNameFormComboValue = d.pkFormJoinFormComboNameFormComboValue
	Where d.pkFormJoinFormComboNameFormComboValue is null

Update FormJoinFormComboNameFormComboValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormJoinFormComboNameFormComboValue dbTable
	Inner Join Deleted d on dbTable.pkFormJoinFormComboNameFormComboValue = d.pkFormJoinFormComboNameFormComboValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormJoinFormComboNameFormComboValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormJoinFormComboNameFormComboValue] = i.[pkFormJoinFormComboNameFormComboValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormJoinFormComboNameFormComboValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormJoinFormComboNameFormComboValue]
	,[fkFormComboName]
	,[fkFormComboValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormJoinFormComboNameFormComboValue]
	,[fkFormComboName]
	,[fkFormComboValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This field represents the many to many relationship between Form Combo fields and Form Combo Field Values.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'pkFormJoinFormComboNameFormComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormComboName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'fkFormComboName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the FormComboValue table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'fkFormComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormJoinFormComboNameFormComboValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

