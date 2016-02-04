CREATE TABLE [dbo].[FormGroupNameAudit] (
    [pk]              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME      NULL,
    [AuditEndDate]    DATETIME      NULL,
    [AuditUser]       VARCHAR (50)  NULL,
    [AuditMachine]    VARCHAR (15)  NULL,
    [AuditDeleted]    TINYINT       NULL,
    [pkFormGroupName] DECIMAL (18)  NOT NULL,
    [Name]            VARCHAR (255) NULL,
    CONSTRAINT [PK_FormGroupNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormGroupNameAudit]
    ON [dbo].[FormGroupNameAudit]([pkFormGroupName] ASC);

