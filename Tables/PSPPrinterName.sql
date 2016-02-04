CREATE TABLE [dbo].[PSPPrinterName] (
    [pkPSPPrinterName] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [PrinterName]      VARCHAR (255) NOT NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_PSPPrinterName] PRIMARY KEY CLUSTERED ([pkPSPPrinterName] ASC)
);


GO
CREATE Trigger [dbo].[tr_PSPPrinterNameAudit_d] On [dbo].[PSPPrinterName]
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
From PSPPrinterNameAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPPrinterName] = d.[pkPSPPrinterName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPrinterNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPrinterName]
	,[PrinterName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPPrinterName]
	,[PrinterName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPPrinterNameAudit_UI] On [dbo].[PSPPrinterName]
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

Update PSPPrinterName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPrinterName dbTable
	Inner Join Inserted i on dbtable.pkPSPPrinterName = i.pkPSPPrinterName
	Left Join Deleted d on d.pkPSPPrinterName = d.pkPSPPrinterName
	Where d.pkPSPPrinterName is null

Update PSPPrinterName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPPrinterName dbTable
	Inner Join Deleted d on dbTable.pkPSPPrinterName = d.pkPSPPrinterName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPPrinterNameAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPPrinterName] = i.[pkPSPPrinterName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPPrinterNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPPrinterName]
	,[PrinterName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPPrinterName]
	,[PrinterName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table manages a list of virtual Compass Printers for that process.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'pkPSPPrinterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the printer', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'PrinterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrinterName', @level2type = N'COLUMN', @level2name = N'CreateDate';

