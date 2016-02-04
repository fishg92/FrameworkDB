CREATE TABLE [dbo].[JoinrefTaskTypeApplicationUserAudit] (
    [pk]                               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                   DATETIME     NULL,
    [AuditEndDate]                     DATETIME     NULL,
    [AuditUser]                        VARCHAR (50) NULL,
    [AuditMachine]                     VARCHAR (15) NULL,
    [AuditDeleted]                     TINYINT      NULL,
    [pkJoinrefTaskTypeApplicationUser] DECIMAL (18) NOT NULL,
    [fkrefTaskType]                    DECIMAL (18) NOT NULL,
    [fkApplicationUser]                DECIMAL (18) NOT NULL,
    [DisplayOrder]                     INT          CONSTRAINT [DF_JoinrefTaskTypeApplicationUserAudit_DisplayOrder] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_JoinrefTaskTypeApplicationUserAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkJoinrefTaskTypeApplicationUserAudit]
    ON [dbo].[JoinrefTaskTypeApplicationUserAudit]([pkJoinrefTaskTypeApplicationUser] ASC);

