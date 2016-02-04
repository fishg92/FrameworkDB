CREATE TABLE [dbo].[CPRefClientEducationType] (
    [pkCPRefClientEducationType] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Description]                VARCHAR (255) NULL,
    [LUPUser]                    VARCHAR (50)  NULL,
    [LUPDate]                    DATETIME      NULL,
    [CreateUser]                 VARCHAR (50)  NULL,
    [CreateDate]                 DATETIME      NULL,
    CONSTRAINT [PK_CPRefClientEducationType] PRIMARY KEY CLUSTERED ([pkCPRefClientEducationType] ASC)
);


GO
CREATE Trigger [dbo].[tr_CPRefClientEducationTypeAudit_d] On [dbo].[CPRefClientEducationType]
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
From CPRefClientEducationTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPRefClientEducationType] = d.[pkCPRefClientEducationType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientEducationTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientEducationType]
	,[Description]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPRefClientEducationType]
	,[Description]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPRefClientEducationTypeAudit_UI] On [dbo].[CPRefClientEducationType]
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

Update CPRefClientEducationType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientEducationType dbTable
	Inner Join Inserted i on dbtable.pkCPRefClientEducationType = i.pkCPRefClientEducationType
	Left Join Deleted d on d.pkCPRefClientEducationType = d.pkCPRefClientEducationType
	Where d.pkCPRefClientEducationType is null

Update CPRefClientEducationType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPRefClientEducationType dbTable
	Inner Join Deleted d on dbTable.pkCPRefClientEducationType = d.pkCPRefClientEducationType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPRefClientEducationTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPRefClientEducationType] = i.[pkCPRefClientEducationType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPRefClientEducationTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPRefClientEducationType]
	,[Description]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPRefClientEducationType]
	,[Description]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table contains look up values for education types.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'pkCPRefClientEducationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the education type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPRefClientEducationType', @level2type = N'COLUMN', @level2name = N'CreateDate';

