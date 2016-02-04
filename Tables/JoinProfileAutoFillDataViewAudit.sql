CREATE TABLE [dbo].[JoinProfileAutoFillDataViewAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkJoinProfileAutoFillDataView] DECIMAL (18) NOT NULL,
    [fkProfile]                     DECIMAL (18) NOT NULL,
    [fkAutoFillDataView]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinProfileAutoFillDataViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinProfileAutoFillDataViewAudit]
    ON [dbo].[JoinProfileAutoFillDataViewAudit]([pkJoinProfileAutoFillDataView] ASC);

