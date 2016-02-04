CREATE TABLE [dbo].[CPEmployerAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkCPEmployer]   DECIMAL (18)  NOT NULL,
    [EmployerName]   VARCHAR (255) NULL,
    [Street1]        VARCHAR (100) NULL,
    [Street2]        VARCHAR (100) NULL,
    [Street3]        VARCHAR (100) NULL,
    [City]           VARCHAR (100) NULL,
    [State]          VARCHAR (50)  NULL,
    [Zip]            CHAR (5)      NULL,
    [ZipPlus4]       CHAR (4)      NULL,
    [Phone]          VARCHAR (10)  NULL,
    [Salary]         VARCHAR (50)  NULL,
    CONSTRAINT [PK_CPEmployerAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkCPEmployerAudit]
    ON [dbo].[CPEmployerAudit]([pkCPEmployer] ASC);

