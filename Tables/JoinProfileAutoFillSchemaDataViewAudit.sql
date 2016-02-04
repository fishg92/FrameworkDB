CREATE TABLE [dbo].[JoinProfileAutoFillSchemaDataViewAudit] (
    [pk]                                  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                      DATETIME     NULL,
    [AuditEndDate]                        DATETIME     NULL,
    [AuditUser]                           VARCHAR (50) NULL,
    [AuditMachine]                        VARCHAR (15) NULL,
    [AuditDeleted]                        TINYINT      NULL,
    [pkJoinProfileAutoFillSchemaDataView] DECIMAL (18) NOT NULL,
    [fkProfile]                           DECIMAL (18) NOT NULL,
    [fkAutoFillSchemaDataView]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinProfileAutoFillSchemaDataViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinProfileAutoFillSchemaDataViewAudit]
    ON [dbo].[JoinProfileAutoFillSchemaDataViewAudit]([pkJoinProfileAutoFillSchemaDataView] ASC);

