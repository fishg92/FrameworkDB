CREATE TABLE [dbo].[PublicAuthenticatedSession] (
    [pkPublicAuthenticatedSession] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]            DECIMAL (18) NOT NULL,
    [AuthenticationToken]          VARCHAR (75) NOT NULL,
    [KeepAlive]                    DATETIME     NOT NULL,
    [LUPUser]                      VARCHAR (50) NULL,
    [LUPDate]                      DATETIME     NULL,
    [CreateUser]                   VARCHAR (50) NULL,
    [CreateDate]                   DATETIME     NULL,
    CONSTRAINT [PK_pkBenefitWorkerAuthenticatedSession] PRIMARY KEY NONCLUSTERED ([pkPublicAuthenticatedSession] ASC),
    CONSTRAINT [CK_PublicAuthenticatedSession] CHECK ([AuthenticationToken] like '[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z]-[0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z][0-9a-z]')
);


GO
CREATE NONCLUSTERED INDEX [AuthenticationToken]
    ON [dbo].[PublicAuthenticatedSession]([AuthenticationToken] ASC);


GO
CREATE NONCLUSTERED INDEX [KeepAlive]
    ON [dbo].[PublicAuthenticatedSession]([KeepAlive] ASC);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[PublicAuthenticatedSession]([fkApplicationUser] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to manage user sessions and ensure security of service calls. At login, a user is issued a session token. Each service call requires this token to be passed to verify the identity and validity of the service request.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'pkPublicAuthenticatedSession';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the ApplicationUser Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Token used to authenticate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'AuthenticationToken';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Timestamp to keep the session alive', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'KeepAlive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PublicAuthenticatedSession', @level2type = N'COLUMN', @level2name = N'CreateDate';

