CREATE TABLE [dbo].[JoinApplicationUserRefProfile] (
    [pkJoinApplicationUserRefProfile] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [fkProfile]                       DECIMAL (18) NOT NULL,
    [AppId]                           INT          NOT NULL,
    CONSTRAINT [PK_JoinApplicationUserRefProfile] PRIMARY KEY CLUSTERED ([pkJoinApplicationUserRefProfile] ASC),
    CONSTRAINT [FK_JoinApplicationUserRefProfile_ApplicationUser] FOREIGN KEY ([fkApplicationUser]) REFERENCES [dbo].[ApplicationUser] ([pkApplicationUser]) ON DELETE CASCADE,
    CONSTRAINT [FK_JoinApplicationUserRefProfile_Profile] FOREIGN KEY ([fkProfile]) REFERENCES [dbo].[Profile] ([pkProfile]) ON DELETE CASCADE
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_fkApplicationUser_AppID_IsUnique]
    ON [dbo].[JoinApplicationUserRefProfile]([fkApplicationUser] ASC, [AppId] ASC);


GO
CREATE NONCLUSTERED INDEX [fkProfile]
    ON [dbo].[JoinApplicationUserRefProfile]([fkProfile] ASC)
    INCLUDE([fkApplicationUser]);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Join tables represent a many to many relationship between two or more tables. This table assigns profiles to application users for specific applications. ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefProfile', @level2type = N'COLUMN', @level2name = N'pkJoinApplicationUserRefProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefProfile', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Profile', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefProfile', @level2type = N'COLUMN', @level2name = N'fkProfile';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Integer indicating the application to set the profile for', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'JoinApplicationUserRefProfile', @level2type = N'COLUMN', @level2name = N'AppId';

