CREATE TABLE [dbo].[DocumentKeywordCache] (
    [pkDocumentKeywordCache] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]      DECIMAL (18)    NOT NULL,
    [KeywordList]            VARBINARY (MAX) NOT NULL,
    [LastRefresh]            DATETIME        CONSTRAINT [DF_DocumentKeywordCache_LastRefresh] DEFAULT (getdate()) NOT NULL,
    [RefreshStarted]         DATETIME        NULL,
    CONSTRAINT [PK_DocumentKeywordCache] PRIMARY KEY CLUSTERED ([pkDocumentKeywordCache] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[DocumentKeywordCache]([fkApplicationUser] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Last date and time that the cache was refreshed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache', @level2type = N'COLUMN', @level2name = N'LastRefresh';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time that the last refresh of the cache was started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache', @level2type = N'COLUMN', @level2name = N'RefreshStarted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table maintains a temporary cache of keyword types for each user to improve performance, much like the DccumentDocTypeCache table. It caches Keywords and refreshes them in a cyclical manner so as to not overwhelm the server by having the keyword lists for every user refresh at the same time. It also tracks when the last refresh started so that it can provide some metric on how long keyword refreshes are taking for users to aid in troubleshooting and tuning.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache', @level2type = N'COLUMN', @level2name = N'pkDocumentKeywordCache';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Cached list of keywords for the user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentKeywordCache', @level2type = N'COLUMN', @level2name = N'KeywordList';

