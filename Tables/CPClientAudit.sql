CREATE TABLE [dbo].[CPClientAudit] (
    [pk]                         DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME      NULL,
    [AuditEndDate]               DATETIME      NULL,
    [AuditUser]                  VARCHAR (50)  NULL,
    [AuditMachine]               VARCHAR (15)  NULL,
    [AuditDeleted]               TINYINT       NULL,
    [pkCPClient]                 DECIMAL (18)  NOT NULL,
    [LastName]                   VARCHAR (100) NULL,
    [FirstName]                  VARCHAR (100) NULL,
    [MiddleName]                 VARCHAR (100) NULL,
    [SSN]                        CHAR (10)     NULL,
    [NorthwoodsNumber]           VARCHAR (50)  NULL,
    [StateIssuedNumber]          VARCHAR (50)  NULL,
    [BirthDate]                  DATETIME      NULL,
    [BirthLocation]              VARCHAR (100) NULL,
    [Sex]                        CHAR (1)      NULL,
    [fkCPRefClientEducationType] DECIMAL (18)  NULL,
    [LockedUser]                 VARCHAR (20)  NULL,
    [LockedDate]                 DATETIME      NULL,
    [FormattedSSN]               VARCHAR (11)  NULL,
    [MaidenName]                 VARCHAR (100) NULL,
    [Suffix]                     VARCHAR (20)  NULL,
    [SISNumber]                  VARCHAR (11)  NULL,
    [SchoolName]                 VARCHAR (100) NULL,
    [HomePhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClientA__HomeP__1C6A6DB7] DEFAULT ('') NOT NULL,
    [CellPhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClientA__CellP__1D5E91F0] DEFAULT ('') NOT NULL,
    [WorkPhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClientA__WorkP__1E52B629] DEFAULT ('') NOT NULL,
    [WorkPhoneExt]               VARCHAR (10)  CONSTRAINT [DF__CPClientA__WorkP__1F46DA62] DEFAULT ('') NOT NULL,
    [DataCheckSum]               INT           NULL,
    [Email]                      VARCHAR (250) NULL,
    CONSTRAINT [PK_CPClientAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPClientAudit]
    ON [dbo].[CPClientAudit]([pkCPClient] ASC);

