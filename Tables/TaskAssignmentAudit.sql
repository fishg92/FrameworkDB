CREATE TABLE [dbo].[TaskAssignmentAudit] (
    [pk]                           DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]               DATETIME      NULL,
    [AuditEndDate]                 DATETIME      NULL,
    [AuditUser]                    VARCHAR (50)  NULL,
    [AuditMachine]                 VARCHAR (15)  NULL,
    [AuditDeleted]                 TINYINT       NULL,
    [pkTaskAssignment]             DECIMAL (18)  NOT NULL,
    [fkTask]                       DECIMAL (18)  NOT NULL,
    [Description]                  VARCHAR (100) CONSTRAINT [DF__TaskAssig__Descr__1CF47D9C] DEFAULT ('') NULL,
    [fkApplicationUserAssignedBy]  DECIMAL (18)  NOT NULL,
    [fkApplicationUserAssignedTo]  DECIMAL (18)  NOT NULL,
    [fkTaskAssignmentReassignedTo] DECIMAL (18)  NULL,
    [fkrefTaskAssignmentStatus]    DECIMAL (18)  NOT NULL,
    [StartDate]                    DATETIME      NULL,
    [CompleteDate]                 DATETIME      NULL,
    [UserRead]                     BIT           CONSTRAINT [DF__TaskAssig__UserR__1DE8A1D5] DEFAULT ((0)) NOT NULL,
    [fkrefTaskAssignmentReason]    DECIMAL (18)  NULL,
    [UserReadNote]                 BIT           CONSTRAINT [DF__TaskAssig__UserR__1EDCC60E] DEFAULT ((0)) NULL,
    [AuditEffectiveUser]           VARCHAR (50)  NULL,
    [AuditEffectiveDate]           DATETIME      NULL,
    [RecipientHasBeenNotified]     BIT           CONSTRAINT [DF__TaskAssig__Recip__1FD0EA47] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_TaskAssignmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkTaskAssignmentAudit]
    ON [dbo].[TaskAssignmentAudit]([pkTaskAssignment] ASC);


GO
CREATE NONCLUSTERED INDEX [idxAuditUser]
    ON [dbo].[TaskAssignmentAudit]([AuditUser] ASC, [fkTask] ASC);


GO
CREATE NONCLUSTERED INDEX [idxfkTask]
    ON [dbo].[TaskAssignmentAudit]([fkTask] ASC);

