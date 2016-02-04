CREATE TABLE [dbo].[CPSmartFillKeywordMappingAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkCPSmartFillKeywordMapping] DECIMAL (18)  NOT NULL,
    [PeopleKeyword]               VARCHAR (100) NULL,
    [SmartFillAlias]              VARCHAR (100) NULL,
    CONSTRAINT [PK_CPSmartFillKeywordMappingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPSmartFillKeywordMappingAudit]
    ON [dbo].[CPSmartFillKeywordMappingAudit]([pkCPSmartFillKeywordMapping] ASC);

