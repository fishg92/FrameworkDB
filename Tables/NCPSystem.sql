CREATE TABLE [dbo].[NCPSystem] (
    [pkNCPSystem]    DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [Class]          VARCHAR (50)  NULL,
    [Attribute]      VARCHAR (50)  NULL,
    [AttributeValue] VARCHAR (255) NULL,
    CONSTRAINT [PK_NCPSystem] PRIMARY KEY CLUSTERED ([pkNCPSystem] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Class_Attribute]
    ON [dbo].[NCPSystem]([Class] ASC, [Attribute] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_NCPSystemAudit_d] On [dbo].[NCPSystem]
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
From NCPSystemAudit dbTable
Inner Join deleted d ON dbTable.[pkNCPSystem] = d.[pkNCPSystem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NCPSystemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNCPSystem]
	,[Class]
	,[Attribute]
	,[AttributeValue]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkNCPSystem]
	,[Class]
	,[Attribute]
	,[AttributeValue]
From  Deleted
GO
CREATE Trigger [dbo].[tr_NCPSystemAudit_UI] On [dbo].[NCPSystem]
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
From NCPSystemAudit dbTable
Inner Join inserted i ON dbTable.[pkNCPSystem] = i.[pkNCPSystem]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into NCPSystemAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkNCPSystem]
	,[Class]
	,[Attribute]
	,[AttributeValue]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkNCPSystem]
	,[Class]
	,[Attribute]
	,[AttributeValue]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'System-wide internal configuration values', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPSystem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPSystem', @level2type = N'COLUMN', @level2name = N'pkNCPSystem';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Grouping classification for attributes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPSystem', @level2type = N'COLUMN', @level2name = N'Class';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of specific attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPSystem', @level2type = N'COLUMN', @level2name = N'Attribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value of attribute', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'NCPSystem', @level2type = N'COLUMN', @level2name = N'AttributeValue';

