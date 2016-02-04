CREATE TABLE [dbo].[AutofillSchemaMatchGroupColumn] (
    [pkAutofillSchemaMatchGroupColumn] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkAutofillSchemaMatchGroup]       DECIMAL (18) NOT NULL,
    [fkAutofillSchemaColumns]          DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_AutoFillSchemaMatchGroupColumn] PRIMARY KEY CLUSTERED ([pkAutofillSchemaMatchGroupColumn] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AutofillSchemaMatchGroupColumn]
    ON [dbo].[AutofillSchemaMatchGroupColumn]([fkAutofillSchemaMatchGroup] ASC, [pkAutofillSchemaMatchGroupColumn] ASC);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaColumns]
    ON [dbo].[AutofillSchemaMatchGroupColumn]([fkAutofillSchemaColumns] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal use table for migrating customers to a newer version of Autofill', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroupColumn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroupColumn', @level2type = N'COLUMN', @level2name = N'pkAutofillSchemaMatchGroupColumn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaMatchGroup table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroupColumn', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaMatchGroup';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaColumns table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'AutofillSchemaMatchGroupColumn', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaColumns';

