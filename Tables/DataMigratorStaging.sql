CREATE TABLE [dbo].[DataMigratorStaging] (
    [pkDataMigratorStaging]       DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkCPImportBatch]             DECIMAL (18)  CONSTRAINT [DF_DataMigratorStaging_fkCPImportBatch] DEFAULT ((-1)) NOT NULL,
    [SubBatchID]                  INT           CONSTRAINT [DF_DataMigratorStaging_SubBatchID] DEFAULT ((-1)) NOT NULL,
    [fkCPClient]                  DECIMAL (18)  NULL,
    [fkCPClientCase]              DECIMAL (18)  NULL,
    [fkCPClientAddressMailing]    DECIMAL (18)  NULL,
    [fkCPClientAddressPhysical]   DECIMAL (18)  NULL,
    [fkCPRefClientEducationType]  DECIMAL (18)  NULL,
    [ProgramTypeName]             VARCHAR (50)  CONSTRAINT [DF_DataMigratorStaging_ProgramType] DEFAULT ('') NOT NULL,
    [ClientUniqueID]              VARCHAR (50)  CONSTRAINT [DF_Table_1_UniqueID] DEFAULT ('') NOT NULL,
    [FirstName]                   VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_FirstName] DEFAULT ('') NOT NULL,
    [MiddleName]                  VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_MiddleName] DEFAULT ('') NOT NULL,
    [LastName]                    VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_LastName] DEFAULT ('') NOT NULL,
    [Suffix]                      VARCHAR (20)  CONSTRAINT [DF_DataMigratorStaging_Suffix] DEFAULT ('') NOT NULL,
    [MaidenName]                  VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_MaidenName] DEFAULT ('') NOT NULL,
    [SSN]                         CHAR (12)     CONSTRAINT [DF_DataMigratorStaging_SSN] DEFAULT ('') NOT NULL,
    [CaseHead]                    BIT           CONSTRAINT [DF_DataMigratorStaging_CaseHead] DEFAULT ((0)) NOT NULL,
    [BirthDate]                   DATETIME      NOT NULL,
    [BirthLocation]               VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_BirthLocation] DEFAULT ('') NOT NULL,
    [SchoolName]                  VARCHAR (100) CONSTRAINT [DF_DataMigratorStaging_SchoolName] DEFAULT ('') NOT NULL,
    [Education]                   VARCHAR (255) CONSTRAINT [DF_DataMigratorStaging_Education] DEFAULT ('') NOT NULL,
    [Sex]                         CHAR (5)      CONSTRAINT [DF_DataMigratorStaging_Sex] DEFAULT ('') NOT NULL,
    [StateCaseNumber]             VARCHAR (20)  CONSTRAINT [DF_DataMigratorStaging_StateCaseNumber] DEFAULT ('') NOT NULL,
    [LocalCaseNumber]             VARCHAR (20)  CONSTRAINT [DF_DataMigratorStaging_LocalCaseNumber] DEFAULT ('') NOT NULL,
    [fkProgramType]               DECIMAL (18)  NULL,
    [fkApplicationUserCaseWorker] DECIMAL (18)  NULL,
    [CaseWorkerID]                VARCHAR (50)  NOT NULL,
    [MailingAddressStreet1]       VARCHAR (102) CONSTRAINT [DF_DataMigratorStaging_MailingAddressStreet1] DEFAULT ('') NOT NULL,
    [MailingAddressStreet2]       VARCHAR (102) CONSTRAINT [DF_DataMigratorStaging_MailingAddressStreet2] DEFAULT ('') NOT NULL,
    [MailingAddressStreet3]       VARCHAR (102) CONSTRAINT [DF_DataMigratorStaging_MailingAddressStreet3] DEFAULT ('') NOT NULL,
    [MailingAddressCity]          VARCHAR (102) CONSTRAINT [DF_DataMigratorStaging_MailingAddressCity] DEFAULT ('') NOT NULL,
    [MailingAddressState]         VARCHAR (52)  CONSTRAINT [DF_DataMigratorStaging_MailingAddressState] DEFAULT ('') NOT NULL,
    [MailingAddressZip]           VARCHAR (25)  CONSTRAINT [DF_DataMigratorStaging_MailingAddressZip] DEFAULT ('') NOT NULL,
    [MailingAddressZipPlus4]      VARCHAR (25)  CONSTRAINT [DF_DataMigratorStaging_MailingAddressZipPlus4] DEFAULT ('') NOT NULL,
    [PhysicalAddressStreet1]      VARCHAR (102) NOT NULL,
    [PhysicalAddressStreet2]      VARCHAR (102) NOT NULL,
    [PhysicalAddressStreet3]      VARCHAR (102) NOT NULL,
    [PhysicalAddressCity]         VARCHAR (102) NOT NULL,
    [PhysicalAddressState]        VARCHAR (52)  NOT NULL,
    [PhysicalAddressZip]          VARCHAR (25)  NOT NULL,
    [PhysicalAddressZipPlus4]     VARCHAR (25)  NOT NULL,
    [HomePhoneNumber]             VARCHAR (25)  CONSTRAINT [DF_DataMigratorStaging_HomePhoneNumber] DEFAULT ('') NOT NULL,
    [CellPhoneNumber]             VARCHAR (25)  CONSTRAINT [DF_DataMigratorStaging_CellPhoneNumber] DEFAULT ('') NOT NULL,
    [ClientChecksum]              AS            (checksum([FirstName],[MiddleName],[LastName],[Suffix],[MaidenName],[SSN],[ClientUniqueID],[BirthDate],[BirthLocation],[SchoolName],[Sex],[HomePhoneNumber],[CellPhoneNumber],[fkCPRefClientEducationType],[Email])) PERSISTED,
    [MailingAddressChecksum]      AS            (checksum([MailingAddressStreet1],[MailingAddressStreet2],[MailingAddressStreet3],[MailingAddressCity],[MailingAddressState],[MailingAddressZip],[MailingAddressZipPlus4])),
    [PhysicalAddressChecksum]     AS            (checksum([PhysicalAddressStreet1],[PhysicalAddressStreet2],[PhysicalAddressStreet3],[PhysicalAddressCity],[PhysicalAddressState],[PhysicalAddressZip],[PhysicalAddressZipPlus4])) PERSISTED,
    [ExclusionFlag]               BIT           CONSTRAINT [DF_DataMigratorStaging_ExclusionFlag] DEFAULT ((0)) NOT NULL,
    [Data1]                       VARCHAR (255) CONSTRAINT [Data1_default] DEFAULT ('') NOT NULL,
    [Data2]                       VARCHAR (255) CONSTRAINT [Data2_default] DEFAULT ('') NOT NULL,
    [Data3]                       VARCHAR (255) CONSTRAINT [Data3_default] DEFAULT ('') NOT NULL,
    [Data4]                       VARCHAR (255) CONSTRAINT [Data4_default] DEFAULT ('') NOT NULL,
    [Data5]                       VARCHAR (255) CONSTRAINT [Data5_default] DEFAULT ('') NOT NULL,
    [Data6]                       VARCHAR (255) CONSTRAINT [Data6_default] DEFAULT ('') NOT NULL,
    [Data7]                       VARCHAR (255) CONSTRAINT [Data7_default] DEFAULT ('') NOT NULL,
    [Data8]                       VARCHAR (255) CONSTRAINT [Data8_default] DEFAULT ('') NOT NULL,
    [Data9]                       VARCHAR (255) CONSTRAINT [Data9_default] DEFAULT ('') NOT NULL,
    [Data10]                      VARCHAR (255) CONSTRAINT [Data10_default] DEFAULT ('') NOT NULL,
    [Data11]                      VARCHAR (255) CONSTRAINT [Data11_default] DEFAULT ('') NOT NULL,
    [Data12]                      VARCHAR (255) CONSTRAINT [Data12_default] DEFAULT ('') NOT NULL,
    [Data13]                      VARCHAR (255) CONSTRAINT [Data13_default] DEFAULT ('') NOT NULL,
    [Data14]                      VARCHAR (255) CONSTRAINT [Data14_default] DEFAULT ('') NOT NULL,
    [Data15]                      VARCHAR (255) CONSTRAINT [Data15_default] DEFAULT ('') NOT NULL,
    [Data16]                      VARCHAR (255) CONSTRAINT [Data16_default] DEFAULT ('') NOT NULL,
    [Data17]                      VARCHAR (255) CONSTRAINT [Data17_default] DEFAULT ('') NOT NULL,
    [Data18]                      VARCHAR (255) CONSTRAINT [Data18_default] DEFAULT ('') NOT NULL,
    [Data19]                      VARCHAR (255) CONSTRAINT [Data19_default] DEFAULT ('') NOT NULL,
    [Data20]                      VARCHAR (255) CONSTRAINT [Data20_default] DEFAULT ('') NOT NULL,
    [Data21]                      VARCHAR (255) CONSTRAINT [Data21_default] DEFAULT ('') NOT NULL,
    [Data22]                      VARCHAR (255) CONSTRAINT [Data22_default] DEFAULT ('') NOT NULL,
    [Data23]                      VARCHAR (255) CONSTRAINT [Data23_default] DEFAULT ('') NOT NULL,
    [Data24]                      VARCHAR (255) CONSTRAINT [Data24_default] DEFAULT ('') NOT NULL,
    [Data25]                      VARCHAR (255) CONSTRAINT [Data25_default] DEFAULT ('') NOT NULL,
    [Data26]                      VARCHAR (255) CONSTRAINT [Data26_default] DEFAULT ('') NOT NULL,
    [Data27]                      VARCHAR (255) CONSTRAINT [Data27_default] DEFAULT ('') NOT NULL,
    [Data28]                      VARCHAR (255) CONSTRAINT [Data28_default] DEFAULT ('') NOT NULL,
    [Data29]                      VARCHAR (255) CONSTRAINT [Data29_default] DEFAULT ('') NOT NULL,
    [Data30]                      VARCHAR (255) CONSTRAINT [Data30_default] DEFAULT ('') NOT NULL,
    [Data31]                      VARCHAR (255) CONSTRAINT [Data31_default] DEFAULT ('') NOT NULL,
    [Data32]                      VARCHAR (255) CONSTRAINT [Data32_default] DEFAULT ('') NOT NULL,
    [Data33]                      VARCHAR (255) CONSTRAINT [Data33_default] DEFAULT ('') NOT NULL,
    [Data34]                      VARCHAR (255) CONSTRAINT [Data34_default] DEFAULT ('') NOT NULL,
    [Data35]                      VARCHAR (255) CONSTRAINT [Data35_default] DEFAULT ('') NOT NULL,
    [Data36]                      VARCHAR (255) CONSTRAINT [Data37_default] DEFAULT ('') NOT NULL,
    [Data37]                      VARCHAR (255) CONSTRAINT [Data36_default] DEFAULT ('') NOT NULL,
    [Data38]                      VARCHAR (255) CONSTRAINT [Data38_default] DEFAULT ('') NOT NULL,
    [Data39]                      VARCHAR (255) CONSTRAINT [Data39_default] DEFAULT ('') NOT NULL,
    [Data40]                      VARCHAR (255) CONSTRAINT [Data40_default] DEFAULT ('') NOT NULL,
    [CustomAttributeChecksum]     AS            (checksum([Data1],[Data2],[Data3],[Data4],[Data5],[Data6],[Data7],[Data8],[Data9],[Data10],[Data11],[Data12],[Data13],[Data14],[Data15],[Data16],[Data17],[Data18],[Data19],[Data20],[Data21],[Data22],[Data23],[Data24],[Data25],[Data26],[Data27],[Data28],[Data29],[Data30],[Data31],[Data32],[Data33],[Data34],[Data35],[Data36],[Data37],[Data38],[Data39],[Data40])) PERSISTED,
    [CaseHeadUniqueID]            VARCHAR (50)  NULL,
    [MailingAddressScore]         INT           CONSTRAINT [DF_DataMigratorStaging_MailingAddressScore] DEFAULT ((0)) NOT NULL,
    [PhysicalAddressScore]        INT           CONSTRAINT [DF_DataMigratorStaging_PhysicalAddressScore] DEFAULT ((0)) NOT NULL,
    [Email]                       VARCHAR (200) CONSTRAINT [DF_DataMigratorStaging_Email] DEFAULT ('') NOT NULL,
    CONSTRAINT [PK_DataMigratorStaging] PRIMARY KEY CLUSTERED ([pkDataMigratorStaging] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch_ProgramTypeName]
    ON [dbo].[DataMigratorStaging]([fkCPImportBatch] ASC, [ProgramTypeName] ASC, [StateCaseNumber] ASC)
    INCLUDE([pkDataMigratorStaging]);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch_SubBatchID]
    ON [dbo].[DataMigratorStaging]([fkCPImportBatch] ASC, [SubBatchID] ASC, [ExclusionFlag] ASC)
    INCLUDE([fkCPClient], [fkCPClientCase], [pkDataMigratorStaging]);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch_ClientUniqueID]
    ON [dbo].[DataMigratorStaging]([fkCPImportBatch] ASC, [ClientUniqueID] ASC);


GO
CREATE NONCLUSTERED INDEX [fkCPImportBatch_fkCPClient_ExclusionFlag]
    ON [dbo].[DataMigratorStaging]([fkCPImportBatch] ASC, [fkCPClient] ASC, [ExclusionFlag] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DataMigratorStaging_fkCPClient]
    ON [dbo].[DataMigratorStaging]([fkCPClient] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DataMigratorStaging_fkCPClientCase]
    ON [dbo].[DataMigratorStaging]([fkCPClientCase] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_DataMigratorStaging_fkProgramType]
    ON [dbo].[DataMigratorStaging]([fkProgramType] ASC);

