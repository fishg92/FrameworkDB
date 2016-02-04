CREATE TABLE [dbo].[PSPKeyword] (
    [pkPSPKeyword]          DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkPSPPage]             DECIMAL (18)   NOT NULL,
    [fkPSPDocType]          DECIMAL (18)   NOT NULL,
    [KeywordName]           VARCHAR (255)  NOT NULL,
    [X1]                    DECIMAL (9, 3) NOT NULL,
    [X2]                    DECIMAL (9, 3) NOT NULL,
    [Y1]                    DECIMAL (9, 3) NOT NULL,
    [Y2]                    DECIMAL (9, 3) NOT NULL,
    [AdjustedX1]            DECIMAL (9, 3) NOT NULL,
    [AdjustedX2]            DECIMAL (9, 3) NOT NULL,
    [AdjustedY1]            DECIMAL (9, 3) NOT NULL,
    [AdjustedY2]            DECIMAL (9, 3) NOT NULL,
    [KeywordMask]           VARCHAR (50)   NULL,
    [X1Inches]              DECIMAL (9, 3) NOT NULL,
    [X2Inches]              DECIMAL (9, 3) NOT NULL,
    [Y1Inches]              DECIMAL (9, 3) NOT NULL,
    [Y2Inches]              DECIMAL (9, 3) NOT NULL,
    [RemoveStartCharacters] INT            NOT NULL,
    [RemoveEndCharacters]   INT            NOT NULL,
    [LUPUser]               VARCHAR (50)   NULL,
    [LUPDate]               DATETIME       NULL,
    [CreateUser]            VARCHAR (50)   NULL,
    [CreateDate]            DATETIME       NULL,
    [IsRouteKeyword]        BIT            NULL,
    CONSTRAINT [PK_PSPKeyword] PRIMARY KEY CLUSTERED ([pkPSPKeyword] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[PSPKeyword]([fkPSPDocType] ASC);


GO
CREATE NONCLUSTERED INDEX [fkPSPPage]
    ON [dbo].[PSPKeyword]([fkPSPPage] ASC);


GO
CREATE Trigger [dbo].[tr_PSPKeywordAudit_d] On [dbo].[PSPKeyword]
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
From PSPKeywordAudit dbTable
Inner Join deleted d ON dbTable.[pkPSPKeyword] = d.[pkPSPKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPKeyword]
	,[fkPSPPage]
	,[fkPSPDocType]
	,[KeywordName]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[KeywordMask]
	,[X1Inches]
	,[X2Inches]
	,[Y1Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IsRouteKeyword]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkPSPKeyword]
	,[fkPSPPage]
	,[fkPSPDocType]
	,[KeywordName]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[KeywordMask]
	,[X1Inches]
	,[X2Inches]
	,[Y1Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IsRouteKeyword]
From  Deleted
GO
CREATE Trigger [dbo].[tr_PSPKeywordAudit_UI] On [dbo].[PSPKeyword]
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

Update PSPKeyword
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPKeyword dbTable
	Inner Join Inserted i on dbtable.pkPSPKeyword = i.pkPSPKeyword
	Left Join Deleted d on d.pkPSPKeyword = d.pkPSPKeyword
	Where d.pkPSPKeyword is null

Update PSPKeyword
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From PSPKeyword dbTable
	Inner Join Deleted d on dbTable.pkPSPKeyword = d.pkPSPKeyword
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From PSPKeywordAudit dbTable
Inner Join inserted i ON dbTable.[pkPSPKeyword] = i.[pkPSPKeyword]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into PSPKeywordAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkPSPKeyword]
	,[fkPSPPage]
	,[fkPSPDocType]
	,[KeywordName]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[KeywordMask]
	,[X1Inches]
	,[X2Inches]
	,[Y1Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IsRouteKeyword]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkPSPKeyword]
	,[fkPSPPage]
	,[fkPSPDocType]
	,[KeywordName]
	,[X1]
	,[X2]
	,[Y1]
	,[Y2]
	,[AdjustedX1]
	,[AdjustedX2]
	,[AdjustedY1]
	,[AdjustedY2]
	,[KeywordMask]
	,[X1Inches]
	,[X2Inches]
	,[Y1Inches]
	,[Y2Inches]
	,[RemoveStartCharacters]
	,[RemoveEndCharacters]
	,[IsRouteKeyword]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Input mask for the keyword (for example, SSN might be ###-##-####)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'KeywordMask';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'X1Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'X2Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'Y1Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'Y2Inches';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Characters to remove at the start of the keyword, used in conjunction with KeywordMask', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'RemoveStartCharacters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Characters to remove at the end of the keyword, used in conjunction with KeywordMask', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'RemoveEndCharacters';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is a keyword used for routing the document', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'IsRouteKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table manages the keywords on a printed job.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'pkPSPKeyword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPPage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'fkPSPPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPDocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The name of the keyword', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'KeywordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'X1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'X2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'Y1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'Y2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'AdjustedX1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'AdjustedX2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'AdjustedY1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Used to position the keyword on the page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPKeyword', @level2type = N'COLUMN', @level2name = N'AdjustedY2';

