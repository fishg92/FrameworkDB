CREATE TABLE [dbo].[Logging] (
    [pkTrace]       DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [DateTime]      DATETIME        NOT NULL,
    [Source]        VARCHAR (100)   NOT NULL,
    [ApplicationID] INT             NOT NULL,
    [EntryType]     VARCHAR (200)   NOT NULL,
    [Message]       TEXT            NOT NULL,
    [AssociateWith] VARCHAR (200)   NOT NULL,
    [Object]        VARBINARY (255) NULL,
    [ObjectLen]     INT             NULL,
    [LupUser]       VARCHAR (50)    NULL,
    [LupDate]       DATETIME        NULL,
    [CreateUser]    VARCHAR (50)    NULL,
    [CreateDate]    DATETIME        NULL,
    CONSTRAINT [PK_LoggingNew7022] PRIMARY KEY CLUSTERED ([pkTrace] ASC)
);


GO
CREATE NONCLUSTERED INDEX [LoggingDate]
    ON [dbo].[Logging]([DateTime] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'A one size fits all logging table for system events (but not, usually, user actions: those are in the related audit tables for the individual tables).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID Number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'pkTrace';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date and time of the logged item', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'DateTime';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What is the source of the logged event?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'Source';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What application does the event relate to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'ApplicationID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'From the ProTracerEntryType enumeration in Compass, what is the error level? (Critical Error = 0, Warnint = 1, Information = 2, UserAction = 3)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'EntryType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What''s the message for the error message?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'Message';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'What user raised the event', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'AssociateWith';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Not used, apparently', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'Object';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Also not used', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'ObjectLen';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'LupUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'LupDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Logging', @level2type = N'COLUMN', @level2name = N'CreateDate';

