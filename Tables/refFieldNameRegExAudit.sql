CREATE TABLE [dbo].[refFieldNameRegExAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkrefFieldNameRegEx] DECIMAL (18)  NOT NULL,
    [regExValues]         VARCHAR (150) NULL,
    [regFieldName]        VARCHAR (250) NULL,
    [FriendlyName]        VARCHAR (250) NULL,
    CONSTRAINT [PK_refFieldNameRegExAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefFieldNameRegExAudit]
    ON [dbo].[refFieldNameRegExAudit]([pkrefFieldNameRegEx] ASC);

