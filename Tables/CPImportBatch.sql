CREATE TABLE [dbo].[CPImportBatch] (
    [pkCPImportBatch] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [CreateUser]      VARCHAR (50)  NOT NULL,
    [CreateDate]      SMALLDATETIME NOT NULL,
    CONSTRAINT [PK_CPImportBatch] PRIMARY KEY CLUSTERED ([pkCPImportBatch] ASC)
);

