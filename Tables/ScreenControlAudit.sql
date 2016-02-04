CREATE TABLE [dbo].[ScreenControlAudit] (
    [pk]              DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME      NULL,
    [AuditEndDate]    DATETIME      NULL,
    [AuditUser]       VARCHAR (50)  NULL,
    [AuditMachine]    VARCHAR (15)  NULL,
    [AuditDeleted]    TINYINT       NULL,
    [pkScreenControl] DECIMAL (18)  NOT NULL,
    [ControlName]     VARCHAR (100) NULL,
    [fkScreenName]    DECIMAL (18)  NOT NULL,
    [Sequence]        INT           CONSTRAINT [DF__ScreenCon__Seque__543A90E5] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_ScreenControlAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkScreenControlAudit]
    ON [dbo].[ScreenControlAudit]([pkScreenControl] ASC);

