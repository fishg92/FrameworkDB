CREATE TABLE [dbo].[DeletedCase] (
    [pkDeletedCase]     DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClientCase]    DECIMAL (18) NOT NULL,
    [StateCaseNumber]   VARCHAR (20) NULL,
    [LocalCaseNumber]   VARCHAR (20) NULL,
    [fkProgramType]     DECIMAL (18) NULL,
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [DeleteDate]        DATETIME     CONSTRAINT [DF_DeletedCase_DeleteDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_DeletedCase] PRIMARY KEY CLUSTERED ([pkDeletedCase] ASC)
);

