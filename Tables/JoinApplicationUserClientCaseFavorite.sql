CREATE TABLE [dbo].[JoinApplicationUserClientCaseFavorite] (
    [pkJoinApplicationUserClientCaseFavorite] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                       DECIMAL (18) NULL,
    [fkCPClientCase]                          DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinApplicationUserClientCaseFavorite] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserClientCaseFavorite] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserClientCaseFavorite]([fkApplicationUser] ASC)
    INCLUDE([fkCPClientCase]);


GO
CREATE NONCLUSTERED INDEX [fkCPClientCase]
    ON [dbo].[JoinApplicationUserClientCaseFavorite]([fkCPClientCase] ASC)
    INCLUDE([fkApplicationUser]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This join table defines the many to many relationship between ApplicationUser and ClientCaseFavorite.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserClientCaseFavorite';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserClientCaseFavorite', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserClientCaseFavorite';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserClientCaseFavorite', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign Key to CPClientCase', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserClientCaseFavorite', @level2type = N'COLUMN', @level2name = N'fkCPClientCase';

