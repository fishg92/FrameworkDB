CREATE TABLE [dbo].[CPClientCustomAttribute] (
    [pkCPClientCustomAttribute] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkCPClient]                DECIMAL (18)  NOT NULL,
    [DATA1]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA1] DEFAULT ('') NULL,
    [DATA2]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA2] DEFAULT ('') NULL,
    [DATA3]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA3] DEFAULT ('') NULL,
    [DATA4]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA4] DEFAULT ('') NULL,
    [DATA5]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA5] DEFAULT ('') NULL,
    [DATA6]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA6] DEFAULT ('') NULL,
    [DATA7]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA7] DEFAULT ('') NULL,
    [DATA8]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA8] DEFAULT ('') NULL,
    [DATA9]                     VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA9] DEFAULT ('') NULL,
    [DATA10]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA10] DEFAULT ('') NULL,
    [DATA11]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA11] DEFAULT ('') NULL,
    [DATA12]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA12] DEFAULT ('') NULL,
    [DATA13]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA13] DEFAULT ('') NULL,
    [DATA14]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA14] DEFAULT ('') NULL,
    [DATA15]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA15] DEFAULT ('') NULL,
    [DATA16]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA16] DEFAULT ('') NULL,
    [DATA17]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA17] DEFAULT ('') NULL,
    [DATA18]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA18] DEFAULT ('') NULL,
    [DATA19]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA19] DEFAULT ('') NULL,
    [DATA20]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA20] DEFAULT ('') NULL,
    [DATA21]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA21] DEFAULT ('') NULL,
    [DATA22]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA22] DEFAULT ('') NULL,
    [DATA23]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA23] DEFAULT ('') NULL,
    [DATA24]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA24] DEFAULT ('') NULL,
    [DATA25]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA25] DEFAULT ('') NULL,
    [DATA26]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA26] DEFAULT ('') NULL,
    [DATA27]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA27] DEFAULT ('') NULL,
    [DATA28]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA28] DEFAULT ('') NULL,
    [DATA29]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA29] DEFAULT ('') NULL,
    [DATA30]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA30] DEFAULT ('') NULL,
    [DATA31]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA31] DEFAULT ('') NULL,
    [DATA32]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA32] DEFAULT ('') NULL,
    [DATA33]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA33] DEFAULT ('') NULL,
    [DATA34]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA34] DEFAULT ('') NULL,
    [DATA35]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA35] DEFAULT ('') NULL,
    [DATA36]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA36] DEFAULT ('') NULL,
    [DATA37]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA37] DEFAULT ('') NULL,
    [DATA38]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA38] DEFAULT ('') NULL,
    [DATA39]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA39] DEFAULT ('') NULL,
    [DATA40]                    VARCHAR (250) CONSTRAINT [DF_CPClientCustomAttribute_DATA40] DEFAULT ('') NULL,
    [LUPUser]                   VARCHAR (50)  NULL,
    [LUPDate]                   DATETIME      NULL,
    [CreateUser]                VARCHAR (50)  NULL,
    [CreateDate]                DATETIME      NULL,
    [DataChecksum]              AS            (checksum([Data1],[Data2],[Data3],[Data4],[Data5],[Data6],[Data7],[Data8],[Data9],[Data10],[Data11],[Data12],[Data13],[Data14],[Data15],[Data16],[Data17],[Data18],[Data19],[Data20],[Data21],[Data22],[Data23],[Data24],[Data25],[Data26],[Data27],[Data28],[Data29],[Data30],[Data31],[Data32],[Data33],[Data34],[Data35],[Data36],[Data37],[Data38],[Data39],[Data40])) PERSISTED,
    CONSTRAINT [PK_CPClientCustomAttribute] PRIMARY KEY NONCLUSTERED ([pkCPClientCustomAttribute] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CPClientCustomAttributefkCpClientChecksum]
    ON [dbo].[CPClientCustomAttribute]([fkCPClient] ASC, [DataChecksum] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientCustomAttributeAudit_d] On [dbo].[CPClientCustomAttribute]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime

