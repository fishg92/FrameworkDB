CREATE TABLE [dbo].[AutoFillAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkAutoFill]     DECIMAL (18)  NOT NULL,
    [SSN]            VARCHAR (11)  NULL,
    [CaseNumber]     VARCHAR (50)  NULL,
    [FirstName]      VARCHAR (40)  NULL,
    [LastName]       VARCHAR (40)  NULL,
    [Address1]       VARCHAR (150) NULL,
    [Address2]       VARCHAR (100) NULL,
    [City]           VARCHAR (50)  NULL,
    [State]          VARCHAR (2)   NULL,
    [Zip]            VARCHAR (50)  NULL,
    [CaseManager]    VARCHAR (15)  NULL,
    [LastName1char]  CHAR (1)      NULL,
    [LastName2char]  CHAR (2)      NULL,
    [LastName3char]  CHAR (3)      NULL,
    [LastName4char]  CHAR (4)      NULL,
    [LastName5char]  CHAR (5)      NULL,
    CONSTRAINT [PK_AutoFillAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkAutoFillAudit]
    ON [dbo].[AutoFillAudit]([pkAutoFill] ASC);

