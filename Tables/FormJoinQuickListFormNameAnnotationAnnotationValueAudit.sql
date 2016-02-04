CREATE TABLE [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValueAudit] (
    [pk]                                                   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                       DATETIME      NULL,
    [AuditEndDate]                                         DATETIME      NULL,
    [AuditUser]                                            VARCHAR (50)  NULL,
    [AuditMachine]                                         VARCHAR (15)  NULL,
    [AuditDeleted]                                         TINYINT       NULL,
    [pkFormJoinQuickListFormNameAnnotationAnnotationValue] DECIMAL (18)  NOT NULL,
    [fkQuickListFormName]                                  DECIMAL (18)  NOT NULL,
    [fkFormAnnotation]                                     DECIMAL (18)  NOT NULL,
    [fkAnnotationValueSmall]                               DECIMAL (18)  NULL,
    [fkAnnotationValueMedium]                              DECIMAL (18)  NULL,
    [fkAnnotationValueLarge]                               DECIMAL (18)  NULL,
    [fkAnnotationValueHuge]                                DECIMAL (18)  NULL,
    [AnnotationValue]                                      VARCHAR (MAX) NULL,
    CONSTRAINT [PK_FormJoinQuickListFormNameAnnotationAnnotationValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinQuickListFormNameAnnotationAnnotationValueAudit]
    ON [dbo].[FormJoinQuickListFormNameAnnotationAnnotationValueAudit]([pkFormJoinQuickListFormNameAnnotationAnnotationValue] ASC);

