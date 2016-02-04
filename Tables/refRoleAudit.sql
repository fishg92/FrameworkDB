CREATE TABLE [dbo].[refRoleAudit] (
    [pk]                  DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME       NULL,
    [AuditEndDate]        DATETIME       NULL,
    [AuditUser]           VARCHAR (50)   NULL,
    [AuditMachine]        VARCHAR (15)   NULL,
    [AuditDeleted]        TINYINT        NULL,
    [pkrefRole]           DECIMAL (18)   NOT NULL,
    [Description]         VARCHAR (255)  NULL,
    [DetailedDescription] VARCHAR (2500) NULL,
    [fkrefRoleType]       DECIMAL (18)   NULL,
    [LDAPGroupMatch]      BIT            NULL,
    [LDAPDomainName]      VARCHAR (100)  NULL,
    CONSTRAINT [PK_refRoleAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefRoleAudit]
    ON [dbo].[refRoleAudit]([pkrefRole] ASC);

