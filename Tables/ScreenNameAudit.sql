CREATE TABLE [dbo].[ScreenNameAudit] (
    [pk]                  DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]      DATETIME      NULL,
    [AuditEndDate]        DATETIME      NULL,
    [AuditUser]           VARCHAR (50)  NULL,
    [AuditMachine]        VARCHAR (15)  NULL,
    [AuditDeleted]        TINYINT       NULL,
    [pkScreenName]        DECIMAL (18)  NOT NULL,
    [Description]         VARCHAR (50)  NULL,
    [AppID]               DECIMAL (18)  NOT NULL,
    [FriendlyDescription] VARCHAR (100) NULL,
    [Sequence]            INT           CONSTRAINT [DF__ScreenNam__Seque__60A067CA] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ScreenNameAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkScreenNameAudit]
    ON [dbo].[ScreenNameAudit]([pkScreenName] ASC);

