CREATE TABLE [dbo].[PSPDocTypeAudit] (
    [pk]                    DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME        NULL,
    [AuditEndDate]          DATETIME        NULL,
    [AuditUser]             VARCHAR (50)    NULL,
    [AuditMachine]          VARCHAR (15)    NULL,
    [AuditDeleted]          TINYINT         NULL,
    [pkPSPDocType]          DECIMAL (18)    NOT NULL,
    [DocName]               VARCHAR (255)   NULL,
    [MatchString]           VARCHAR (255)   NULL,
    [SendToOnBase]          BIT             NOT NULL,
    [DMSDocType]            VARCHAR (50)    NOT NULL,
    [DMSDocTypeName]        VARCHAR (500)   NULL,
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
    [BarcodeDocType]        VARCHAR (50)    NULL,
    [PrintBarcode]          SMALLINT        NULL,
    [RouteDocument]         SMALLINT        NULL,
    CONSTRAINT [PK_PSPDocTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPDocTypeAudit]
    ON [dbo].[PSPDocTypeAudit]([pkPSPDocType] ASC);

