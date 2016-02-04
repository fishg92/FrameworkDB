CREATE TABLE [dbo].[refFileNetPromptField] (
    [pkrefFileNetPromptField] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [FieldName]               VARCHAR (50) NOT NULL,
    [DataType]                VARCHAR (50) NOT NULL,
    [FriendlyName]            VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_FileNetPromptField] PRIMARY KEY CLUSTERED ([pkrefFileNetPromptField] ASC),
    CONSTRAINT [CK_FileNetPromptField_DataType] CHECK ([DataType]='Boolean' OR [DataType]='Date' OR [DataType]='Integer' OR [DataType]='Decimal' OR [DataType]='String' OR [DataType]='Participant')
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [FieldName]
    ON [dbo].[refFileNetPromptField]([FieldName] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is used to convert fields to and from FileNet for Compass Tasks', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetPromptField';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetPromptField', @level2type = N'COLUMN', @level2name = N'pkrefFileNetPromptField';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Field name to be converted', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetPromptField', @level2type = N'COLUMN', @level2name = N'FieldName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date type of the field to be converted', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetPromptField', @level2type = N'COLUMN', @level2name = N'DataType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the field to show in the user interface', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refFileNetPromptField', @level2type = N'COLUMN', @level2name = N'FriendlyName';

