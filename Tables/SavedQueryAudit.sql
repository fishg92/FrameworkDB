CREATE TABLE [dbo].[SavedQueryAudit] (
    [pk]                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME      NULL,
    [AuditEndDate]      DATETIME      NULL,
    [AuditUser]         VARCHAR (50)  NULL,
    [AuditMachine]      VARCHAR (15)  NULL,
    [AuditDeleted]      TINYINT       NULL,
    [pkSavedQuery]      DECIMAL (18)  NOT NULL,
    [fkApplicationUser] DECIMAL (18)  NOT NULL,
    [QueryName]         VARCHAR (255) NULL,
    [ExpirationDate]    SMALLDATETIME NULL,
    [Notes]             VARCHAR (500) NULL,
    CONSTRAINT [PK_SavedQueryAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkSavedQueryAudit]
    ON [dbo].[SavedQueryAudit]([pkSavedQuery] ASC);

