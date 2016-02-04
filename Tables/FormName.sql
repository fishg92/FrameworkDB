CREATE TABLE [dbo].[FormName] (
    [pkFormName]             DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [FriendlyName]           VARCHAR (255) NOT NULL,
    [SystemName]             VARCHAR (255) NOT NULL,
    [NotToDMS]               TINYINT       NOT NULL,
    [Renditions]             TINYINT       NOT NULL,
    [Status]                 TINYINT       CONSTRAINT [DF_FormName_Status] DEFAULT ((0)) NOT NULL,
    [BarcodeDocType]         VARCHAR (50)  NULL,
    [BarcodeDocTypeName]     VARCHAR (255) NULL,
    [FormDocType]            VARCHAR (50)  NULL,
    [HasBarcode]             BIT           NULL,
    [BarcodeRequired]        INT           CONSTRAINT [DF__FormName__Barcod__3D53FE31] DEFAULT ((0)) NULL,
    [RouteDocument]          SMALLINT      NULL,
    [ForceSubmitOnFavorite]  BIT           NULL,
    [RequireClientSignature] BIT           NULL,
    [SingleUseDocType]       VARCHAR (50)  NULL,
    [SingleUseDocTypeName]   VARCHAR (255) NULL,
    [LUPUser]                VARCHAR (50)  NULL,
    [LUPDate]                DATETIME      NULL,
    [CreateUser]             VARCHAR (50)  NULL,
    [CreateDate]             DATETIME      NULL,
    [DefaultFollowUpDays]    INT           NULL,
    [CompressionWarning]     BIT           CONSTRAINT [DF_FormName_CompressionWarning] DEFAULT ((1)) NULL,
    [PrintRequired]          INT           NULL,
    CONSTRAINT [PK_FormName] PRIMARY KEY CLUSTERED ([pkFormName] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormNameAudit_UI] On [dbo].[FormName]
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

Update FormName
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormName dbTable
	Inner Join Inserted i on dbtable.pkFormName = i.pkFormName
	Left Join Deleted d on d.pkFormName = d.pkFormName
	Where d.pkFormName is null

Update FormName
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormName dbTable
	Inner Join Deleted d on dbTable.pkFormName = d.pkFormName
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormNameAudit dbTable
Inner Join inserted i ON dbTable.[pkFormName] = i.[pkFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormName]
	,[FriendlyName]
	,[SystemName]
	,[NotToDMS]
	,[Renditions]
	,[Status]
	,[BarcodeDocType]
	,[BarcodeDocTypeName]
	,[FormDocType]
	,[HasBarcode]
	,[BarcodeRequired]
	,[RouteDocument]
	,[ForceSubmitOnFavorite]
	,[RequireClientSignature]
	,[SingleUseDocType]
	,[SingleUseDocTypeName]
	,[DefaultFollowUpDays]
	,[CompressionWarning]
	,[PrintRequired]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormName]
	,[FriendlyName]
	,[SystemName]
	,[NotToDMS]
	,[Renditions]
	,[Status]
	,[BarcodeDocType]
	,[BarcodeDocTypeName]
	,[FormDocType]
	,[HasBarcode]
	,[BarcodeRequired]
	,[RouteDocument]
	,[ForceSubmitOnFavorite]
	,[RequireClientSignature]
	,[SingleUseDocType]
	,[SingleUseDocTypeName]
	,[DefaultFollowUpDays]
	,[CompressionWarning]
	,[PrintRequired]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormNameAudit_d] On [dbo].[FormName]
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
From FormNameAudit dbTable
Inner Join deleted d ON dbTable.[pkFormName] = d.[pkFormName]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormNameAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormName]
	,[FriendlyName]
	,[SystemName]
	,[NotToDMS]
	,[Renditions]
	,[Status]
	,[BarcodeDocType]
	,[BarcodeDocTypeName]
	,[FormDocType]
	,[HasBarcode]
	,[BarcodeRequired]
	,[RouteDocument]
	,[ForceSubmitOnFavorite]
	,[RequireClientSignature]
	,[SingleUseDocType]
	,[SingleUseDocTypeName]
	,[DefaultFollowUpDays]
	,[CompressionWarning]
	,[PrintRequired]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormName]
	,[FriendlyName]
	,[SystemName]
	,[NotToDMS]
	,[Renditions]
	,[Status]
	,[BarcodeDocType]
	,[BarcodeDocTypeName]
	,[FormDocType]
	,[HasBarcode]
	,[BarcodeRequired]
	,[RouteDocument]
	,[ForceSubmitOnFavorite]
	,[RequireClientSignature]
	,[SingleUseDocType]
	,[SingleUseDocTypeName]
	,[DefaultFollowUpDays]
	,[CompressionWarning]
	,[PrintRequired]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table replaces the Forms table. It contains all the basic information about a form, including its name, doctype, and other form-wide properites. It is also the table that ties almost all of the other form tables together.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'pkFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name to display in Pilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'FriendlyName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name that the form is referred to with behind the scenes', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'SystemName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether or not the form should be sent to the DMS. In practice, this is usually 0 (for send to DMS).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'NotToDMS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not there are renditions allowed for this form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'Renditions';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The form''s current status. 1 = Production. 2 = Test. 3 = Design. 4 = Deleted.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'Status';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'The doctype that is encoded in the barcode.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'BarcodeDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human readable name of the barcode doctype', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'BarcodeDocTypeName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Form''s doc type.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'FormDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether or not a form has a barcode.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'HasBarcode';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether a barcode is required, optional, or not allowed.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'BarcodeRequired';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates whether to route the docuemnt to no one, to the current user, or to someone that the user chooses.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'RouteDocument';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not to force the form to be submitted when it is stored in the form favorites', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'ForceSubmitOnFavorite';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Are clients required to sign or not', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'RequireClientSignature';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'When the form is used as a single use form, what is the doc type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'SingleUseDocType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Human readable single use doctype name.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'SingleUseDocTypeName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Default length of time for follow up for a task created for this form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'DefaultFollowUpDays';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Whether or not to warn a user if the form they are opening has large, uncompressed images. Turn off for large (~100 page) forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'CompressionWarning';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Should the form not be printed, optionally be printed, or always be printed?', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormName', @level2type = N'COLUMN', @level2name = N'PrintRequired';

