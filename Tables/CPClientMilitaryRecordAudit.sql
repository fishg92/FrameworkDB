CREATE TABLE [dbo].[CPClientMilitaryRecordAudit] (
    [pk]                       DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME     NULL,
    [AuditEndDate]             DATETIME     NULL,
    [AuditUser]                VARCHAR (50) NULL,
    [AuditMachine]             VARCHAR (15) NULL,
    [AuditDeleted]             TINYINT      NULL,
    [pkCPClientMilitaryRecord] DECIMAL (18) NOT NULL,
    [fkCPClient]               DECIMAL (18) NULL,
    [fkCPRefMilitaryBranch]    DECIMAL (18) NULL,
    [StartDate]                DATETIME     NULL,
    [EndDate]                  DATETIME     NULL,
    [DishonorablyDischarged]   BIT          NULL,
    [LockedUser]               VARCHAR (50) NULL,
    [LockedDate]               DATETIME     NULL,
    [EventStart]               VARCHAR (50) NULL,
    [EventEnd]                 VARCHAR (50) NULL,
    CONSTRAINT [PK_CPClientMilitaryRecordAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientMilitaryRecordAudit]
    ON [dbo].[CPClientMilitaryRecordAudit]([pkCPClientMilitaryRecord] ASC);

