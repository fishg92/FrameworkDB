CREATE TABLE [dbo].[ApplicationUserDMSSession] (
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [SessionID]         VARCHAR (50) NOT NULL,
    [SessionOpenTime]   DATETIME     CONSTRAINT [DF_ApplicationUserDMSSession_SessionOpenTime] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_ApplicationUserDMSSession] PRIMARY KEY CLUSTERED ([fkApplicationUser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Session manangement for the Document Management Service for individual users.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDMSSession';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Since this table shares a 1:1 relationship with ApplicationUser, this foreign key is also the primary key for the table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDMSSession', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SessionID for the user. Thus ensuring that each user can only have 1 session at one time.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDMSSession', @level2type = N'COLUMN', @level2name = N'SessionID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Timestamp when the session was opened.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserDMSSession', @level2type = N'COLUMN', @level2name = N'SessionOpenTime';

