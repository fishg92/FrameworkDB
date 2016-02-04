CREATE TABLE [dbo].[RMSData] (
    [pkRMSData] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkRMS]     DECIMAL (18) NOT NULL,
    CONSTRAINT [PK_RMSData] PRIMARY KEY CLUSTERED ([pkRMSData] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkRMS]
    ON [dbo].[RMSData]([fkRMS] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RMSData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RMSData', @level2type = N'COLUMN', @level2name = N'pkRMSData';

