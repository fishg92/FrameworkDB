CREATE TABLE [dbo].[FormAnnotationGroupAudit] (
    [pk]                     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME      NULL,
    [AuditEndDate]           DATETIME      NULL,
    [AuditUser]              VARCHAR (50)  NULL,
    [AuditMachine]           VARCHAR (15)  NULL,
    [AuditDeleted]           TINYINT       NULL,
    [pkFormAnnotationGroup]  DECIMAL (18)  NOT NULL,
    [Name]                   VARCHAR (50)  NULL,
    [Description]            VARCHAR (250) NULL,
    [Type]                   INT           NOT NULL,
    [fkAutofillDataSource]   DECIMAL (18)  NULL,
    [UseAutofillForIndexing] BIT           NULL,
    CONSTRAINT [PK_FormAnnotationGroupAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAnnotationGroupAudit]
    ON [dbo].[FormAnnotationGroupAudit]([pkFormAnnotationGroup] ASC);

