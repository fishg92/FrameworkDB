CREATE TABLE [dbo].[FormQuickListAdditionalStamp] (
    [pkFormQuickListAdditionalStamp] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkFormQuickListFormName]        DECIMAL (18)  NOT NULL,
    [Page]                           INT           NOT NULL,
    [X]                              INT           NOT NULL,
    [Y]                              INT           NOT NULL,
    [Width]                          INT           NOT NULL,
    [Height]                         INT           NOT NULL,
    [Bitmap]                         IMAGE         NULL,
    [fkrefAnnotationType]            DECIMAL (18)  NOT NULL,
    [AdditionalData]                 VARCHAR (MAX) NULL,
    [LUPUser]                        VARCHAR (50)  NULL,
    [LUPDate]                        DATETIME      NULL,
    [CreateUser]                     VARCHAR (50)  NULL,
    [CreateDate]                     DATETIME      NULL,
    CONSTRAINT [PK_FormQuickListAdditionalStamp] PRIMARY KEY CLUSTERED ([pkFormQuickListAdditionalStamp] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkFormQuickListFormName]
    ON [dbo].[FormQuickListAdditionalStamp]([fkFormQuickListFormName] ASC) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [fkrefAnnotationType]
    ON [dbo].[FormQuickListAdditionalStamp]([fkrefAnnotationType] ASC);


GO
CREATE Trigger [dbo].[tr_FormQuickListAdditionalStampAudit_d] On [dbo].[FormQuickListAdditionalStamp]
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
From FormQuickListAdditionalStampAudit dbTable
Inner Join deleted d ON dbTable.[pkFormQuickListAdditionalStamp] = d.[pkFormQuickListAdditionalStamp]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListAdditionalStampAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListAdditionalStamp]
	,[fkFormQuickListFormName]
	,[Page]
	,[X]
	,[Y]
	,[Width]
	,[Height]
	,[Bitmap]
	,[fkrefAnnotationType]
	,[AdditionalData]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormQuickListAdditionalStamp]
	,[fkFormQuickListFormName]
	,[Page]
	,[X]
	,[Y]
	,[Width]
	,[Height]
	,null
	,[fkrefAnnotationType]
	,[AdditionalData]
From  Deleted
GO
CREATE Trigger [dbo].[tr_FormQuickListAdditionalStampAudit_UI] On [dbo].[FormQuickListAdditionalStamp]
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

Update FormQuickListAdditionalStamp
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListAdditionalStamp dbTable
	Inner Join Inserted i on dbtable.pkFormQuickListAdditionalStamp = i.pkFormQuickListAdditionalStamp
	Left Join Deleted d on d.pkFormQuickListAdditionalStamp = d.pkFormQuickListAdditionalStamp
	Where d.pkFormQuickListAdditionalStamp is null

Update FormQuickListAdditionalStamp
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormQuickListAdditionalStamp dbTable
	Inner Join Deleted d on dbTable.pkFormQuickListAdditionalStamp = d.pkFormQuickListAdditionalStamp
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormQuickListAdditionalStampAudit dbTable
Inner Join inserted i ON dbTable.[pkFormQuickListAdditionalStamp] = i.[pkFormQuickListAdditionalStamp]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormQuickListAdditionalStampAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormQuickListAdditionalStamp]
	,[fkFormQuickListFormName]
	,[Page]
	,[X]
	,[Y]
	,[Width]
	,[Height]
	,[Bitmap]
	,[fkrefAnnotationType]
	,[AdditionalData]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormQuickListAdditionalStamp]
	,[fkFormQuickListFormName]
	,[Page]
	,[X]
	,[Y]
	,[Width]
	,[Height]
	,null
	,[fkrefAnnotationType]
	,[AdditionalData]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains information regarding quick objects and their placement on forms.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'pkFormQuickListAdditionalStamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the QuickListFormName table.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'fkFormQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'On which page does this quick object appear on the form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'Page';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'X coordinate of the upper left corner', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'X';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'T coordinate of the upper left corner', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'Y';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Width (in pixels) of the quick object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'Width';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Height (in pixels) of the quick object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'Height';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary info of the image', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'Bitmap';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the refAnnotationType table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'fkrefAnnotationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ad hoc text of other textual information for the quick object', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'AdditionalData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormQuickListAdditionalStamp', @level2type = N'COLUMN', @level2name = N'CreateDate';

