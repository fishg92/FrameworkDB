CREATE TABLE [dbo].[CPPointInTimeSearchSetting] (
    [pkCPPointInTimeSearchSetting] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkDocumentType]               VARCHAR (50) NOT NULL,
    [DaysBefore]                   INT          NOT NULL,
    [DaysAfter]                    INT          NOT NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    CONSTRAINT [PK_CPPointInTimeSearchSetting] PRIMARY KEY CLUSTERED ([pkCPPointInTimeSearchSetting] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxfkDocumentType]
    ON [dbo].[CPPointInTimeSearchSetting]([fkDocumentType] ASC)
    INCLUDE([pkCPPointInTimeSearchSetting]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_CPPointInTimeSearchSettingAudit_d] On [dbo].[CPPointInTimeSearchSetting]
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
From CPPointInTimeSearchSettingAudit dbTable
Inner Join deleted d ON dbTable.[pkCPPointInTimeSearchSetting] = d.[pkCPPointInTimeSearchSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPPointInTimeSearchSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPPointInTimeSearchSetting]
	,[fkDocumentType]
	,[DaysBefore]
	,[DaysAfter]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPPointInTimeSearchSetting]
	,[fkDocumentType]
	,[DaysBefore]
	,[DaysAfter]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPPointInTimeSearchSettingAudit_UI] On [dbo].[CPPointInTimeSearchSetting]
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

Update CPPointInTimeSearchSetting
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPPointInTimeSearchSetting dbTable
	Inner Join Inserted i on dbtable.pkCPPointInTimeSearchSetting = i.pkCPPointInTimeSearchSetting
	Left Join Deleted d on d.pkCPPointInTimeSearchSetting = d.pkCPPointInTimeSearchSetting
	Where d.pkCPPointInTimeSearchSetting is null

Update CPPointInTimeSearchSetting
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPPointInTimeSearchSetting dbTable
	Inner Join Deleted d on dbTable.pkCPPointInTimeSearchSetting = d.pkCPPointInTimeSearchSetting
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPPointInTimeSearchSettingAudit dbTable
Inner Join inserted i ON dbTable.[pkCPPointInTimeSearchSetting] = i.[pkCPPointInTimeSearchSetting]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPPointInTimeSearchSettingAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPPointInTimeSearchSetting]
	,[fkDocumentType]
	,[DaysBefore]
	,[DaysAfter]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPPointInTimeSearchSetting]
	,[fkDocumentType]
	,[DaysBefore]
	,[DaysAfter]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPPointInTimeSearchSetting', @level2type = N'COLUMN', @level2name = N'pkCPPointInTimeSearchSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPPointInTimeSearchSetting', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPPointInTimeSearchSetting', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPPointInTimeSearchSetting', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPPointInTimeSearchSetting', @level2type = N'COLUMN', @level2name = N'CreateDate';

