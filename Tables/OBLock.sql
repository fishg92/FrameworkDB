CREATE TABLE [dbo].[OBLock] (
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [LockTime]          DATETIME     CONSTRAINT [DF_OBLock_LockTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_OBLock] PRIMARY KEY CLUSTERED ([fkApplicationUser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table used to prevent multiple OnBase user sessions for the same user from being created at the same time', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OBLock';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The user that is currently creating an OnBase user session', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OBLock', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The timestamp when user user session creation began', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'OBLock', @level2type = N'COLUMN', @level2name = N'LockTime';

