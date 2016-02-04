CREATE TABLE [dbo].[FormPrefillPriorityAnnotationAudit] (
    [pk]                              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                  DATETIME      NULL,
    [AuditEndDate]                    DATETIME      NULL,
    [AuditUser]                       VARCHAR (50)  NULL,
    [AuditMachine]                    VARCHAR (15)  NULL,
    [AuditDeleted]                    TINYINT       NULL,
    [pkFormPrefillPriorityAnnotation] DECIMAL (18)  NOT NULL,
    [KeywordName]                     VARCHAR (200) NULL,
    [Position]                        INT           NOT NULL,
    CONSTRAINT [PK_FormPrefillPriorityAnnotationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormPrefillPriorityAnnotationAudit]
    ON [dbo].[FormPrefillPriorityAnnotationAudit]([pkFormPrefillPriorityAnnotation] ASC);

