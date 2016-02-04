CREATE TABLE [dbo].[CPClientMarriageRecordAudit] (
    [pk]                       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME     NULL,
    [AuditEndDate]             DATETIME     NULL,
    [AuditUser]                VARCHAR (50) NULL,
    [AuditMachine]             VARCHAR (15) NULL,
    [AuditDeleted]             TINYINT      NULL,
    [pkCPClientMarriageRecord] DECIMAL (18) NOT NULL,
    [fkCPClient]               DECIMAL (18) NULL,
    [StartDate]                DATETIME     NULL,
    [EndDate]                  DATETIME     NULL,
    [fkCPRefMarraigeEndType]   DECIMAL (18) NULL,
    [LockedUser]               VARCHAR (50) NULL,
    [LockedDate]               DATETIME     NULL,
    [Spouse]                   VARCHAR (50) NULL,
    [EventDateFreeForm]        VARCHAR (50) NULL,
    CONSTRAINT [PK_CPClientMarriageRecordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientMarriageRecordAudit]
    ON [dbo].[CPClientMarriageRecordAudit]([pkCPClientMarriageRecord] ASC);

