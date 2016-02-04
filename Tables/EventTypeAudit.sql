CREATE TABLE [dbo].[EventTypeAudit] (
    [pk]                         DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME      NULL,
    [AuditEndDate]               DATETIME      NULL,
    [AuditUser]                  VARCHAR (50)  NULL,
    [AuditMachine]               VARCHAR (15)  NULL,
    [AuditDeleted]               TINYINT       NULL,
    [pkEventType]                DECIMAL (18)  NULL,
    [Description]                VARCHAR (250) NULL,
    [fkTransferType]             DECIMAL (18)  NULL,
    [fkProgramType]              DECIMAL (18)  NULL,
    [fkSmartView]                DECIMAL (18)  NULL,
    [IncludeAllCaseworkersCases] BIT           NULL,
    [IncludeFavoriteCases]       BIT           NULL,
    [IncludeCaseworkerCases]     BIT           NULL,
    CONSTRAINT [PK_EventTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkEventTypeAudit]
    ON [dbo].[EventTypeAudit]([pkEventType] ASC);

