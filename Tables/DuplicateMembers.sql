CREATE TABLE [dbo].[DuplicateMembers] (
    [pkDuplicateMembers]  DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientMain]      DECIMAL (18) NULL,
    [fkCPClientDuplicate] DECIMAL (18) NULL,
    CONSTRAINT [PK_DuplicateMembers] PRIMARY KEY CLUSTERED ([pkDuplicateMembers] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used in efforts to try to elimitate duplicates in the CPClientMain table (generally as a result of importing issues)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateMembers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateMembers', @level2type = N'COLUMN', @level2name = N'pkDuplicateMembers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient indiciating the (likely) original record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateMembers', @level2type = N'COLUMN', @level2name = N'fkCPClientMain';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Link to CPClient indiciating the record that is likely the duplicate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DuplicateMembers', @level2type = N'COLUMN', @level2name = N'fkCPClientDuplicate';

