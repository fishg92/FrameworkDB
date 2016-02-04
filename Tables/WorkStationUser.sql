CREATE TABLE [dbo].[WorkStationUser] (
    [pkWorkStationuser] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [LUPUser]           VARCHAR (50) NULL,
    [LUPMachine]        VARCHAR (15) NULL,
    CONSTRAINT [PK_WorkStationUser] PRIMARY KEY CLUSTERED ([pkWorkStationuser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Store User information for history', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkStationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'primary key for table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkStationUser', @level2type = N'COLUMN', @level2name = N'pkWorkStationuser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LupUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkStationUser', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LupMachine', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'WorkStationUser', @level2type = N'COLUMN', @level2name = N'LUPMachine';

