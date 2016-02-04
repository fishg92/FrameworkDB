CREATE TABLE [dbo].[refClientCaseImportSource] (
    [pkrefClientCaseImportSource] DECIMAL (18) NOT NULL,
    [Description]                 VARCHAR (50) NOT NULL,
    [StateCaseNumberPadLength]    INT          CONSTRAINT [DF_refClientCaseImportSource_StateCaseNumberPadLength] DEFAULT ((0)) NOT NULL,
    [StateCaseNumberPadCharacter] VARCHAR (1)  CONSTRAINT [DF_refClientCaseImportSource_StateCaseNumberPadCharacter] DEFAULT ('') NOT NULL,
    [StateCaseNumberPadPosition]  CHAR (1)     CONSTRAINT [DF_refClientCaseImportSource_StateCaseNumberPadPosition] DEFAULT ('L') NOT NULL,
    [MatchOnLocalCaseNumber]      BIT          CONSTRAINT [DF_refClientCaseImportSource_MatchOnLocalCaseNumber] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_refClientCaseImportSource] PRIMARY KEY CLUSTERED ([pkrefClientCaseImportSource] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This reference table holds reference information on client data import sources and how that information should be formatted to match state case numbers.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'pkrefClientCaseImportSource';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Source of the client information', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Length to pad an integer value from the source to make it conform to state case numbers', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'StateCaseNumberPadLength';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What character should be used to pad the case number (typically 0 or a blank space).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'StateCaseNumberPadCharacter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Pad the left or right side of the number to make it conform to state case numbers', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'StateCaseNumberPadPosition';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the record be matched to local case numbers', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refClientCaseImportSource', @level2type = N'COLUMN', @level2name = N'MatchOnLocalCaseNumber';

