CREATE TABLE [dbo].[FormComboValue] (
    [pkFormComboValue] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [ComboValue]       VARCHAR (255) NOT NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_FormComboValue] PRIMARY KEY CLUSTERED ([pkFormComboValue] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormComboValueAudit_UI] On [dbo].[FormComboValue]
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

Update FormComboValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormComboValue dbTable
	Inner Join Inserted i on dbtable.pkFormComboValue = i.pkFormComboValue
	Left Join Deleted d on d.pkFormComboValue = d.pkFormComboValue
	Where d.pkFormComboValue is null

Update FormComboValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormComboValue dbTable
	Inner Join Deleted d on dbTable.pkFormComboValue = d.pkFormComboValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormComboValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormComboValue] = i.[pkFormComboValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormComboValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormComboValue]
	,[ComboValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormComboValue]
	,[ComboValue]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormComboValueAudit_d] On [dbo].[FormComboValue]
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
From FormComboValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormComboValue] = d.[pkFormComboValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormComboValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormComboValue]
	,[ComboValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormComboValue]
	,[ComboValue]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds the individual values for a combo box.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'pkFormComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Possible value selection within a combo box', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'ComboValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboValue', @level2type = N'COLUMN', @level2name = N'CreateDate';

