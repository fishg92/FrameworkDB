CREATE TABLE [dbo].[CPImportEISIndividual] (
    [pkCPImportEISIndividual] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]         DECIMAL (18) NOT NULL,
    [SSN]                     VARCHAR (20) NULL,
    [CaseID]                  VARCHAR (50) NULL,
    [FirstName]               VARCHAR (50) NULL,
    [MiddleName]              VARCHAR (50) NULL,
    [LastName]                VARCHAR (50) NULL,
    [IndividualID]            VARCHAR (50) NULL,
    [BirthDate]               DATETIME     NULL,
    [Sex]                     VARCHAR (10) NULL,
    [EffectiveDate]           DATETIME     NULL,
    [ProcessDate]             DATETIME     NULL,
    [SSNFormatted]            CHAR (9)     NULL,
    [BirthDateString]         VARCHAR (50) NULL,
    CONSTRAINT [PK_CPImportEISIndividual] PRIMARY KEY CLUSTERED ([pkCPImportEISIndividual] ASC)
);


GO
CREATE NONCLUSTERED INDEX [CaseID]
    ON [dbo].[CPImportEISIndividual]([fkCPImportBatch] ASC, [CaseID] ASC);


GO
CREATE NONCLUSTERED INDEX [BatchId]
    ON [dbo].[CPImportEISIndividual]([fkCPImportBatch] ASC, [IndividualID] ASC);

