CREATE TABLE [dbo].[InstallerScriptsExecuted] (
    [Guid]        VARCHAR (50)  NOT NULL,
    [Description] VARCHAR (100) NULL,
    [CreateDate]  DATETIME      DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_InstallerScriptsExecuted] PRIMARY KEY CLUSTERED ([Guid] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table needed for automated installation and upgrade of application', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallerScriptsExecuted';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Guid that maps to a SQLScript in the Wix project', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallerScriptsExecuted', @level2type = N'COLUMN', @level2name = N'Guid';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Friendly Name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallerScriptsExecuted', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Create date that the script was executed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallerScriptsExecuted', @level2type = N'COLUMN', @level2name = N'CreateDate';

