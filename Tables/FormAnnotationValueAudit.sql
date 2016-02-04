CREATE TABLE [dbo].[FormAnnotationValueAudit] (
    [pk]                          DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME       NULL,
    [AuditEndDate]                DATETIME       NULL,
    [AuditUser]                   VARCHAR (50)   NULL,
    [AuditMachine]                VARCHAR (15)   NULL,
    [AuditDeleted]                TINYINT        NULL,
    [pkFormAnnotationValue]       DECIMAL (18)   NOT NULL,
    [fkFormRendition]             DECIMAL (18)   NOT NULL,
    [fkFormAnnotation]            DECIMAL (18)   NOT NULL,
    [fkFormAnnotationValueSmall]  DECIMAL (18)   NULL,
    [fkFormAnnotationValueMedium] DECIMAL (18)   NULL,
    [fkFormAnnotationValueLarge]  DECIMAL (18)   NULL,
    [fkFormAnnotationValueHuge]   DECIMAL (18)   NULL,
    [AnnotationValue]             VARCHAR (5000) NULL,
    CONSTRAINT [PK_FormAnnotationValueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAnnotationValueAudit]
    ON [dbo].[FormAnnotationValueAudit]([pkFormAnnotationValue] ASC);

