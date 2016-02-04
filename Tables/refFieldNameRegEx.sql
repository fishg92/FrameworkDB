CREATE TABLE [dbo].[refFieldNameRegEx] (
    [pkrefFieldNameRegEx] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [regExValues]         VARCHAR (150) NOT NULL,
    [regFieldName]        VARCHAR (250) NOT NULL,
    [FriendlyName]        VARCHAR (250) NULL,
    CONSTRAINT [PK_refFieldNameRegEx] PRIMARY KEY CLUSTERED ([pkrefFieldNameRegEx] ASC)
);


GO
CREATE Trigger [dbo].[tr_refFieldNameRegExAudit_UI] On [dbo].[refFieldNameRegEx]
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
From refFieldNameRegExAudit dbTable
Inner Join inserted i ON dbTable.[pkrefFieldNameRegEx] = i.[pkrefFieldNameRegEx]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFieldNameRegExAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFieldNameRegEx]
	,[regExValues]
	,[regFieldName]
	,[FriendlyName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkrefFieldNameRegEx]
	,[regExValues]
	,[regFieldName]
	,[FriendlyName]

From  Inserted
GO
CREATE Trigger [dbo].[tr_refFieldNameRegExAudit_d] On [dbo].[refFieldNameRegEx]
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
From refFieldNameRegExAudit dbTable
Inner Join deleted d ON dbTable.[pkrefFieldNameRegEx] = d.[pkrefFieldNameRegEx]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into refFieldNameRegExAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkrefFieldNameRegEx]
	,[regExValues]
	,[regFieldName]
	,[FriendlyName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkrefFieldNameRegEx]
	,[regExValues]
	,[regFieldName]
	,[FriendlyName]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFieldNameRegEx', @level2type = N'COLUMN', @level2name = N'pkrefFieldNameRegEx';

