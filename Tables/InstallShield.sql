CREATE TABLE [dbo].[InstallShield] (
    [ISSchema]        CHAR (15)    NULL,
    [pkInstallShield] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    CONSTRAINT [PK_InstallShield] PRIMARY KEY CLUSTERED ([pkInstallShield] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table needed for automated installation and upgrade of application', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallShield';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Version of product being installed', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallShield', @level2type = N'COLUMN', @level2name = N'ISSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'InstallShield', @level2type = N'COLUMN', @level2name = N'pkInstallShield';

