CREATE TABLE [dbo].[refSyncItemType] (
    [pkrefSyncItemType] DECIMAL (18) NOT NULL,
    [Description]       VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_refSyncItemType] PRIMARY KEY CLUSTERED ([pkrefSyncItemType] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Sync Item Types', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refSyncItemType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Primary Key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refSyncItemType', @level2type = N'COLUMN', @level2name = N'pkrefSyncItemType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Description', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refSyncItemType', @level2type = N'COLUMN', @level2name = N'Description';

