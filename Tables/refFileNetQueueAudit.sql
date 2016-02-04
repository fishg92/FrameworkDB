CREATE TABLE [dbo].[refFileNetQueueAudit] (
    [pk]                DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]    DATETIME     NULL,
    [AuditEndDate]      DATETIME     NULL,
    [AuditUser]         VARCHAR (50) NULL,
    [AuditMachine]      VARCHAR (15) NULL,
    [AuditDeleted]      TINYINT      NULL,
    [pkrefFileNetQueue] DECIMAL (18) NOT NULL,
    [QueueName]         VARCHAR (50) NULL,
    [PrimaryIndex]      VARCHAR (50) NULL,
    [FilterBy]          VARCHAR (50) NULL,
    CONSTRAINT [PK_refFileNetQueueAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefFileNetQueueAudit]
    ON [dbo].[refFileNetQueueAudit]([pkrefFileNetQueue] ASC);

