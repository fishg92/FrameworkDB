CREATE TABLE [dbo].[ImportInformation] (
    [pkImportInformation]            DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [Deleted]                        BIT          NULL,
    [EffectiveUser]                  VARCHAR (50) NULL,
    [EffectiveDate]                  DATETIME     NULL,
    [CreateUser]                     VARCHAR (50) NULL,
    [CreateDate]                     DATETIME     NULL,
    [LUPUser]                        VARCHAR (50) NULL,
    [LUPDate]                        DATETIME     NULL,
    [CaseLoad]                       VARCHAR (50) NULL,
    [CaseNumber]                     VARCHAR (50) NULL,
    [LastImportDate]                 DATETIME     NULL,
    [ForceUpdate]                    TINYINT      NULL,
    [MedicaidOnly]                   TINYINT      NULL,
    [Suspect]                        BIT          NULL,
    [IQCPLastDate]                   DATETIME     NULL,
    [IQCPScheduleDate]               DATETIME     NULL,
    [IQCPDueDate]                    DATETIME     NULL,
    [CaseNumberValidatedForCaseLoad] TINYINT      NULL,
    CONSTRAINT [PK_ImportInformation] PRIMARY KEY CLUSTERED ([pkImportInformation] ASC)
);


GO
CREATE NONCLUSTERED INDEX [CaseLoadCaseNumber]
    ON [dbo].[ImportInformation]([CaseLoad] ASC, [CaseNumber] ASC);


GO
CREATE Trigger [dbo].[tr_ImportInformationAudit_d] On [dbo].[ImportInformation]
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
From ImportInformationAudit dbTable
Inner Join deleted d ON dbTable.[pkImportInformation] = d.[pkImportInformation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ImportInformationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkImportInformation]
	,[Deleted]
	,[EffectiveUser]
	,[EffectiveDate]
	,[CaseLoad]
	,[CaseNumber]
	,[LastImportDate]
	,[ForceUpdate]
	,[MedicaidOnly]
	,[Suspect]
	,[IQCPLastDate]
	,[IQCPScheduleDate]
	,[IQCPDueDate]
	,[CaseNumberValidatedForCaseLoad]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkImportInformation]
	,[Deleted]
	,[EffectiveUser]
	,[EffectiveDate]
	,[CaseLoad]
	,[CaseNumber]
	,[LastImportDate]
	,[ForceUpdate]
	,[MedicaidOnly]
	,[Suspect]
	,[IQCPLastDate]
	,[IQCPScheduleDate]
	,[IQCPDueDate]
	,[CaseNumberValidatedForCaseLoad]
From  Deleted
GO

CREATE  Trigger [dbo].[trImportInformationD] on [dbo].[ImportInformation]
for Delete
as
SET NOCOUNT ON;

Declare	@CountDeleted int,
	@NestLevel int

Set @CountDeleted = (Select Count(*) From Deleted)
Set @NestLevel = (Select Trigger_NestLevel())

/* 	Do not allow direct deletes from the table, if the user trys to delete a row, this should be the only 
	trigger that will fire, thus putting the nesting level at 1.  If we modify the deleted flag in the 
	main main table, then the nesting level will be deeper. */

If @CountDeleted > 0 and @NestLevel = 1
begin
	RAISERROR ('Cannot perform a Delete transaction on this data without marking the "Deleted" column with a "1".',16,1)
	Rollback Tran
end
GO
CREATE Trigger [dbo].[tr_ImportInformationAudit_UI] On [dbo].[ImportInformation]
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

Update ImportInformation
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ImportInformation dbTable
	Inner Join Inserted i on dbtable.pkImportInformation = i.pkImportInformation
	Left Join Deleted d on d.pkImportInformation = d.pkImportInformation
	Where d.pkImportInformation is null

Update ImportInformation
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ImportInformation dbTable
	Inner Join Deleted d on dbTable.pkImportInformation = d.pkImportInformation
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ImportInformationAudit dbTable
Inner Join inserted i ON dbTable.[pkImportInformation] = i.[pkImportInformation]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ImportInformationAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkImportInformation]
	,[Deleted]
	,[EffectiveUser]
	,[EffectiveDate]
	,[CaseLoad]
	,[CaseNumber]
	,[LastImportDate]
	,[ForceUpdate]
	,[MedicaidOnly]
	,[Suspect]
	,[IQCPLastDate]
	,[IQCPScheduleDate]
	,[IQCPDueDate]
	,[CaseNumberValidatedForCaseLoad]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkImportInformation]
	,[Deleted]
	,[EffectiveUser]
	,[EffectiveDate]
	,[CaseLoad]
	,[CaseNumber]
	,[LastImportDate]
	,[ForceUpdate]
	,[MedicaidOnly]
	,[Suspect]
	,[IQCPLastDate]
	,[IQCPScheduleDate]
	,[IQCPDueDate]
	,[CaseNumberValidatedForCaseLoad]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ImportInformation', @level2type = N'COLUMN', @level2name = N'pkImportInformation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ImportInformation', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Create Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ImportInformation', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ImportInformation', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = 'Auditing Information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ImportInformation', @level2type = N'COLUMN', @level2name = N'LUPDate';

