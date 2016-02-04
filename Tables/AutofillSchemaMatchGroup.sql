CREATE TABLE [dbo].[AutofillSchemaMatchGroup] (
    [pkAutofilllSchemaMatchGroup] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchema]            DECIMAL (18) NOT NULL,
    [Description]                 VARCHAR (50) NOT NULL,
    [MatchType]                   VARCHAR (20) NOT NULL,
    CONSTRAINT [PK_AutoFilllSchemaMatchGroup] PRIMARY KEY CLUSTERED ([pkAutofilllSchemaMatchGroup] ASC),
    CONSTRAINT [CK_AutofillSchemaMatchGroup_MatchType] CHECK ([MatchType]='Prompt' OR [MatchType]='Absolute'),
    CONSTRAINT [AutoFillSchemaMatchGroupDescription] UNIQUE NONCLUSTERED ([Description] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutoFillSchema]
    ON [dbo].[AutofillSchemaMatchGroup]([fkAutofillSchema] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table for migrating customers to a newer version of Autofill', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroup', @level2type = N'COLUMN', @level2name = N'pkAutofilllSchemaMatchGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroup', @level2type = N'COLUMN', @level2name = N'fkAutofillSchema';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroup', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroup', @level2type = N'COLUMN', @level2name = N'MatchType';

