CREATE TABLE [dbo].[ExternalTaskMetaDataAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkExternalTaskMetaData] DECIMAL (18) NOT NULL,
    [fkExternalTask]         VARCHAR (50) NULL,
    [fkrefTaskPriority]      DECIMAL (18) NOT NULL,
    [fkrefTaskStatus]        DECIMAL (18) NOT NULL,
    [fkrefTaskOrigin]        DECIMAL (18) NOT NULL,
    [SourceModuleID]         INT          NULL,
    CONSTRAINT [PK_ExternalTaskMetaDataAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkExternalTaskMetaDataAudit]
    ON [dbo].[ExternalTaskMetaDataAudit]([pkExternalTaskMetaData] ASC);

