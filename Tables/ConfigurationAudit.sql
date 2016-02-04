CREATE TABLE [dbo].[ConfigurationAudit] (
    [pk]              DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]  DATETIME       NULL,
    [AuditEndDate]    DATETIME       NULL,
    [AuditUser]       VARCHAR (50)   NULL,
    [AuditMachine]    VARCHAR (15)   NULL,
    [AuditDeleted]    TINYINT        NULL,
    [pkConfiguration] DECIMAL (18)   NOT NULL,
    [Grouping]        VARCHAR (200)  NULL,
    [ItemKey]         VARCHAR (200)  NULL,
    [ItemValue]       NVARCHAR (300) NULL,
    [ItemDescription] VARCHAR (300)  NULL,
    [AppID]           INT            NOT NULL,
    [Sequence]        INT            NOT NULL,
    CONSTRAINT [PK_ConfigurationAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkConfigurationAudit]
    ON [dbo].[ConfigurationAudit]([pkConfiguration] ASC);

