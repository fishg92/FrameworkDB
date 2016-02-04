CREATE TABLE [dbo].[FormJoinFormAnnotationFormAnnotationGroupAudit] (
    [pk]                                          DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                              DATETIME     NULL,
    [AuditEndDate]                                DATETIME     NULL,
    [AuditUser]                                   VARCHAR (50) NULL,
    [AuditMachine]                                VARCHAR (15) NULL,
    [AuditDeleted]                                TINYINT      NULL,
    [pkFormJoinFormAnnotationFormAnnotationGroup] DECIMAL (18) NOT NULL,
    [fkFormAnnotation]                            DECIMAL (18) NOT NULL,
    [fkFormAnnotationGroup]                       DECIMAL (18) NOT NULL,
    [fkForm]                                      DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_FormJoinFormAnnotationFormAnnotationGroupAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormJoinFormAnnotationFormAnnotationGroupAudit]
    ON [dbo].[FormJoinFormAnnotationFormAnnotationGroupAudit]([pkFormJoinFormAnnotationFormAnnotationGroup] ASC);

