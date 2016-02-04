CREATE TABLE [dbo].[PSPKeywordAudit] (
    [pk]                    DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME       NULL,
    [AuditEndDate]          DATETIME       NULL,
    [AuditUser]             VARCHAR (50)   NULL,
    [AuditMachine]          VARCHAR (15)   NULL,
    [AuditDeleted]          TINYINT        NULL,
    [pkPSPKeyword]          DECIMAL (18)   NOT NULL,
    [fkPSPPage]             DECIMAL (18)   NOT NULL,
    [fkPSPDocType]          DECIMAL (18)   NOT NULL,
    [KeywordName]           VARCHAR (255)  NULL,
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
    [IsRouteKeyword]        BIT            NULL,
    CONSTRAINT [PK_PSPKeywordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkPSPKeywordAudit]
    ON [dbo].[PSPKeywordAudit]([pkPSPKeyword] ASC);

