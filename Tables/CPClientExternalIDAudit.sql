CREATE TABLE [dbo].[CPClientExternalIDAudit] (
    [pk]                   DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME     NULL,
    [AuditEndDate]         DATETIME     NULL,
    [AuditUser]            VARCHAR (50) NULL,
    [AuditMachine]         VARCHAR (15) NULL,
    [AuditDeleted]         TINYINT      NULL,
    [pkCPClientExternalID] DECIMAL (18) NOT NULL,
    [fkCPClient]           DECIMAL (18) NOT NULL,
    [ExternalSystemName]   VARCHAR (50) NULL,
    [ExternalSystemID]     VARCHAR (50) NULL,
    CONSTRAINT [PK_CPClientExternalIDAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientExternalIDAudit]
    ON [dbo].[CPClientExternalIDAudit]([pkCPClientExternalID] ASC);

