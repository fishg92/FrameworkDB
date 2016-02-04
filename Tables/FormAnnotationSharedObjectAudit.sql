CREATE TABLE [dbo].[FormAnnotationSharedObjectAudit] (
    [pk]                           DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME        NULL,
    [AuditEndDate]                 DATETIME        NULL,
    [AuditUser]                    VARCHAR (50)    NULL,
    [AuditMachine]                 VARCHAR (15)    NULL,
    [AuditDeleted]                 TINYINT         NULL,
    [pkFormAnnotationSharedObject] DECIMAL (18)    NOT NULL,
    [ObjectName]                   VARCHAR (255)   NULL,
    [BinaryData]                   VARBINARY (MAX) NULL,
    [StringData]                   TEXT            NULL,
    [Active]                       BIT             NULL,
    CONSTRAINT [PK_FormAnnotationSharedObjectAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkFormAnnotationSharedObjectAudit]
    ON [dbo].[FormAnnotationSharedObjectAudit]([pkFormAnnotationSharedObject] ASC);

