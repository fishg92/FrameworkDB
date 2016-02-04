CREATE TABLE [dbo].[JoinApplicationUserLockedEntity] (
    [pkJoinApplicationUserLockedEntity] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]                 DECIMAL (18) NULL,
    [fkLockedEntity]                    DECIMAL (18) NULL,
    CONSTRAINT [PK_JoinApplicationUserLockedEntity] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserLockedEntity] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[JoinApplicationUserLockedEntity]([fkApplicationUser] ASC)
    INCLUDE([fkLockedEntity]);


GO
CREATE NONCLUSTERED INDEX [fkLockedEntity]
    ON [dbo].[JoinApplicationUserLockedEntity]([fkLockedEntity] ASC)
    INCLUDE([fkApplicationUser]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. In this case, this table tracks which ApplicationUser(s) have locked which entities (CPClients and programtypes).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserLockedEntity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserLockedEntity', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserLockedEntity';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserLockedEntity', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Locked Entity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserLockedEntity', @level2type = N'COLUMN', @level2name = N'fkLockedEntity';