select @Date = getdate()
select @AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientCustomAttributeAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientCustomAttribute] = d.[pkCPClientCustomAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientCustomAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientCustomAttribute]
	,[fkCPClient]
	,[DATA1]
	,[DATA2]
	,[DATA3]
	,[DATA4]
	,[DATA5]
	,[DATA6]
	,[DATA7]
	,[DATA8]
	,[DATA9]
	,[DATA10]
	,[DATA11]
	,[DATA12]
	,[DATA13]
	,[DATA14]
	,[DATA15]
	,[DATA16]
	,[DATA17]
	,[DATA18]
	,[DATA19]
	,[DATA20]
	,[DATA21]
	,[DATA22]
	,[DATA23]
	,[DATA24]
	,[DATA25]
	,[DATA26]
	,[DATA27]
	,[DATA28]
	,[DATA29]
	,[DATA30]
	,[DATA31]
	,[DATA32]
	,[DATA33]
	,[DATA34]
	,[DATA35]
	,[DATA36]
	,[DATA37]
	,[DATA38]
	,[DATA39]
	,[DATA40]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientCustomAttribute]
	,[fkCPClient]
	,[DATA1]
	,[DATA2]
	,[DATA3]
	,[DATA4]
	,[DATA5]
	,[DATA6]
	,[DATA7]
	,[DATA8]
	,[DATA9]
	,[DATA10]
	,[DATA11]
	,[DATA12]
	,[DATA13]
	,[DATA14]
	,[DATA15]
	,[DATA16]
	,[DATA17]
	,[DATA18]
	,[DATA19]
	,[DATA20]
	,[DATA21]
	,[DATA22]
	,[DATA23]
	,[DATA24]
	,[DATA25]
	,[DATA26]
	,[DATA27]
	,[DATA28]
	,[DATA29]
	,[DATA30]
	,[DATA31]
	,[DATA32]
	,[DATA33]
	,[DATA34]
	,[DATA35]
	,[DATA36]
	,[DATA37]
	,[DATA38]
	,[DATA39]
	,[DATA40]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPClientCustomAttributeAudit_UI] On [dbo].[CPClientCustomAttribute]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime
		,@AuditMachine varchar(15)
		,@Date datetime
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = getdate()

select @AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

Update CPClientCustomAttribute
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientCustomAttribute dbTable
	Inner Join Inserted i on dbtable.pkCPClientCustomAttribute = i.pkCPClientCustomAttribute
	Left Join Deleted d on d.pkCPClientCustomAttribute = d.pkCPClientCustomAttribute
	Where d.pkCPClientCustomAttribute is null

Update CPClientCustomAttribute
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From CPClientCustomAttribute dbTable
	Inner Join Deleted d on dbTable.pkCPClientCustomAttribute = d.pkCPClientCustomAttribute
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientCustomAttributeAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientCustomAttribute] = i.[pkCPClientCustomAttribute]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientCustomAttributeAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientCustomAttribute]
	,[fkCPClient]
	,[DATA1]
	,[DATA2]
	,[DATA3]
	,[DATA4]
	,[DATA5]
	,[DATA6]
	,[DATA7]
	,[DATA8]
	,[DATA9]
	,[DATA10]
	,[DATA11]
	,[DATA12]
	,[DATA13]
	,[DATA14]
	,[DATA15]
	,[DATA16]
	,[DATA17]
	,[DATA18]
	,[DATA19]
	,[DATA20]
	,[DATA21]
	,[DATA22]
	,[DATA23]
	,[DATA24]
	,[DATA25]
	,[DATA26]
	,[DATA27]
	,[DATA28]
	,[DATA29]
	,[DATA30]
	,[DATA31]
	,[DATA32]
	,[DATA33]
	,[DATA34]
	,[DATA35]
	,[DATA36]
	,[DATA37]
	,[DATA38]
	,[DATA39]
	,[DATA40]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientCustomAttribute]
	,[fkCPClient]
	,[DATA1]
	,[DATA2]
	,[DATA3]
	,[DATA4]
	,[DATA5]
	,[DATA6]
	,[DATA7]
	,[DATA8]
	,[DATA9]
	,[DATA10]
	,[DATA11]
	,[DATA12]
	,[DATA13]
	,[DATA14]
	,[DATA15]
	,[DATA16]
	,[DATA17]
	,[DATA18]
	,[DATA19]
	,[DATA20]
	,[DATA21]
	,[DATA22]
	,[DATA23]
	,[DATA24]
	,[DATA25]
	,[DATA26]
	,[DATA27]
	,[DATA28]
	,[DATA29]
	,[DATA30]
	,[DATA31]
	,[DATA32]
	,[DATA33]
	,[DATA34]
	,[DATA35]
	,[DATA36]
	,[DATA37]
	,[DATA38]
	,[DATA39]
	,[DATA40]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains a set of custom data fields to include information for clients that is configurable on a per site basis.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'pkCPClientCustomAttribute';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the CPClient table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA1';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA3';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA4';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA5';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA6';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA7';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA8';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA9';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA10';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA11';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA12';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA13';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA14';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA15';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA16';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA17';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA18';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA19';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA20';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA21';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA22';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA23';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA24';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA25';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA26';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA27';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA28';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA29';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA30';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA31';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA32';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA33';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA34';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA35';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA36';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA37';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA38';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA39';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'User defined custom field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DATA40';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Checksum to determine if the CPClient Custom data needs to be updated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientCustomAttribute', @level2type = N'COLUMN', @level2name = N'DataChecksum';

