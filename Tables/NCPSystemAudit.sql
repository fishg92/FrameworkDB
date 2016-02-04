CREATE TABLE [dbo].[NCPSystemAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkNCPSystem]    DECIMAL (18)  NOT NULL,
    [Class]          VARCHAR (50)  NULL,
    [Attribute]      VARCHAR (50)  NULL,
    [AttributeValue] VARCHAR (255) NULL,
    CONSTRAINT [PK_NCPSystemAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkNCPSystemAudit]
    ON [dbo].[NCPSystemAudit]([pkNCPSystem] ASC);

