CREATE TABLE [dbo].[ApplicationUserFavoriteCaseAudit] (
    [pk]                            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [AuditStartDate]                DATETIME     NULL,
    [AuditEndDate]                  DATETIME     NULL,
    [AuditUser]                     VARCHAR (50) NULL,
    [AuditMachine]                  VARCHAR (15) NULL,
    [AuditDeleted]                  TINYINT      NULL,
    [pkApplicationUserFavoriteCase] DECIMAL (18) NOT NULL,
    [fkApplicationUser]             DECIMAL (18) NULL,
    [fkCPClientCase]                DECIMAL (18) NULL,
    CONSTRAINT [PK_ApplicationUserFavoriteCaseAudit] PRIMARY KEY NONCLUSTERED ([pk] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxPkApplicationUserFavoriteCaseAudit]
    ON [dbo].[ApplicationUserFavoriteCaseAudit]([pkApplicationUserFavoriteCase] ASC);

