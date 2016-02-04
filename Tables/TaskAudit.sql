CREATE TABLE [dbo].[TaskAudit] (
    [pk]              DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME       NULL,
    [AuditEndDate]    DATETIME       NULL,
    [AuditUser]       VARCHAR (50)   NULL,
    [AuditMachine]    VARCHAR (15)   NULL,
    [AuditDeleted]    TINYINT        NULL,
    [pkTask]          DECIMAL (18)   NOT NULL,
    [fkrefTaskType]   DECIMAL (18)   NOT NULL,
    [Description]     VARCHAR (100)  NULL,
    [DueDate]         DATETIME       NULL,
    [Note]            VARCHAR (2000) NULL,
    [fkrefTaskStatus] DECIMAL (18)   NOT NULL,
    [Priority]        TINYINT        NOT NULL,
    [StartDate]       DATETIME       NULL,
    [CompleteDate]    DATETIME       NULL,
    [GroupTask]       BIT            NOT NULL,
    [SourceModuleID]  INT            NULL,
    [fkrefTaskOrigin] DECIMAL (18)   CONSTRAINT [DF_TaskAudit_fkrefTaskOrigin] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_TaskAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskAudit]
    ON [dbo].[TaskAudit]([pkTask] ASC, [AuditStartDate] ASC);

