CREATE TABLE [dbo].[JoinEventTypeDocumentTypeAudioAudit] (
    [pk]                               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME     NULL,
    [AuditEndDate]                     DATETIME     NULL,
    [AuditUser]                        VARCHAR (50) NULL,
    [AuditMachine]                     VARCHAR (15) NULL,
    [AuditDeleted]                     TINYINT      NULL,
    [pkJoinEventTypeDocumentTypeAudio] DECIMAL (18) NOT NULL,
    [fkEventType]                      DECIMAL (18) NULL,
    [fkDocumentType]                   VARCHAR (50) NULL,
    CONSTRAINT [PK_JoinEventTypeDocumentTypeAudioAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinEventTypeDocumentTypeAudioAudit]
    ON [dbo].[JoinEventTypeDocumentTypeAudioAudit]([pkJoinEventTypeDocumentTypeAudio] ASC);

