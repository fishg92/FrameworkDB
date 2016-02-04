CREATE TABLE [dbo].[CPImportEISCase] (
    [pkCPImportEISCase] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]   DECIMAL (18) NOT NULL,
    [CaseID]            VARCHAR (50) NULL,
    [CountyCaseNum]     VARCHAR (50) NULL,
    [FirstName]         VARCHAR (50) NULL,
    [MiddleName]        VARCHAR (50) NULL,
    [LastName]          VARCHAR (50) NULL,
    [IndividualID]      VARCHAR (50) NULL,
    [Street1]           VARCHAR (50) NULL,
    [Street2]           VARCHAR (50) NULL,
    [City]              VARCHAR (50) NULL,
    [State]             VARCHAR (10) NULL,
    [Zip]               VARCHAR (10) NULL,
    [ZipPlus4]          VARCHAR (10) NULL,
    [DistrctNo]         VARCHAR (10) NULL,
    [BirthDate]         DATETIME     NULL,
    [Sex]               VARCHAR (10) NULL,
    [Phone]             VARCHAR (50) NULL,
    [WorkerNumber]      VARCHAR (20) NULL,
    [EffectiveDate]     DATETIME     NULL,
    [ProcessDate]       DATETIME     NULL,
    [BirthDateString]   VARCHAR (50) NULL,
    CONSTRAINT [PK_CPImportEICCase] PRIMARY KEY CLUSTERED ([pkCPImportEISCase] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Batch]
    ON [dbo].[CPImportEISCase]([fkCPImportBatch] ASC, [IndividualID] ASC);

