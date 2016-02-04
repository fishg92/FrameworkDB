CREATE TABLE [dbo].[PSPPrintJobPage] (
    [pkPSPPrintJobPage] DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [fkPSPPrintJob]     DECIMAL (18)    NOT NULL,
    [PageNumber]        INT             NOT NULL,
    [PageData]          VARBINARY (MAX) NOT NULL,
    [LUPUser]           VARCHAR (50)    NULL,
    [LUPDate]           DATETIME        NULL,
    [CreateUser]        VARCHAR (50)    NULL,
    [CreateDate]        DATETIME        NULL,
    CONSTRAINT [PK_PSPPrintJobPage] PRIMARY KEY CLUSTERED ([pkPSPPrintJobPage] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkPSPPrintJob]
    ON [dbo].[PSPPrintJobPage]([fkPSPPrintJob] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'PSP is a way to treat any file the same as the output from Forms. The file is printed from any application, keywords are added, and a Compass Document is created. This table stored the image data for individual pages in a print job.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'pkPSPPrintJobPage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to PSPPrintJob', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'fkPSPPrintJob';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Page number for the specific page', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Image of the page created by PSP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'PageData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PSPPrintJobPage', @level2type = N'COLUMN', @level2name = N'CreateDate';

