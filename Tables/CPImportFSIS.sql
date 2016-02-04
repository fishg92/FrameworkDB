CREATE TABLE [dbo].[CPImportFSIS] (
    [pkCPImportFSIS]          DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]         DECIMAL (18)  NOT NULL,
    [SSN]                     VARCHAR (20)  NULL,
    [CaseID]                  VARCHAR (50)  NULL,
    [CountyCaseNum]           VARCHAR (50)  NULL,
    [CaseHeadFirstName]       VARCHAR (50)  NULL,
    [CaseHeadMiddleName]      VARCHAR (50)  NULL,
    [CaseHeadLastName]        VARCHAR (50)  NULL,
    [CaseHeadIndividualID]    VARCHAR (50)  NULL,
    [ParticipantFirstName]    VARCHAR (50)  NULL,
    [ParticipantMiddleName]   VARCHAR (50)  NULL,
    [ParticipantLastName]     VARCHAR (50)  NULL,
    [ParticipantIndividualID] VARCHAR (50)  NULL,
    [ParticipantSex]          VARCHAR (10)  NULL,
    [Street1]                 VARCHAR (50)  NULL,
    [Street2]                 VARCHAR (50)  NULL,
    [City]                    VARCHAR (50)  NULL,
    [State]                   VARCHAR (10)  NULL,
    [Zip]                     VARCHAR (10)  NULL,
    [ZipPlus4]                VARCHAR (10)  NULL,
    [WorkerNum]               VARCHAR (20)  NULL,
    [BirthDate]               DATETIME      NULL,
    [Phone]                   VARCHAR (50)  NULL,
    [EffectiveDate]           DATETIME      NOT NULL,
    [ProcessDate]             DATETIME      NULL,
    [CityState]               VARCHAR (100) NULL,
    [SSNFormatted]            CHAR (9)      NULL,
    [BirthDateString]         VARCHAR (50)  NULL,
    [CaseHeadBirthDateString] VARCHAR (50)  NULL,
    [CaseHeadSex]             VARCHAR (50)  NULL,
    [DataChecksum]            INT           NULL,
    CONSTRAINT [PK_CPImportFSIS] PRIMARY KEY CLUSTERED ([pkCPImportFSIS] ASC)
);


GO
CREATE NONCLUSTERED INDEX [BatchCaseIDs]
    ON [dbo].[CPImportFSIS]([fkCPImportBatch] ASC, [CaseID] ASC, [CaseHeadIndividualID] ASC, [ParticipantIndividualID] ASC);


GO
CREATE NONCLUSTERED INDEX [Batch_Checksum]
    ON [dbo].[CPImportFSIS]([fkCPImportBatch] ASC, [DataChecksum] ASC);


GO
CREATE NONCLUSTERED INDEX [ParticipantIndividualID_CaseHeadIndividualID_fkCPImportBatch]
    ON [dbo].[CPImportFSIS]([ParticipantIndividualID] ASC, [CaseHeadIndividualID] ASC, [fkCPImportBatch] ASC);

