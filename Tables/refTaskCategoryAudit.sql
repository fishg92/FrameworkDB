CREATE TABLE [dbo].[refTaskCategoryAudit] (
    [pk]                        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]            DATETIME     NULL,
    [AuditEndDate]              DATETIME     NULL,
    [AuditUser]                 VARCHAR (50) NULL,
    [AuditMachine]              VARCHAR (15) NULL,
    [AuditDeleted]              TINYINT      NULL,
    [pkrefTaskCategory]         DECIMAL (18) NOT NULL,
    [fkrefTaskCategoryParent]   DECIMAL (18) NOT NULL,
    [CategoryName]              VARCHAR (50) NULL,
    [ExternalTaskingEngineRoot] VARCHAR (50) CONSTRAINT [DF_refTaskCategoryAudit_ExternalTaskingEngineRoot] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_refTaskCategoryAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefTaskCategoryAudit]
    ON [dbo].[refTaskCategoryAudit]([pkrefTaskCategory] ASC);

