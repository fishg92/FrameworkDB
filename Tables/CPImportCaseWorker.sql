CREATE TABLE [dbo].[CPImportCaseWorker] (
    [pkCPImportCaseWorker] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]      DECIMAL (18) NOT NULL,
    [UserName]             VARCHAR (50) NULL,
    [FirstName]            VARCHAR (30) NULL,
    [LastName]             VARCHAR (30) NULL,
    [PhoneNumber]          VARCHAR (30) NULL,
    [CountyCode]           VARCHAR (10) NULL,
    [EffectiveDate]        DATETIME     NULL,
    [ProcessDate]          DATETIME     NULL,
    [Extension]            VARCHAR (50) NULL,
    [DistrictId]           VARCHAR (50) NULL,
    [WorkerID1]            VARCHAR (50) NULL,
    [WorkerID2]            VARCHAR (50) NULL,
    [WorkerID3]            VARCHAR (50) NULL,
    [WorkerID4]            VARCHAR (50) NULL,
    [WorkerID5]            VARCHAR (50) NULL,
    [WorkerID6]            VARCHAR (50) NULL,
    [WorkerID7]            VARCHAR (50) NULL,
    [WorkerID8]            VARCHAR (50) NULL,
    [WorkerID9]            VARCHAR (50) NULL,
    [WorkerID10]           VARCHAR (50) NULL,
    CONSTRAINT [PK_CPImportCaseWorker] PRIMARY KEY CLUSTERED ([pkCPImportCaseWorker] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch]
    ON [dbo].[CPImportCaseWorker]([fkCPImportBatch] ASC);

