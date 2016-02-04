CREATE TABLE [dbo].[RMS] (
    [pkRMS]             DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser] DECIMAL (18) NOT NULL,
    [ScheduledDate]     DATETIME     NOT NULL,
    [DateComplete]      DATETIME     NULL,
    CONSTRAINT [PK_RMS] PRIMARY KEY CLUSTERED ([pkRMS] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[RMS]([fkApplicationUser] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RMS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'RMS', @level2type = N'COLUMN', @level2name = N'pkRMS';

