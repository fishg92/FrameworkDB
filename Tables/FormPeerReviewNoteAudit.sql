CREATE TABLE [dbo].[FormPeerReviewNoteAudit] (
    [pk]                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]       DATETIME      NULL,
    [AuditEndDate]         DATETIME      NULL,
    [AuditUser]            VARCHAR (50)  NULL,
    [AuditMachine]         VARCHAR (15)  NULL,
    [AuditDeleted]         TINYINT       NULL,
    [pkFormPeerReviewNote] DECIMAL (18)  NOT NULL,
    [fkQuickListFormName]  DECIMAL (18)  NOT NULL,
    [Note]                 VARCHAR (255) NULL,
    [PageNumber]           INT           NOT NULL,
    [X]                    INT           NOT NULL,
    [Y]                    INT           NOT NULL,
    CONSTRAINT [PK_FormPeerReviewNoteAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormPeerReviewNoteAudit]
    ON [dbo].[FormPeerReviewNoteAudit]([pkFormPeerReviewNote] ASC);

