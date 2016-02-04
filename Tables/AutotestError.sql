CREATE TABLE [dbo].[AutotestError] (
    [pkAutotestError] INT           IDENTITY (1, 1) NOT NULL,
    [ErrorText]       VARCHAR (500) NOT NULL,
    [ErrorDate]       DATETIME      CONSTRAINT [DF_AutotestError_ErrorDate] DEFAULT (getdate()) NOT NULL,
    [ErrorLevel]      VARCHAR (50)  CONSTRAINT [DF_AutotestError_ErrorLevel] DEFAULT ('Error') NULL,
    CONSTRAINT [PK_AutotestError] PRIMARY KEY CLUSTERED ([pkAutotestError] ASC)
);

