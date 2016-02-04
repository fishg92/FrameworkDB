CREATE TABLE [dbo].[refTransferUser] (
    [pkRefTransferUser] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [UserName]          VARCHAR (50) NOT NULL,
    [Active]            BIT          NOT NULL,
    [LUPUser]           VARCHAR (50) NULL,
    [LUPDate]           DATETIME     CONSTRAINT [DF_refTransferUser_LUPDate] DEFAULT (getdate()) NOT NULL,
    [CreateUser]        VARCHAR (50) NULL,
    [CreateDate]        DATETIME     CONSTRAINT [DF_refTransferUser_CreateDate] DEFAULT (getdate()) NOT NULL,
    [CountyNum]         INT          CONSTRAINT [DF_refTransferUser_CountyNum] DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_refTransferUser] PRIMARY KEY CLUSTERED ([pkRefTransferUser] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Is the user still active (1=yes)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'Active';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'County number for the user', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'CountyNum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table is a reference listing for users that are transfered in the system.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'pkRefTransferUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Username for the user to be transferred', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'refTransferUser', @level2type = N'COLUMN', @level2name = N'UserName';

