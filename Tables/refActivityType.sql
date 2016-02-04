CREATE TABLE [dbo].[refActivityType] (
    [pkrefActivityType]       DECIMAL (18) NOT NULL,
    [fkNCPApplication]        DECIMAL (18) CONSTRAINT [DF_refActivityType_fkNCPApplication] DEFAULT ((-1)) NOT NULL,
    [Description]             VARCHAR (50) NOT NULL,
    [Data1ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data1ColumnName] DEFAULT ('') NOT NULL,
    [Data2ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data2ColumnName] DEFAULT ('') NOT NULL,
    [Data3ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data3ColumnName] DEFAULT ('') NOT NULL,
    [Data4ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data4ColumnName] DEFAULT ('') NOT NULL,
    [Data5ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data5ColumnName] DEFAULT ('') NOT NULL,
    [Data6ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data6ColumnName] DEFAULT ('') NOT NULL,
    [Data7ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data7ColumnName] DEFAULT ('') NOT NULL,
    [Data8ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data8ColumnName] DEFAULT ('') NOT NULL,
    [Data9ColumnName]         VARCHAR (50) CONSTRAINT [DF_refActivityType_Data9ColumnName] DEFAULT ('') NOT NULL,
    [Data10ColumnName]        VARCHAR (50) CONSTRAINT [DF_refActivityType_Data10ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData1ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData1ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData2ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData2ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData3ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData3ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData4ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData4ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData5ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData5ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData6ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData6ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData7ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData7ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData8ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData8ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData9ColumnName]  VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData9ColumnName] DEFAULT ('') NOT NULL,
    [DecimalData10ColumnName] VARCHAR (50) CONSTRAINT [DF_refActivityType_DecimalData10ColumnName] DEFAULT ('') NOT NULL,
    [BitData1ColumnName]      VARCHAR (50) CONSTRAINT [DF_refActivityType_BitData1ColumnName] DEFAULT ('') NOT NULL,
    [BitData2ColumnName]      VARCHAR (50) CONSTRAINT [DF_refActivityType_BitData2ColumnName] DEFAULT ('') NOT NULL,
    [BitData3ColumnName]      VARCHAR (50) CONSTRAINT [DF_refActivityType_BitData3ColumnName] DEFAULT ('') NOT NULL,
    [BitData4ColumnName]      VARCHAR (50) CONSTRAINT [DF_refActivityType_BitData4ColumnName] DEFAULT ('') NOT NULL,
    [BitData5ColumnName]      VARCHAR (50) CONSTRAINT [DF_refActivityType_BitData5ColumnName] DEFAULT ('') NOT NULL,
    [DateData1ColumnName]     VARCHAR (50) CONSTRAINT [DF_refActivityType_DateData1ColumnName] DEFAULT ('') NOT NULL,
    [DateData2ColumnName]     VARCHAR (50) CONSTRAINT [DF_refActivityType_DateData2ColumnName] DEFAULT ('') NOT NULL,
    [DateData3ColumnName]     VARCHAR (50) CONSTRAINT [DF_refActivityType_DateData3ColumnName] DEFAULT ('') NOT NULL,
    [DateData4ColumnName]     VARCHAR (50) CONSTRAINT [DF_refActivityType_DateData4ColumnName] DEFAULT ('') NOT NULL,
    [DateData5ColumnName]     VARCHAR (50) CONSTRAINT [DF_refActivityType_DateData5ColumnName] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_refActivityType] PRIMARY KEY CLUSTERED ([pkrefActivityType] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [Application_Description]
    ON [dbo].[refActivityType]([fkNCPApplication] ASC, [Description] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DateData5ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table provides a reference for the ActivityLog table. It lays out, for each of the different activity types, what the various columns in ActivityLog are storing.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'pkrefActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to NCPApplication', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'fkNCPApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The activity being logged', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Description';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data1ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data2ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data3ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data4ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data5ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data6ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data7ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data8ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data9ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'Data10ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData1ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData2ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData3ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData4ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData5ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData6ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData7ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData8ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData9ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DecimalData10ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'BitData1ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'BitData2ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'BitData3ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'BitData4ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'BitData5ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DateData1ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DateData2ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DateData3ColumnName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What the column of the same name in the ActivityLog table is actually logging.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refActivityType', @level2type = N'COLUMN', @level2name = N'DateData4ColumnName';

