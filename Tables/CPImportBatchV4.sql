CREATE TABLE [dbo].[CPImportBatchV4] (
    [pkCPImportBatchV4] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [CreateUser]        VARCHAR (50)  NOT NULL,
    [CreateDate]        SMALLDATETIME NOT NULL,
    [ImportStart]       DATETIME      CONSTRAINT [DF_CPImportBatch_ImportStartV4] DEFAULT (getdate()) NULL,
    [ImportEnd]         DATETIME      NULL,
    [RecordCount]       INT           NULL,
    CONSTRAINT [PK_CPImportBatchV4] PRIMARY KEY CLUSTERED ([pkCPImportBatchV4] ASC)
);

