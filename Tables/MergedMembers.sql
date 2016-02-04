CREATE TABLE [dbo].[MergedMembers] (
    [pkMergedMembers]     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPDuplicateMember] DECIMAL (18) NULL,
    [fkCPMergeMember]     DECIMAL (18) NULL,
    CONSTRAINT [PK_MergedMembers] PRIMARY KEY CLUSTERED ([pkMergedMembers] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This tables shows the history of what users were merged together historically.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedMembers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedMembers', @level2type = N'COLUMN', @level2name = N'pkMergedMembers';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient to show the dupliate member', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedMembers', @level2type = N'COLUMN', @level2name = N'fkCPDuplicateMember';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to CPClient to show the user the duplicate was merged into', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'MergedMembers', @level2type = N'COLUMN', @level2name = N'fkCPMergeMember';

