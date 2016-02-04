CREATE TABLE [dbo].[BackfileImportAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkBackfileImport]    DECIMAL (18)  NOT NULL,
    [SourceFilename]      VARCHAR (500) NULL,
    [DestinationFilename] VARCHAR (500) NULL,
    [SourceID]            SMALLINT      NULL,
    [BOXID]               VARCHAR (100) NULL,
    [Docket]              VARCHAR (100) NULL,
    [CaseUPI]             VARCHAR (20)  NULL,
    [CaseSuffix]          CHAR (1)      NULL,
    [SSN]                 VARCHAR (9)   NULL,
    [Category]            VARCHAR (50)  NULL,
    [DocumentType]        VARCHAR (100) NULL,
    [DocumentDate]        DATETIME      NULL,
    [NorthwoodsNumber]    VARCHAR (50)  NULL,
    [Message]             VARCHAR (255) NULL,
    [Success]             BIT           NULL,
    CONSTRAINT [PK_BackfileImportAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkBackfileImportAudit]
    ON [dbo].[BackfileImportAudit]([pkBackfileImport] ASC);

