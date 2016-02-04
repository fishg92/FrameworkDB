CREATE TABLE [dbo].[DuplicateCases] (
    [pkDuplicateCases]        DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientCaseMain]      DECIMAL (18) NULL,
    [fkCPClientCaseDuplicate] DECIMAL (18) NULL,
    CONSTRAINT [PK_DuplicateCases] PRIMARY KEY CLUSTERED ([pkDuplicateCases] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used in efforts to try to elimitate duplicates in the CPClientCase Main table (generally as a result of importing issues)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateCases';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateCases', @level2type = N'COLUMN', @level2name = N'pkDuplicateCases';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClientCase indiciating the (likely) original record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateCases', @level2type = N'COLUMN', @level2name = N'fkCPClientCaseMain';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link to CPClientCase indiciating the record that is likely the duplicate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateCases', @level2type = N'COLUMN', @level2name = N'fkCPClientCaseDuplicate';

