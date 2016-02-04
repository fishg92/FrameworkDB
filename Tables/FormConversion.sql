CREATE TABLE [dbo].[FormConversion] (
    [pkFormConversion] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [Username]         VARCHAR (255)   NOT NULL,
    [MachineName]      VARCHAR (255)   NOT NULL,
    [PCLFile]          VARBINARY (MAX) NOT NULL,
    CONSTRAINT [PK_FormConversion] PRIMARY KEY CLUSTERED ([pkFormConversion] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormConversionAudit_UI] On [dbo].[FormConversion]
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
From FormConversionAudit dbTable
Inner Join inserted i ON dbTable.[pkFormConversion] = i.[pkFormConversion]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormConversionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormConversion]
	,[Username]
	,[MachineName]
	,[PCLFile]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormConversion]
	,[Username]
	,[MachineName]
	,0

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormConversionAudit_d] On [dbo].[FormConversion]
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
From FormConversionAudit dbTable
Inner Join deleted d ON dbTable.[pkFormConversion] = d.[pkFormConversion]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormConversionAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormConversion]
	,[Username]
	,[MachineName]
	,[PCLFile]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormConversion]
	,[Username]
	,[MachineName]
	,[PCLFile]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table stores information regarding the conversion of files into TIF format for use in Pilot Forms', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormConversion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system id number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormConversion', @level2type = N'COLUMN', @level2name = N'pkFormConversion';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the user doing the conversion', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormConversion', @level2type = N'COLUMN', @level2name = N'Username';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the machine that the file is from', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormConversion', @level2type = N'COLUMN', @level2name = N'MachineName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary data representing the file for conversion', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormConversion', @level2type = N'COLUMN', @level2name = N'PCLFile';

