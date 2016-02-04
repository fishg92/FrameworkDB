CREATE TABLE [dbo].[FormConversionAudit] (
    [pk]               DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]   DATETIME        NULL,
    [AuditEndDate]     DATETIME        NULL,
    [AuditUser]        VARCHAR (50)    NULL,
    [AuditMachine]     VARCHAR (15)    NULL,
    [AuditDeleted]     TINYINT         NULL,
    [pkFormConversion] DECIMAL (18)    NOT NULL,
    [Username]         VARCHAR (255)   NULL,
    [MachineName]      VARCHAR (255)   NULL,
    [PCLFile]          VARBINARY (MAX) NOT NULL,
    CONSTRAINT [PK_FormConversionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormConversionAudit]
    ON [dbo].[FormConversionAudit]([pkFormConversion] ASC);

