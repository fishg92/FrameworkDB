CREATE TABLE [dbo].[FormAnnotationPositionAudit] (
    [pk]                       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME     NULL,
    [AuditEndDate]             DATETIME     NULL,
    [AuditUser]                VARCHAR (50) NULL,
    [AuditMachine]             VARCHAR (15) NULL,
    [AuditDeleted]             TINYINT      NULL,
    [pkFormAnnotationPosition] DECIMAL (18) NOT NULL,
    [fkFormAnnotation]         DECIMAL (18) NOT NULL,
    [x]                        INT          NOT NULL,
    [y]                        INT          NOT NULL,
    [Width]                    INT          NOT NULL,
    [Height]                   INT          NOT NULL,
    CONSTRAINT [PK_FormAnnotationPositionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAnnotationPositionAudit]
    ON [dbo].[FormAnnotationPositionAudit]([pkFormAnnotationPosition] ASC);

