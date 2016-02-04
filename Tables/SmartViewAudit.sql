CREATE TABLE [dbo].[SmartViewAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkSmartView]    DECIMAL (18)  NOT NULL,
    [Description]    VARCHAR (100) NULL,
    [IsDefault]      BIT           NOT NULL,
    CONSTRAINT [PK_SmartViewAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkSmartViewAudit]
    ON [dbo].[SmartViewAudit]([pkSmartView] ASC);

