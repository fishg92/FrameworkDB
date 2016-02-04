CREATE TABLE [dbo].[RefDailyJobAudit] (
    [pk]                DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME      NULL,
    [AuditEndDate]      DATETIME      NULL,
    [AuditUser]         VARCHAR (50)  NULL,
    [AuditMachine]      VARCHAR (15)  NULL,
    [AuditDeleted]      TINYINT       NULL,
    [pkRefDailyJob]     DECIMAL (18)  NOT NULL,
    [JobName]           VARCHAR (50)  NULL,
    [Description]       VARCHAR (255) NULL,
    [Query]             VARCHAR (MAX) NULL,
    [StartTime]         DATETIME      NOT NULL,
    [EndTime]           DATETIME      NULL,
    [Active]            BIT           NOT NULL,
    [DateLastStarted]   DATETIME      NULL,
    [DateLastCompleted] DATETIME      NULL,
    CONSTRAINT [PK_RefDailyJobAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkRefDailyJobAudit]
    ON [dbo].[RefDailyJobAudit]([pkRefDailyJob] ASC);

