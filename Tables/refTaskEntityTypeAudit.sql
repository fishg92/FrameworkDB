CREATE TABLE [dbo].[refTaskEntityTypeAudit] (
    [pk]                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME     NULL,
    [AuditEndDate]        DATETIME     NULL,
    [AuditUser]           VARCHAR (50) NULL,
    [AuditMachine]        VARCHAR (15) NULL,
    [AuditDeleted]        TINYINT      NULL,
    [pkrefTaskEntityType] DECIMAL (18) NOT NULL,
    [fkNCPApplication]    DECIMAL (18) NOT NULL,
    [ParentTable]         VARCHAR (50) NULL,
    [Description]         VARCHAR (50) NULL,
    [EntityJoinTable]     VARCHAR (50) NULL,
    CONSTRAINT [PK_refTaskEntityTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskEntityTypeAudit]
    ON [dbo].[refTaskEntityTypeAudit]([pkrefTaskEntityType] ASC);

