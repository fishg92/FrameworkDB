CREATE TABLE [dbo].[DocumentTypeFollowUpDateAudit] (
    [pk]                         DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME     NULL,
    [AuditEndDate]               DATETIME     NULL,
    [AuditUser]                  VARCHAR (50) NULL,
    [AuditMachine]               VARCHAR (15) NULL,
    [AuditDeleted]               TINYINT      NULL,
    [pkDocumentTypeFollowUpDate] DECIMAL (18) NOT NULL,
    [fkDocumentType]             VARCHAR (50) NULL,
    [FollowUpDays]               INT          NULL,
    [FollowUpWeeks]              INT          NULL,
    [FollowUpMonths]             INT          NULL,
    [FollowUpYears]              INT          NULL,
    CONSTRAINT [PK_DocumentTypeFollowUpDateAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDocumentTypeFollowUpDateAudit]
    ON [dbo].[DocumentTypeFollowUpDateAudit]([pkDocumentTypeFollowUpDate] ASC);

