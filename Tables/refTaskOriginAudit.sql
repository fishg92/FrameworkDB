CREATE TABLE [dbo].[refTaskOriginAudit] (
    [pk]              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME      NULL,
    [AuditEndDate]    DATETIME      NULL,
    [AuditUser]       VARCHAR (50)  NULL,
    [AuditMachine]    VARCHAR (15)  NULL,
    [AuditDeleted]    TINYINT       NULL,
    [pkrefTaskOrigin] DECIMAL (18)  NOT NULL,
    [TaskOriginName]  VARCHAR (150) NULL,
    [Active]          BIT           NOT NULL,
    CONSTRAINT [PK_refTaskOriginAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskOriginAudit]
    ON [dbo].[refTaskOriginAudit]([pkrefTaskOrigin] ASC);

