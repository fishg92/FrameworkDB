CREATE TABLE [dbo].[CPImportLog] (
    [pkCPImportLog]               DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [CreateUser]                  VARCHAR (20) CONSTRAINT [DF_CPImportLog_CreateUser] DEFAULT (host_name()) NULL,
    [CreateDate]                  DATETIME     CONSTRAINT [DF_CPImportLog_CreateDate] DEFAULT (getdate()) NULL,
    [fkCPImportFSIS]              DECIMAL (18) NULL,
    [fkCPImportEISCase]           DECIMAL (18) NULL,
    [fkCPImportEISIndividual]     DECIMAL (18) NULL,
    [fkCPClient]                  DECIMAL (18) NULL,
    [fkCPClientCase]              DECIMAL (18) NULL,
    [fkCPJoinClientClientCase]    DECIMAL (18) NULL,
    [fkCPClientAddress]           DECIMAL (18) NULL,
    [fkCPJoinClientClientAddress] DECIMAL (18) NULL,
    [fkCPClientPhone]             DECIMAL (18) NULL,
    [fkCPJoinClientClientPhone]   DECIMAL (18) NULL,
    [fkCPRefImportLogEventType]   DECIMAL (18) NULL,
    CONSTRAINT [PK_CPImportLog] PRIMARY KEY CLUSTERED ([pkCPImportLog] ASC)
);

