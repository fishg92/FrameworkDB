CREATE TABLE [dbo].[MergedCase] (
    [pkMergedCase]            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientCaseDuplicate] DECIMAL (18) NULL,
    [fkCPMergeCase]           DECIMAL (18) NULL,
    CONSTRAINT [PK_MergedCase] PRIMARY KEY CLUSTERED ([pkMergedCase] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table shows what cases were merged together historically.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedCase', @level2type = N'COLUMN', @level2name = N'pkMergedCase';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase for the duplicate case.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedCase', @level2type = N'COLUMN', @level2name = N'fkCPClientCaseDuplicate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase for what the duplicate case was merged into.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedCase', @level2type = N'COLUMN', @level2name = N'fkCPMergeCase';

