CREATE TABLE [dbo].[PSPPrintJob] (
    [pkPSPPrintJob]     DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [MachineName]       VARCHAR (255) NULL,
    [Username]          VARCHAR (255) NULL,
    [PrintDate]         DATETIME      NULL,
    [DocType]           VARCHAR (50)  NULL,
    [PrintJobType]      INT           NULL,
    [LUPUser]           VARCHAR (50)  NULL,
    [LUPDate]           DATETIME      NULL,
    [CreateUser]        VARCHAR (50)  NULL,
    [CreateDate]        DATETIME      NULL,
    [fkPSPDocType]      DECIMAL (18)  NULL,
    [ExpectedPageCount] INT           CONSTRAINT [DF_PSPPrintJob_ExpectedPageCount] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_PSPPrintJob] PRIMARY KEY CLUSTERED ([pkPSPPrintJob] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPDocType]
    ON [dbo].[PSPPrintJob]([fkPSPDocType] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table stores a history of the PSP jobs that have been run.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'pkPSPPrintJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the machine doing the print job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'MachineName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the user doing the print job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'Username';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of the print job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'PrintDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DMS Doc Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'DocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Type of print job', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'PrintJobType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP Document Template - Foreign key to PSPDocType', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'fkPSPDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Total number of pages in print job prior to sending to database', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJob', @level2type = N'COLUMN', @level2name = N'ExpectedPageCount';

