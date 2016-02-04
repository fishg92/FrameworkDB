CREATE TABLE [dbo].[TempAuditPurgeNightly] (
    [SPID]       VARBINARY (128) NOT NULL,
    [LUPUser]    VARCHAR (50)    NULL,
    [LUPMac]     CHAR (17)       NULL,
    [LUPIp]      VARCHAR (15)    NULL,
    [LUPMachine] VARCHAR (15)    NULL,
    CONSTRAINT [PK_TempAuditPurgeNightly] PRIMARY KEY CLUSTERED ([SPID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Temp Table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'SPID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly', @level2type = N'COLUMN', @level2name = N'SPID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LUPMAC', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly', @level2type = N'COLUMN', @level2name = N'LUPMac';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LUPIP', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly', @level2type = N'COLUMN', @level2name = N'LUPIp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'LUPMachine', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'TempAuditPurgeNightly', @level2type = N'COLUMN', @level2name = N'LUPMachine';

