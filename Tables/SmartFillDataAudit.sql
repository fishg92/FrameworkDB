CREATE TABLE [dbo].[SmartFillDataAudit] (
    [pk]                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME     NULL,
    [AuditEndDate]      DATETIME     NULL,
    [AuditUser]         VARCHAR (50) NULL,
    [AuditMachine]      VARCHAR (15) NULL,
    [AuditDeleted]      TINYINT      NULL,
    [pkSmartFillData]   DECIMAL (18) NOT NULL,
    [PeopleID]          VARCHAR (50) NULL,
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_SmartFillDataAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkSmartFillDataAudit]
    ON [dbo].[SmartFillDataAudit]([pkSmartFillData] ASC);

