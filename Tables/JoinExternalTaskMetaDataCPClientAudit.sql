CREATE TABLE [dbo].[JoinExternalTaskMetaDataCPClientAudit] (
    [pk]                                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME     NULL,
    [AuditEndDate]                       DATETIME     NULL,
    [AuditUser]                          VARCHAR (50) NULL,
    [AuditMachine]                       VARCHAR (15) NULL,
    [AuditDeleted]                       TINYINT      NULL,
    [pkJoinExternalTaskMetaDataCPClient] DECIMAL (18) NOT NULL,
    [fkExternalTaskMetaData]             DECIMAL (18) NOT NULL,
    [fkCPClient]                         DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskMetaDataCPClientAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinExternalTaskMetaDataCPClientAudit]
    ON [dbo].[JoinExternalTaskMetaDataCPClientAudit]([pkJoinExternalTaskMetaDataCPClient] ASC);

