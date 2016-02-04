CREATE TABLE [dbo].[refTaskAssignmentReasonAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkrefTaskAssignmentReason] DECIMAL (18) NOT NULL,
    [fkrefTaskAssignmentStatus] DECIMAL (18) NOT NULL,
    [Description]               VARCHAR (50) NULL,
    [Active]                    BIT          NULL,
    CONSTRAINT [PK_refTaskAssignmentReasonAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskAssignmentReasonAudit]
    ON [dbo].[refTaskAssignmentReasonAudit]([pkrefTaskAssignmentReason] ASC);

