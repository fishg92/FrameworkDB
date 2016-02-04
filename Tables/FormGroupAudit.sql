CREATE TABLE [dbo].[FormGroupAudit] (
    [pk]              DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME     NULL,
    [AuditEndDate]    DATETIME     NULL,
    [AuditUser]       VARCHAR (50) NULL,
    [AuditMachine]    VARCHAR (15) NULL,
    [AuditDeleted]    TINYINT      NULL,
    [pkFormGroup]     DECIMAL (18) NOT NULL,
    [fkFormGroupName] DECIMAL (18) NOT NULL,
    [Status]          TINYINT      NOT NULL,
    CONSTRAINT [PK_FormGroupAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormGroupAudit]
    ON [dbo].[FormGroupAudit]([pkFormGroup] ASC);

