CREATE TABLE [dbo].[CPImportBatchStepV4] (
    [pkCPImportBatchStepV4] DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatchV4]     DECIMAL (18)   NOT NULL,
    [StepDate]              DATETIME       CONSTRAINT [DF_CPImportBatchStep_StepDateV4] DEFAULT (getdate()) NOT NULL,
    [StepDescription]       VARCHAR (1000) NOT NULL,
    [EndDate]               DATETIME       NULL,
    CONSTRAINT [PK_CPImportBatchStepV4] PRIMARY KEY CLUSTERED ([pkCPImportBatchStepV4] ASC)
);


GO
CREATE NONCLUSTERED INDEX [FK_CPImportBatchStepV4]
    ON [dbo].[CPImportBatchStepV4]([fkCPImportBatchV4] ASC);

