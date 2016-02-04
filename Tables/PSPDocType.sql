CREATE TABLE [dbo].[PSPDocType] (
    [pkPSPDocType]          DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [DocName]               VARCHAR (255)   NOT NULL,
    [MatchString]           VARCHAR (255)   NOT NULL,
    [SendToOnBase]          BIT             NOT NULL,
    [DMSDocType]            VARCHAR (50)    NOT NULL,
    [DMSDocTypeName]        VARCHAR (500)   NOT NULL,
    [Snapshot]              VARBINARY (MAX) NOT NULL,
    [X1]                    DECIMAL (9, 3)  NOT NULL,
    [X2]                    DECIMAL (9, 3)  NOT NULL,
    [Y1]                    DECIMAL (9, 3)  NOT NULL,
    [Y2]                    DECIMAL (9, 3)  NOT NULL,
    [AdjustedX1]            DECIMAL (9, 3)  NOT NULL,
    [AdjustedX2]            DECIMAL (9, 3)  NOT NULL,
    [AdjustedY1]            DECIMAL (9, 3)  NOT NULL,
    [AdjustedY2]            DECIMAL (9, 3)  NOT NULL,
    [X1Inches]              DECIMAL (9, 3)  NOT NULL,
    [Y1Inches]              DECIMAL (9, 3)  NOT NULL,
    [X2Inches]              DECIMAL (9, 3)  NOT NULL,
    [Y2Inches]              DECIMAL (9, 3)  NOT NULL,
    [RemoveStartCharacters] INT             NOT NULL,
    [RemoveEndCharacters]   INT             NOT NULL,
    [IncludeAsKeyword]      BIT             NOT NULL,
    [Deleted]               BIT             NOT NULL,
    [LUPUser]               VARCHAR (50)    NULL,
    [LUPDate]               DATETIME        NULL,
    [CreateUser]            VARCHAR (50)    NULL,
    [CreateDate]            DATETIME        NULL,
    [BarcodeDocType]        VARCHAR (50)    NULL,
    [PrintBarcode]          SMALLINT        NULL,
    [RouteDocument]         SMALLINT        NULL,
    CONSTRAINT [PK_PSPDocType] PRIMARY KEY CLUSTERED ([pkPSPDocType] ASC)
);


GO
CREATE Trigger [dbo].[tr_PSPDocTypeAudit_d] On [dbo].[PSPDocType]
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
From PSPDocTypeAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPDocType] = d.[pkPSPDocType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocType]
	,[DocName]
	,[MatchString]
	,[SendToOnBase]
	,[DMSDocType]
	,[DMSDocTypeName]
	,[Snapshot]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[X1Inches]
	,[Y1Inches]
	,[X2Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IncludeAsKeyword]
	,[Deleted]
	,[BarcodeDocType]
	,[PrintBarcode]
	,[RouteDocument]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPDocType]
	,[DocName]
	,[MatchString]
	,[SendToOnBase]
	,[DMSDocType]
	,[DMSDocTypeName]
	,[Snapshot]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[X1Inches]
	,[Y1Inches]
	,[X2Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IncludeAsKeyword]
	,[Deleted]
	,[BarcodeDocType]
	,[PrintBarcode]
	,[RouteDocument]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPDocTypeAudit_UI] On [dbo].[PSPDocType]
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

Update PSPDocType
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocType dbTable
	Inner Join Inserted i on dbtable.pkPSPDocType = i.pkPSPDocType
	Left Join Deleted d on d.pkPSPDocType = d.pkPSPDocType
	Where d.pkPSPDocType is null

Update PSPDocType
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPDocType dbTable
	Inner Join Deleted d on dbTable.pkPSPDocType = d.pkPSPDocType
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPDocTypeAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPDocType] = i.[pkPSPDocType]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPDocTypeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPDocType]
	,[DocName]
	,[MatchString]
	,[SendToOnBase]
	,[DMSDocType]
	,[DMSDocTypeName]
	,[Snapshot]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[X1Inches]
	,[Y1Inches]
	,[X2Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IncludeAsKeyword]
	,[Deleted]
	,[BarcodeDocType]
	,[PrintBarcode]
	,[RouteDocument]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPDocType]
	,[DocName]
	,[MatchString]
	,[SendToOnBase]
	,[DMSDocType]
	,[DMSDocTypeName]
	,0
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[X1Inches]
	,[Y1Inches]
	,[X2Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IncludeAsKeyword]
	,[Deleted]
	,[BarcodeDocType]
	,[PrintBarcode]
	,[RouteDocument]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defining parameters for document types processed by PSP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'pkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human-readable description of the document type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'DocName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This is the string that should be matched on the printed object to indicate that the object is of this doc type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'MatchString';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should this document type be added to OnBase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'SendToOnBase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the DMS DocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'DMSDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human readable DMS DocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'DMSDocTypeName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A picture of what these documents look like', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Snapshot';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'X1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'X2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Y1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Y2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'AdjustedX1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'AdjustedX2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'AdjustedY1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'AdjustedY2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'X1Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Y1Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'X2Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Defines the rectangle to search for the MatchString', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Y2Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to apply a mask to keywords found in the document.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'RemoveStartCharacters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to apply a mask to keywords found in the document.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'RemoveEndCharacters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates that the matched string should be included as a keyword', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'IncludeAsKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Virtual delete of this document template', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'Deleted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Barcoded type to use iwht this document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'BarcodeDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should a barcode be added to this document when printed or not, or should it be decided on print?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'PrintBarcode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the document be routed to a task or not, or should the user be prompted to do this?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPDocType', @level2type = N'COLUMN', @level2name = N'RouteDocument';

