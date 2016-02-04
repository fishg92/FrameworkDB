CREATE TABLE [dbo].[FormPeerReviewNote] (
    [pkFormPeerReviewNote] DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [fkQuickListFormName]  DECIMAL (18)  NOT NULL,
    [Note]                 VARCHAR (255) NOT NULL,
    [PageNumber]           INT           NOT NULL,
    [X]                    INT           NOT NULL,
    [Y]                    INT           NOT NULL,
    [LUPUser]              VARCHAR (50)  NULL,
    [LUPDate]              DATETIME      NULL,
    [CreateUser]           VARCHAR (50)  NULL,
    [CreateDate]           DATETIME      NULL,
    CONSTRAINT [PK_FormPeerReviewNote] PRIMARY KEY CLUSTERED ([pkFormPeerReviewNote] ASC)
);


GO
CREATE Trigger [dbo].[tr_FormPeerReviewNoteAudit_ui] On [dbo].[FormPeerReviewNote]
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

Update FormPeerReviewNote
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPeerReviewNote dbTable
	Inner Join Inserted i on dbtable.pkFormPeerReviewNote = i.pkFormPeerReviewNote
	Left Join Deleted d on d.pkFormPeerReviewNote = d.pkFormPeerReviewNote
	Where d.pkFormPeerReviewNote is null

Update FormPeerReviewNote
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormPeerReviewNote dbTable
	Inner Join Deleted d on dbTable.pkFormPeerReviewNote = d.pkFormPeerReviewNote
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormPeerReviewNoteAudit dbTable
Inner Join inserted i ON dbTable.[pkFormPeerReviewNote] = i.[pkFormPeerReviewNote]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPeerReviewNoteAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPeerReviewNote]
	,[fkQuickListFormName]
	,[Note]
	,[PageNumber]
	,[X]
	,[Y]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkFormPeerReviewNote]
	,[fkQuickListFormName]
	,[Note]
	,[PageNumber]
	,[X]
	,[Y]

From  Inserted
GO
CREATE Trigger [dbo].[tr_FormPeerReviewNoteAudit_d] On [dbo].[FormPeerReviewNote]
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
From FormPeerReviewNoteAudit dbTable
Inner Join deleted d ON dbTable.[pkFormPeerReviewNote] = d.[pkFormPeerReviewNote]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into FormPeerReviewNoteAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkFormPeerReviewNote]
	,[fkQuickListFormName]
	,[Note]
	,[PageNumber]
	,[X]
	,[Y]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkFormPeerReviewNote]
	,[fkQuickListFormName]
	,[Note]
	,[PageNumber]
	,[X]
	,[Y]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table holds the sticky  notes associated with a form.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'pkFormPeerReviewNote';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the form name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'fkQuickListFormName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Text of the sticky note.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'Note';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Page on which the sticky note should appear.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Position on the X axis of the upper left corner of the note.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'X';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Position on the Y axis of the upper left sticky note.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'Y';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormPeerReviewNote', @level2type = N'COLUMN', @level2name = N'CreateDate';

