CREATE TABLE [dbo].[FileNetRequiredQueueField] (
    [pkFileNetRequiredQueueField] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [RequiredFieldName]           VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_FileNetRequiredField] PRIMARY KEY CLUSTERED ([pkFileNetRequiredQueueField] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [RequiredFieldName]
    ON [dbo].[FileNetRequiredQueueField]([RequiredFieldName] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information to verify that FileNet systems are configured with queues required for Compass to function properly.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FileNetRequiredQueueField';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FileNetRequiredQueueField', @level2type = N'COLUMN', @level2name = N'pkFileNetRequiredQueueField';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the required field in FileNet', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FileNetRequiredQueueField', @level2type = N'COLUMN', @level2name = N'RequiredFieldName';

