CREATE TABLE [dbo].[ProgramTypeClientCustomAttributeColumnMappingAudit] (
    [pk]                                              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                                  DATETIME      NULL,
    [AuditEndDate]                                    DATETIME      NULL,
    [AuditUser]                                       VARCHAR (50)  NULL,
    [AuditMachine]                                    VARCHAR (15)  NULL,
    [AuditDeleted]                                    TINYINT       NULL,
    [pkProgramTypeClientCustomAttributeColumnMapping] DECIMAL (18)  NOT NULL,
    [fkProgramType]                                   DECIMAL (18)  NOT NULL,
    [ClientCustomAttributeColumn]                     VARCHAR (200) NULL,
    CONSTRAINT [PK_ProgramTypeClientCustomAttributeColumnMappingAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProgramTypeClientCustomAttributeColumnMappingAudit]
    ON [dbo].[ProgramTypeClientCustomAttributeColumnMappingAudit]([pkProgramTypeClientCustomAttributeColumnMapping] ASC);

