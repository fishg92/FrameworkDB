CREATE TABLE [dbo].[UserProgramTypeSelected] (
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [fkProgramType]     DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_UserProgramTypeDeselected] PRIMARY KEY CLUSTERED ([fkApplicationUser] ASC, [fkProgramType] ASC),
    CONSTRAINT [FK_UserProgramTypeDeselected_ApplicationUser] FOREIGN KEY ([fkApplicationUser]) REFERENCES [dbo].[ApplicationUser] ([pkApplicationUser]) ON DELETE CASCADE,
    CONSTRAINT [FK_UserProgramTypeDeselected_ProgramType] FOREIGN KEY ([fkProgramType]) REFERENCES [dbo].[ProgramType] ([pkProgramType]) ON DELETE CASCADE
);


GO
CREATE NONCLUSTERED INDEX [fkProgramType]
    ON [dbo].[UserProgramTypeSelected]([fkProgramType] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table associates selected program types for Documents to individual users to manage their filtered views across sessions.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProgramTypeSelected';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Application User. Deletes are cascaded', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProgramTypeSelected', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Program Type. Deletes are cascaded', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'UserProgramTypeSelected', @level2type = N'COLUMN', @level2name = N'fkProgramType';

