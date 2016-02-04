CREATE TABLE [dbo].[FormAnnotationAudit] (
    [pk]                           DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME        NULL,
    [AuditEndDate]                 DATETIME        NULL,
    [AuditUser]                    VARCHAR (50)    NULL,
    [AuditMachine]                 VARCHAR (15)    NULL,
    [AuditDeleted]                 TINYINT         NULL,
    [pkFormAnnotation]             DECIMAL (18)    NOT NULL,
    [fkForm]                       DECIMAL (18)    NOT NULL,
    [AnnotationName]               VARCHAR (100)   NULL,
    [AnnotationFormOrder]          INT             NOT NULL,
    [Page]                         INT             NOT NULL,
    [Deleted]                      TINYINT         NOT NULL,
    [Mask]                         VARCHAR (50)    NULL,
    [Required]                     BIT             NOT NULL,
    [fkFormComboName]              DECIMAL (18)    NOT NULL,
    [Tag]                          VARCHAR (50)    NULL,
    [fkrefAnnotationType]          DECIMAL (18)    NOT NULL,
    [DefaultText]                  VARCHAR (2000)  NULL,
    [FontName]                     VARCHAR (255)   NULL,
    [FontSize]                     FLOAT (53)      NULL,
    [FontStyle]                    INT             NULL,
    [FontColor]                    VARCHAR (100)   NULL,
    [SingleUse]                    BIT             NULL,
    [fkFormAnnotationSharedObject] DECIMAL (18)    NULL,
    [ReadOnly]                     BIT             NULL,
    [Formula]                      VARCHAR (500)   NULL,
    [DefaultValue]                 DECIMAL (18, 5) NULL,
    [fkAutofillViewForQuickName]   DECIMAL (18)    NULL,
    [NewLineAfter]                 BIT             NULL,
    CONSTRAINT [PK_FormAnnotationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAnnotationAudit]
    ON [dbo].[FormAnnotationAudit]([pkFormAnnotation] ASC);

