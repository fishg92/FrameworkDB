CREATE TABLE [dbo].[HolidayAudit] (
    [pk]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME     NULL,
    [AuditEndDate]   DATETIME     NULL,
    [AuditUser]      VARCHAR (50) NULL,
    [AuditMachine]   VARCHAR (15) NULL,
    [AuditDeleted]   TINYINT      NULL,
    [pkHoliday]      DECIMAL (18) NOT NULL,
    [HolidayDate]    DATETIME     NOT NULL,
    CONSTRAINT [PK_HolidayAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkHolidayAudit]
    ON [dbo].[HolidayAudit]([pkHoliday] ASC);

