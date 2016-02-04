CREATE TABLE [dbo].[AutotestCommentExcludedTables] (
    [TableName] VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_AutotestCommentExcludedTables] PRIMARY KEY CLUSTERED ([TableName] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'List of tables that are excluded from documentation commenting rules', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutotestCommentExcludedTables';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of table to be excluded from commenting rules', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutotestCommentExcludedTables', @level2type = N'COLUMN', @level2name = N'TableName';

