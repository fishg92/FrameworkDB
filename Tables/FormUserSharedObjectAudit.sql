CREATE TABLE [dbo].[FormUserSharedObjectAudit] (
    [pk]                           DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME     NULL,
    [AuditEndDate]                 DATETIME     NULL,
    [AuditUser]                    VARCHAR (50) NULL,
    [AuditMachine]                 VARCHAR (15) NULL,
    [AuditDeleted]                 TINYINT      NULL,
    [pkFormUserSharedObject]       DECIMAL (18) NOT NULL,
    [fkFrameworkUserID]            DECIMAL (18) NOT NULL,
    [fkFormAnnotationSharedObject] DECIMAL (18) NOT NULL,
    [Value]                        TEXT         NOT NULL,
    CONSTRAINT [PK_FormUserSharedObjectAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormUserSharedObjectAudit]
    ON [dbo].[FormUserSharedObjectAudit]([pkFormUserSharedObject] ASC);

