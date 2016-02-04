CREATE TABLE [dbo].[JoinExternalTaskMetaDataCPClientCaseAudit] (
    [pk]                                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                         DATETIME     NULL,
    [AuditEndDate]                           DATETIME     NULL,
    [AuditUser]                              VARCHAR (50) NULL,
    [AuditMachine]                           VARCHAR (15) NULL,
    [AuditDeleted]                           TINYINT      NULL,
    [pkJoinExternalTaskMetaDataCPClientCase] DECIMAL (18) NOT NULL,
    [fkExternalTaskMetaData]                 DECIMAL (18) NOT NULL,
    [fkCPClientCase]                         DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinExternalTaskMetaDataCPClientCaseAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinExternalTaskMetaDataCPClientCaseAudit]
    ON [dbo].[JoinExternalTaskMetaDataCPClientCaseAudit]([pkJoinExternalTaskMetaDataCPClientCase] ASC);

