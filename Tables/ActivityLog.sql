CREATE TABLE [dbo].[ActivityLog] (
    [pkActivityLog]     DECIMAL (18)    IDENTITY (1, 1) NOT NULL,
    [ActivityID]        VARCHAR (50)    NOT NULL,
    [fkrefActivityType] DECIMAL (18)    NOT NULL,
    [fkApplicationUser] DECIMAL (18)    NOT NULL,
    [fkDepartment]      DECIMAL (18)    NOT NULL,
    [fkAgencyLOB]       DECIMAL (18)    NOT NULL,
    [ParentActivityID]  VARCHAR (50)    CONSTRAINT [DF_ActivityAudit_fkParentActivityAudit] DEFAULT ((-1)) NOT NULL,
    [ActivityDate]      DATETIME        CONSTRAINT [DF_ActivityAudit_ActivityDate] DEFAULT (getdate()) NOT NULL,
    [MachineName]       VARCHAR (50)    CONSTRAINT [DF_ActivityAudit_MachineName] DEFAULT ('') NOT NULL,
    [Data1]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data1] DEFAULT ('') NOT NULL,
    [Data2]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data2] DEFAULT ('') NOT NULL,
    [Data3]             VARCHAR (255)   NOT NULL,
    [Data4]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data4] DEFAULT ('') NOT NULL,
    [Data5]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data5] DEFAULT ('') NOT NULL,
    [Data6]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data6] DEFAULT ('') NOT NULL,
    [Data7]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data7] DEFAULT ('') NOT NULL,
    [Data8]             VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data8] DEFAULT ('') NOT NULL,
    [Data9]             VARCHAR (255)   NOT NULL,
    [Data10]            VARCHAR (255)   CONSTRAINT [DF_ActivityAudit_Data10] DEFAULT ('') NOT NULL,
    [DecimalData1]      DECIMAL (18, 4) NULL,
    [DecimalData2]      DECIMAL (18, 4) NULL,
    [DecimalData3]      DECIMAL (18, 4) NULL,
    [DecimalData4]      DECIMAL (18, 4) NULL,
    [DecimalData5]      DECIMAL (18, 4) NULL,
    [DecimalData6]      DECIMAL (18, 4) NULL,
    [DecimalData7]      DECIMAL (18, 4) NULL,
    [DecimalData8]      DECIMAL (18, 4) NULL,
    [DecimalData9]      DECIMAL (18, 4) NULL,
    [DecimalData10]     DECIMAL (18, 4) NULL,
    [BitData1]          BIT             NULL,
    [BitData2]          BIT             NULL,
    [BitData3]          BIT             NULL,
    [BitData4]          BIT             NULL,
    [BitData5]          BIT             NULL,
    [DateData1]         DATETIME        NULL,
    [DateData2]         DATETIME        NULL,
    [DateData3]         DATETIME        NULL,
    [DateData4]         DATETIME        NULL,
    [DateData5]         DATETIME        NULL,
    [LUPUser]           VARCHAR (50)    NULL,
    [LUPDate]           DATETIME        NULL,
    [CreateUser]        VARCHAR (50)    NULL,
    [CreateDate]        DATETIME        NULL,
    CONSTRAINT [PK_ActivityLog] PRIMARY KEY CLUSTERED ([pkActivityLog] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkAgencyLOB]
    ON [dbo].[ActivityLog]([fkAgencyLOB] ASC);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ActivityLog]([fkApplicationUser] ASC);


GO
CREATE NONCLUSTERED INDEX [fkDepartment]
    ON [dbo].[ActivityLog]([fkDepartment] ASC);


GO
CREATE NONCLUSTERED INDEX [fkrefActivityType]
    ON [dbo].[ActivityLog]([fkrefActivityType] ASC);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData10';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable boolean data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'BitData1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable boolean data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'BitData2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable boolean data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'BitData3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable boolean data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'BitData4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable boolean data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'BitData5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable datetime data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DateData1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable datetime data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DateData2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable datetime data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DateData3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable datetime data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DateData4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable datetime data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DateData5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'GUID Identifier for activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'ActivityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key indicating the activity type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'fkrefActivityType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Application User table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Department table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'fkDepartment';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the AgencyLOB table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'fkAgencyLOB';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Parent record to this record, if it exists. Refers to ActivityID', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'ParentActivityID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Timestamp of the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'ActivityDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Machine that initiated the action that created this record', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'MachineName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data7';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data8';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data9';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable character data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'Data10';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData7';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData8';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Variable decimal data field for the activity', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'DecimalData9';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Logs custom user activity, mostly related to the Self Scan Kiosk.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ActivityLog', @level2type = N'COLUMN', @level2name = N'pkActivityLog';

