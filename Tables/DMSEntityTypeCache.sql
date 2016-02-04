CREATE TABLE [dbo].[DMSEntityTypeCache] (
    [fkApplicationUser] DECIMAL (18)    NOT NULL,
    [DMSTypes]          VARBINARY (MAX) NOT NULL,
    [LastRefresh]       DATETIME        CONSTRAINT [DF_DocumentDMSTypeCache_LastRefresh] DEFAULT (getdate()) NOT NULL,
    [RefreshStarted]    DATETIME        NULL,
    CONSTRAINT [PK_DocumentDMSTypeCache] PRIMARY KEY CLUSTERED ([fkApplicationUser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains documents types and keyword types for each user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMSEntityTypeCache';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Key to Pilot user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMSEntityTypeCache', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Serialized list of document type and keyword type definitions', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMSEntityTypeCache', @level2type = N'COLUMN', @level2name = N'DMSTypes';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date that this record was created or last modified', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMSEntityTypeCache', @level2type = N'COLUMN', @level2name = N'LastRefresh';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Flag to indicate that a refresh is underway for this user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DMSEntityTypeCache', @level2type = N'COLUMN', @level2name = N'RefreshStarted';

