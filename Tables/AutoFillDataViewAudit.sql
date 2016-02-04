CREATE TABLE [dbo].[AutoFillDataViewAudit] (
    [pk]                          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]              DATETIME      NULL,
    [AuditEndDate]                DATETIME      NULL,
    [AuditUser]                   VARCHAR (50)  NULL,
    [AuditMachine]                VARCHAR (15)  NULL,
    [AuditDeleted]                TINYINT       NULL,
    [pkAutoFillDataView]          DECIMAL (18)  NOT NULL,
    [fkAutoFillDataSource]        DECIMAL (18)  NOT NULL,
    [FriendlyName]                VARCHAR (100) NULL,
    [TSql]                        VARCHAR (MAX) NULL,
    [IgnoreProgramTypeSecurity]   TINYINT       NULL,
    [IgnoreSecuredClientSecurity] TINYINT       NULL,
    CONSTRAINT [PK_AutoFillDataViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutoFillDataViewAudit]
    ON [dbo].[AutoFillDataViewAudit]([pkAutoFillDataView] ASC);

