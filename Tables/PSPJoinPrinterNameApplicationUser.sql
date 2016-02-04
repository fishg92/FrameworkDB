CREATE TABLE [dbo].[PSPJoinPrinterNameApplicationUser] (
    [pkPSPJoinPrinterNameApplicationUser] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkPSPPrinterName]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                   DECIMAL (18) NOT NULL,
    [LUPUser]                             VARCHAR (50) NULL,
    [LUPDate]                             DATETIME     NULL,
    [CreateUser]                          VARCHAR (50) NULL,
    [CreateDate]                          DATETIME     NULL,
    CONSTRAINT [PK_PSPJoinPrinterNameApplicationUser] PRIMARY KEY CLUSTERED ([pkPSPJoinPrinterNameApplicationUser] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_PSPPrinterNameUniqueConstraint]
    ON [dbo].[PSPJoinPrinterNameApplicationUser]([fkPSPPrinterName] ASC);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[PSPJoinPrinterNameApplicationUser]([fkApplicationUser] ASC)
    INCLUDE([fkPSPPrinterName]);


GO
CREATE Trigger [dbo].[tr_PSPJoinPrinterNameApplicationUserAudit_d] On [dbo].[PSPJoinPrinterNameApplicationUser]
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
From PSPJoinPrinterNameApplicationUserAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPJoinPrinterNameApplicationUser] = d.[pkPSPJoinPrinterNameApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPJoinPrinterNameApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPJoinPrinterNameApplicationUser]
	,[fkPSPPrinterName]
	,[fkApplicationUser]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPJoinPrinterNameApplicationUser]
	,[fkPSPPrinterName]
	,[fkApplicationUser]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPJoinPrinterNameApplicationUserAudit_UI] On [dbo].[PSPJoinPrinterNameApplicationUser]
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

Update PSPJoinPrinterNameApplicationUser
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPJoinPrinterNameApplicationUser dbTable
	Inner Join Inserted i on dbtable.pkPSPJoinPrinterNameApplicationUser = i.pkPSPJoinPrinterNameApplicationUser
	Left Join Deleted d on d.pkPSPJoinPrinterNameApplicationUser = d.pkPSPJoinPrinterNameApplicationUser
	Where d.pkPSPJoinPrinterNameApplicationUser is null

Update PSPJoinPrinterNameApplicationUser
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPJoinPrinterNameApplicationUser dbTable
	Inner Join Deleted d on dbTable.pkPSPJoinPrinterNameApplicationUser = d.pkPSPJoinPrinterNameApplicationUser
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPJoinPrinterNameApplicationUserAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPJoinPrinterNameApplicationUser] = i.[pkPSPJoinPrinterNameApplicationUser]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPJoinPrinterNameApplicationUserAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPJoinPrinterNameApplicationUser]
	,[fkPSPPrinterName]
	,[fkApplicationUser]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPJoinPrinterNameApplicationUser]
	,[fkPSPPrinterName]
	,[fkApplicationUser]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table joins PSP virtual printers to Application Users.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'pkPSPJoinPrinterNameApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign ket to the PSP printer name table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'fkPSPPrinterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPJoinPrinterNameApplicationUser', @level2type = N'COLUMN', @level2name = N'CreateDate';

