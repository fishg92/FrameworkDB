CREATE TABLE [dbo].[ProgramTypeAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkProgramType]  DECIMAL (18) NOT NULL,
    [ProgramType]    VARCHAR (50) NULL,
    [ExternalName]   VARCHAR (50) NULL,
    CONSTRAINT [PK_ProgramTypeAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkProgramTypeAudit]
    ON [dbo].[ProgramTypeAudit]([pkProgramType] ASC);

