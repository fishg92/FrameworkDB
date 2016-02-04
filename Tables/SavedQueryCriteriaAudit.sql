CREATE TABLE [dbo].[SavedQueryCriteriaAudit] (
    [pk]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME      NULL,
    [AuditEndDate]         DATETIME      NULL,
    [AuditUser]            VARCHAR (50)  NULL,
    [AuditMachine]         VARCHAR (15)  NULL,
    [AuditDeleted]         TINYINT       NULL,
    [pkSavedQueryCriteria] DECIMAL (18)  NOT NULL,
    [fkSavedQuery]         DECIMAL (18)  NOT NULL,
    [fkKeyword]            VARCHAR (50)  NULL,
    [KeywordValue]         VARCHAR (50)  NULL,
    [KeywordStartDate]     SMALLDATETIME NULL,
    [KeywordEndDate]       SMALLDATETIME NULL,
    CONSTRAINT [PK_SavedQueryCriteriaAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkSavedQueryCriteriaAudit]
    ON [dbo].[SavedQueryCriteriaAudit]([pkSavedQueryCriteria] ASC);

