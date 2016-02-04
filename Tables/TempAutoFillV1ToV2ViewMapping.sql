CREATE TABLE [dbo].[TempAutoFillV1ToV2ViewMapping] (
    [pkTempAutoFillV1ToV2ViewMapping] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkAutofillDataView]              DECIMAL (18) NOT NULL,
    [fkAutofillSchemaDataView]        DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_TempAutoFillV1ToV2ViewMapping] PRIMARY KEY CLUSTERED ([pkTempAutoFillV1ToV2ViewMapping] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAutofillDataView]
    ON [dbo].[TempAutoFillV1ToV2ViewMapping]([fkAutofillDataView] ASC);


GO
CREATE NONCLUSTERED INDEX [fkAutofillSchemaDataView]
    ON [dbo].[TempAutoFillV1ToV2ViewMapping]([fkAutofillSchemaDataView] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Internal table used for migration to newer AutoFill method', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAutoFillV1ToV2ViewMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAutoFillV1ToV2ViewMapping', @level2type = N'COLUMN', @level2name = N'pkTempAutoFillV1ToV2ViewMapping';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillDataView (old Autofill method)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAutoFillV1ToV2ViewMapping', @level2type = N'COLUMN', @level2name = N'fkAutofillDataView';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to AutofillSchemaDataView table (new method)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAutoFillV1ToV2ViewMapping', @level2type = N'COLUMN', @level2name = N'fkAutofillSchemaDataView';

