CREATE TABLE [dbo].[CPImportBatchStep] (
    [pkCPImportBatchStep] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]     DECIMAL (18)   NOT NULL,
    [StepDate]            DATETIME       CONSTRAINT [DF_CPImportBatchStep_StepDate] DEFAULT (getdate()) NOT NULL,
    [StepDescription]     VARCHAR (1000) NOT NULL,
    CONSTRAINT [PK_CPImportBatchStep] PRIMARY KEY CLUSTERED ([pkCPImportBatchStep] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch]
    ON [dbo].[CPImportBatchStep]([fkCPImportBatch] ASC);

