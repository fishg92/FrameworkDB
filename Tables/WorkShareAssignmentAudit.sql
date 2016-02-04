CREATE TABLE [dbo].[WorkShareAssignmentAudit] (
    [pk]                    DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]        DATETIME     NULL,
    [AuditEndDate]          DATETIME     NULL,
    [AuditUser]             VARCHAR (50) NULL,
    [AuditMachine]          VARCHAR (15) NULL,
    [AuditDeleted]          TINYINT      NULL,
    [pkWorkShareAssignment] DECIMAL (18) NOT NULL,
    [fksharer]              DECIMAL (18) NOT NULL,
    [fksharee]              DECIMAL (18) NOT NULL,
    [fkrefWorkSharingType]  DECIMAL (18) CONSTRAINT [DF_WorkShareAssignmentAudit_fkrefWorkSharingType] DEFAULT ((1)) NOT NULL,
    CONSTRAINT [PK_WorkShareAssignmentAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkWorkShareAssignmentAudit]
    ON [dbo].[WorkShareAssignmentAudit]([pkWorkShareAssignment] ASC);

