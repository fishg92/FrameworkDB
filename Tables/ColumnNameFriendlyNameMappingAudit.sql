CREATE TABLE [dbo].[ColumnNameFriendlyNameMappingAudit] (
    [pk]                              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME      NULL,
    [AuditEndDate]                    DATETIME      NULL,
    [AuditUser]                       VARCHAR (50)  NULL,
    [AuditMachine]                    VARCHAR (15)  NULL,
    [AuditDeleted]                    TINYINT       NULL,
    [pkColumnNameFriendlyNameMapping] DECIMAL (18)  NOT NULL,
    [TableName]                       VARCHAR (200) NULL,
    [ColumnName]                      VARCHAR (200) NULL,
    [FriendlyName]                    VARCHAR (200) NULL,
    CONSTRAINT [PK_ColumnNameFriendlyNameMappingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkColumnNameFriendlyNameMappingAudit]
    ON [dbo].[ColumnNameFriendlyNameMappingAudit]([pkColumnNameFriendlyNameMapping] ASC);

