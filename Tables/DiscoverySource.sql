CREATE TABLE [dbo].[DiscoverySource] (
    [pkrefDiscoverySource] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [Description]          VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_DiscoverySource] PRIMARY KEY CLUSTERED ([pkrefDiscoverySource] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated - no longer used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DiscoverySource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DiscoverySource', @level2type = N'COLUMN', @level2name = N'pkrefDiscoverySource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description of the discovery source', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DiscoverySource', @level2type = N'COLUMN', @level2name = N'Description';

