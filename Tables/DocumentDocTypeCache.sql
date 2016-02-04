CREATE TABLE [dbo].[DocumentDocTypeCache] (
    [pkDocumentDocTypeCache] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]      DECIMAL (18)    NOT NULL,
    [DocTypeList]            VARBINARY (MAX) NOT NULL,
    [LastRefresh]            DATETIME        CONSTRAINT [DF_DocumentDocTypeCache_LastRefresh] DEFAULT (getdate()) NOT NULL,
    [RefreshStarted]         DATETIME        NULL,
    CONSTRAINT [PK_DocumentDocTypeCache] PRIMARY KEY CLUSTERED ([pkDocumentDocTypeCache] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[DocumentDocTypeCache]([fkApplicationUser] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This holds a temporary cache of document type information for each user. This provides a significant performance improvement compared to retrieving this information from the DMS.It keeps these document types cached and refreshes them in a cyclical manner so as to not overwhelm the server by having the document types refresh all at the same time for every user. It also tracks when the last refresh started so that it can provide some metric on how long document type refreshes are taking for users to aid in troubleshooting and tuning. The actual document type list is stored as a binary value and is not human readable.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache', @level2type = N'COLUMN', @level2name = N'pkDocumentDocTypeCache';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to APplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Listing of available doc types for a given user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache', @level2type = N'COLUMN', @level2name = N'DocTypeList';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Time when last refreshed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache', @level2type = N'COLUMN', @level2name = N'LastRefresh';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Time last refresh started', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocumentDocTypeCache', @level2type = N'COLUMN', @level2name = N'RefreshStarted';

