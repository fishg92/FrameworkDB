CREATE TABLE [dbo].[JoinEventTypeDocumentTypeCaptureAudit] (
    [pk]                                 DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                     DATETIME     NULL,
    [AuditEndDate]                       DATETIME     NULL,
    [AuditUser]                          VARCHAR (50) NULL,
    [AuditMachine]                       VARCHAR (15) NULL,
    [AuditDeleted]                       TINYINT      NULL,
    [pkJoinEventTypeDocumentTypeCapture] DECIMAL (18) NOT NULL,
    [fkEventType]                        DECIMAL (18) NULL,
    [fkDocumentType]                     VARCHAR (50) NULL,
    [SystemGeneratedCaption]             BIT          CONSTRAINT [DF__JoinEvent__Syste__724A16B9] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinEventTypeDocumentTypeCaptureAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinEventTypeDocumentTypeCaptureAudit]
    ON [dbo].[JoinEventTypeDocumentTypeCaptureAudit]([pkJoinEventTypeDocumentTypeCapture] ASC);

