CREATE TABLE [dbo].[FormQuickListAutoFillValue] (
    [pkFormQuickListAutoFillValue]       DECIMAL (18)   IDENTITY (1, 1) NOT NULL,
    [fkFormQuickListFormName]            DECIMAL (18)   NOT NULL,
    [KeyWordName]                        VARCHAR (50)   NOT NULL,
    [RowNumber]                          INT            NOT NULL,
    [fkFormQuickListAutoFillValueSmall]  DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueMedium] DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueLarge]  DECIMAL (18)   NULL,
    [fkFormQuickListAutoFillValueHuge]   DECIMAL (18)   NULL,
    [LUPUser]                            VARCHAR (50)   NULL,
    [LUPDate]                            DATETIME       NULL,
    [CreateUser]                         VARCHAR (50)   NULL,
    [CreateDate]                         DATETIME       NULL,
    [FormQuickListAutoFillValue]         VARCHAR (5000) NULL,
    [AutoFillGroupName]                  VARCHAR (50)   NULL,
    CONSTRAINT [PK_FormQuickListAutoFillValue] PRIMARY KEY CLUSTERED ([pkFormQuickListAutoFillValue] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFormName]
    ON [dbo].[FormQuickListAutoFillValue]([fkFormQuickListFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE Trigger [dbo].[tr_FormQuickListAutoFillValueAudit_d] On [dbo].[FormQuickListAutoFillValue]
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
From FormQuickListAutoFillValueAudit dbTable
Inner Join deleted d ON dbTable.[pkFormQuickListAutoFillValue] = d.[pkFormQuickListAutoFillValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListAutoFillValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListAutoFillValue]
	,[fkFormQuickListFormName]
	,[KeyWordName]
	,[RowNumber]
	,[fkFormQuickListAutoFillValueSmall]
	,[fkFormQuickListAutoFillValueMedium]
	,[fkFormQuickListAutoFillValueLarge]
	,[fkFormQuickListAutoFillValueHuge]
	,[FormQuickListAutoFillValue]
	,[AutoFillGroupName]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormQuickListAutoFillValue]
	,[fkFormQuickListFormName]
	,[KeyWordName]
	,[RowNumber]
	,[fkFormQuickListAutoFillValueSmall]
	,[fkFormQuickListAutoFillValueMedium]
	,[fkFormQuickListAutoFillValueLarge]
	,[fkFormQuickListAutoFillValueHuge]
	,[FormQuickListAutoFillValue]
	,[AutoFillGroupName]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormQuickListAutoFillValueAudit_UI] On [dbo].[FormQuickListAutoFillValue]
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

Update FormQuickListAutoFillValue
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListAutoFillValue dbTable
	Inner Join Inserted i on dbtable.pkFormQuickListAutoFillValue = i.pkFormQuickListAutoFillValue
	Left Join Deleted d on d.pkFormQuickListAutoFillValue = d.pkFormQuickListAutoFillValue
	Where d.pkFormQuickListAutoFillValue is null

Update FormQuickListAutoFillValue
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListAutoFillValue dbTable
	Inner Join Deleted d on dbTable.pkFormQuickListAutoFillValue = d.pkFormQuickListAutoFillValue
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormQuickListAutoFillValueAudit dbTable
Inner Join inserted i ON dbTable.[pkFormQuickListAutoFillValue] = i.[pkFormQuickListAutoFillValue]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListAutoFillValueAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListAutoFillValue]
	,[fkFormQuickListFormName]
	,[KeyWordName]
	,[RowNumber]
	,[fkFormQuickListAutoFillValueSmall]
	,[fkFormQuickListAutoFillValueMedium]
	,[fkFormQuickListAutoFillValueLarge]
	,[fkFormQuickListAutoFillValueHuge]
	,[FormQuickListAutoFillValue]
	,[AutoFillGroupName]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormQuickListAutoFillValue]
	,[fkFormQuickListFormName]
	,[KeyWordName]
	,[RowNumber]
	,[fkFormQuickListAutoFillValueSmall]
	,[fkFormQuickListAutoFillValueMedium]
	,[fkFormQuickListAutoFillValueLarge]
	,[fkFormQuickListAutoFillValueHuge]
	,[FormQuickListAutoFillValue]
	,[AutoFillGroupName]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains the values for a form''s autofill data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'pkFormQuickListAutoFillValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the QuickListFormName table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Keyword name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'KeyWordName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Indicates the different people indexed by the autofill', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'RowNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'fkFormQuickListAutoFillValueSmall';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'fkFormQuickListAutoFillValueMedium';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'fkFormQuickListAutoFillValueLarge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'DEPRECATED', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'fkFormQuickListAutoFillValueHuge';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value for the autofill field', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'FormQuickListAutoFillValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Group Name for the Autofill values', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAutoFillValue', @level2type = N'COLUMN', @level2name = N'AutoFillGroupName';

