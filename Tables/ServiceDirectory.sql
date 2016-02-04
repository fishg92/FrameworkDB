CREATE TABLE [dbo].[ServiceDirectory] (
    [pkServiceDirectory]   DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [ServiceID]            VARCHAR (100) NOT NULL,
    [ServiceName]          VARCHAR (100) NOT NULL,
    [ImplementsIsAlive]    VARCHAR (5)   NOT NULL,
    [LUP]                  DATETIME      NOT NULL,
    [EndPointUri]          VARCHAR (250) NOT NULL,
    [CurrentConnections]   INT           NOT NULL,
    [DiscoveryUrl]         VARCHAR (250) NOT NULL,
    [ServiceStartDateTime] DATETIME      NULL,
    [ServiceUser]          VARCHAR (100) NULL,
    [ServicePassword]      VARCHAR (100) NULL,
    [ServiceMode]          VARCHAR (100) NULL,
    [ServiceProtocol]      VARCHAR (50)  NULL,
    [ServiceType]          VARCHAR (50)  NULL,
    CONSTRAINT [PK_ServiceDirectory] PRIMARY KEY CLUSTERED ([pkServiceDirectory] ASC)
);


GO
CREATE NONCLUSTERED INDEX [ServiceName]
    ON [dbo].[ServiceDirectory]([ServiceName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not the service implements the keep-alive setting', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ImplementsIsAlive';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last time the service was verified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'LUP';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'End point address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'EndPointUri';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Current connections to the service', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'CurrentConnections';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'URL to find the service and get the standard XML description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'DiscoveryUrl';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time the service was last started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceStartDateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'If applicable, the username that the service runs under', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'if applicable, the (hashed) password that the service uses', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServicePassword';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Valid values are Public or Private', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceMode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Valid values currently are net.tcp or WsHttp', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceProtocol';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of service (WinSVC)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds the configuration data for the various services to run Compass Pilot.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'pkServiceDirectory';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal ID for the service', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'More descriptive name of the service (usually referring to the DMS used with the service)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ServiceDirectory', @level2type = N'COLUMN', @level2name = N'ServiceName';

