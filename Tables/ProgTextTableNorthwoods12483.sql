CREATE TABLE [dbo].[ProgTextTableNorthwoods12483] (
    [Text]    VARCHAR (300) NULL,
    [LineNum] INT           IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_ProgTextTableNorthwoods12483] PRIMARY KEY CLUSTERED ([LineNum] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is for internal use only! It should not be shipped to customers.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProgTextTableNorthwoods12483';

