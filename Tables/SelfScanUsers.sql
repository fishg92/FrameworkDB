CREATE TABLE [dbo].[SelfScanUsers] (
    [pkSelfScanUser] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FirstName]      VARCHAR (50)  NULL,
    [LastName]       VARCHAR (50)  NULL,
    [SSN]            VARCHAR (9)   NULL,
    [CaseNumber]     VARCHAR (10)  NULL,
    [Address]        VARCHAR (100) NULL,
    [City]           VARCHAR (50)  NULL,
    [State]          VARCHAR (50)  NULL,
    [Zip]            VARCHAR (10)  NULL,
    CONSTRAINT [PK_SelfScanUsers] PRIMARY KEY CLUSTERED ([pkSelfScanUser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'An apparently deprecated table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'SelfScanUsers';

