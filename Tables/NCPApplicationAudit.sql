CREATE TABLE [dbo].[NCPApplicationAudit] (
    [pk]                       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]           DATETIME      NULL,
    [AuditEndDate]             DATETIME      NULL,
    [AuditUser]                VARCHAR (50)  NULL,
    [AuditMachine]             VARCHAR (15)  NULL,
    [AuditDeleted]             TINYINT       NULL,
    [pkNCPApplication]         DECIMAL (18)  NOT NULL,
    [ApplicationName]          VARCHAR (100) NULL,
    [CurrentVersion]           VARCHAR (50)  NULL,
    [AssemblyName]             VARCHAR (100) NULL,
    [Registered]               BIT           NULL,
    [DefaultAppOrder]          INT           NULL,
    [ShowInMenu]               BIT           NULL,
    [MinimumFunctionalityOnly] BIT           NULL,
    CONSTRAINT [PK_NCPApplicationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkNCPApplicationAudit]
    ON [dbo].[NCPApplicationAudit]([pkNCPApplication] ASC);

