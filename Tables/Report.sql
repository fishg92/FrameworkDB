CREATE TABLE [dbo].[Report] (
    [pkReport]         DECIMAL (18)  NOT NULL,
    [FriendlyName]     VARCHAR (200) NOT NULL,
    [fkNCPApplication] DECIMAL (18)  NOT NULL,
    [ProcedureName]    VARCHAR (100) NOT NULL,
    [LUPUser]          VARCHAR (50)  NULL,
    [LUPDate]          DATETIME      NULL,
    [CreateUser]       VARCHAR (50)  NULL,
    [CreateDate]       DATETIME      NULL,
    CONSTRAINT [PK_Report] PRIMARY KEY CLUSTERED ([pkReport] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkNCPApplication]
    ON [dbo].[Report]([fkNCPApplication] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated table to support the reporing information for the Benefits Bank application. No longer in use.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report', @level2type = N'COLUMN', @level2name = N'pkReport';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Report', @level2type = N'COLUMN', @level2name = N'CreateDate';

