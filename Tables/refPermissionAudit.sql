CREATE TABLE [dbo].[refPermissionAudit] (
    [pk]                         DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]             DATETIME       NULL,
    [AuditEndDate]               DATETIME       NULL,
    [AuditUser]                  VARCHAR (50)   NULL,
    [AuditMachine]               VARCHAR (15)   NULL,
    [AuditDeleted]               TINYINT        NULL,
    [pkrefPermission]            DECIMAL (18)   NOT NULL,
    [Description]                VARCHAR (100)  NULL,
    [EnumDescriptor]             VARCHAR (100)  NULL,
    [fkApplication]              DECIMAL (18)   NULL,
    [TreeGroup]                  VARCHAR (100)  NULL,
    [TreeSubGroup]               VARCHAR (100)  NULL,
    [TreeNode]                   VARCHAR (100)  NULL,
    [ParentRestriction]          DECIMAL (18)   NULL,
    [TreeNodeSeq]                INT            NULL,
    [DetailedDescription]        VARCHAR (2000) NULL,
    [RequiredForThisApplication] TINYINT        NULL,
    [RequiredForGlobalOptions]   TINYINT        CONSTRAINT [DF_refPermissionAudit_RequiredForGlobalOptions] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_refPermissionAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkrefPermissionAudit]
    ON [dbo].[refPermissionAudit]([pkrefPermission] ASC);

