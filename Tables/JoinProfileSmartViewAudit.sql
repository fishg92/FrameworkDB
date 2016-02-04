CREATE TABLE [dbo].[JoinProfileSmartViewAudit] (
    [pk]                     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]         DATETIME     NULL,
    [AuditEndDate]           DATETIME     NULL,
    [AuditUser]              VARCHAR (50) NULL,
    [AuditEffectiveUser]     VARCHAR (50) NULL,
    [AuditEffectiveDate]     DATETIME     NULL,
    [AuditMachine]           VARCHAR (15) NULL,
    [AuditDeleted]           TINYINT      NULL,
    [pkJoinProfileSmartView] DECIMAL (18) NOT NULL,
    [fkProfile]              DECIMAL (18) NOT NULL,
    [fkSmartView]            DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_JoinProfileSmartViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinProfileSmartViewAudit]
    ON [dbo].[JoinProfileSmartViewAudit]([pkJoinProfileSmartView] ASC);

