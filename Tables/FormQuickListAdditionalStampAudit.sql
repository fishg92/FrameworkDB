CREATE TABLE [dbo].[FormQuickListAdditionalStampAudit] (
    [pk]                             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                 DATETIME      NULL,
    [AuditEndDate]                   DATETIME      NULL,
    [AuditUser]                      VARCHAR (50)  NULL,
    [AuditMachine]                   VARCHAR (15)  NULL,
    [AuditDeleted]                   TINYINT       NULL,
    [pkFormQuickListAdditionalStamp] DECIMAL (18)  NOT NULL,
    [fkFormQuickListFormName]        DECIMAL (18)  NOT NULL,
    [Page]                           INT           NOT NULL,
    [X]                              INT           NOT NULL,
    [Y]                              INT           NOT NULL,
    [Width]                          INT           NOT NULL,
    [Height]                         INT           NOT NULL,
    [Bitmap]                         IMAGE         NULL,
    [fkrefAnnotationType]            DECIMAL (18)  NOT NULL,
    [AdditionalData]                 VARCHAR (MAX) NULL,
    CONSTRAINT [PK_FormQuickListAdditionalStampAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormQuickListAdditionalStampAudit]
    ON [dbo].[FormQuickListAdditionalStampAudit]([pkFormQuickListAdditionalStamp] ASC);

