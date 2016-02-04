CREATE TABLE [dbo].[FormComboName] (
    [pkFormComboName] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [ComboName]       VARCHAR (50) NOT NULL,
    [LUPUser]         VARCHAR (50) NULL,
    [LUPDate]         DATETIME     NULL,
    [CreateUser]      VARCHAR (50) NULL,
    [CreateDate]      DATETIME     NULL,
    CONSTRAINT [PK_FormComboName] PRIMARY KEY CLUSTERED ([pkFormComboName] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormComboNameAudit_d] On [dbo].[FormComboName]
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
From FormComboNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormComboName] = d.[pkFormComboName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormComboNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormComboName]
	,[ComboName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormComboName]
	,[ComboName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormComboNameAudit_UI] On [dbo].[FormComboName]
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

Update FormComboName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormComboName dbTable
	Inner Join Inserted i on dbtable.pkFormComboName = i.pkFormComboName
	Left Join Deleted d on d.pkFormComboName = d.pkFormComboName
	Where d.pkFormComboName is null

Update FormComboName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormComboName dbTable
	Inner Join Deleted d on dbTable.pkFormComboName = d.pkFormComboName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormComboNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormComboName] = i.[pkFormComboName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormComboNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormComboName]
	,[ComboName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormComboName]
	,[ComboName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds the data describing the combo box fields on a form (though the values are held in FormComboValue)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'pkFormComboName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the combo box', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'ComboName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormComboName', @level2type = N'COLUMN', @level2name = N'CreateDate';

