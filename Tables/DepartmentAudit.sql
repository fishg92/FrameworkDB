CREATE TABLE [dbo].[DepartmentAudit] (
    [pk]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate] DATETIME      NULL,
    [AuditEndDate]   DATETIME      NULL,
    [AuditUser]      VARCHAR (50)  NULL,
    [AuditMachine]   VARCHAR (15)  NULL,
    [AuditDeleted]   TINYINT       NULL,
    [pkDepartment]   DECIMAL (18)  NOT NULL,
    [DepartmentName] VARCHAR (100) NULL,
    [fkAgencyLOB]    DECIMAL (18)  NOT NULL,
    [fkSupervisor]   DECIMAL (18)  CONSTRAINT [DF_DepartmentAudit_fkSupervisor] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_DepartmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkDepartmentAudit]
    ON [dbo].[DepartmentAudit]([pkDepartment] ASC);

