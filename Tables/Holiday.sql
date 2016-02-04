CREATE TABLE [dbo].[Holiday] (
    [pkHoliday]   DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [HolidayDate] DATETIME     NOT NULL,
    CONSTRAINT [PK_Holiday] PRIMARY KEY CLUSTERED ([pkHoliday] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_Holiday]
    ON [dbo].[Holiday]([HolidayDate] ASC);


GO
CREATE Trigger [dbo].[tr_HolidayAudit_UI] On [dbo].[Holiday]
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


--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From HolidayAudit dbTable
Inner Join inserted i ON dbTable.[pkHoliday] = i.[pkHoliday]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into HolidayAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkHoliday]
	,[HolidayDate]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkHoliday]
	,[HolidayDate]

From  Inserted
GO
CREATE Trigger [dbo].[tr_HolidayAudit_d] On [dbo].[Holiday]
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
From HolidayAudit dbTable
Inner Join deleted d ON dbTable.[pkHoliday] = d.[pkHoliday]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into HolidayAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkHoliday]
	,[HolidayDate]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkHoliday]
	,[HolidayDate]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'List of dates that should be excluded for purposes of calculation of follow up dates by business day. Weekend days are automatically excluded.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Holiday';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Holiday', @level2type = N'COLUMN', @level2name = N'pkHoliday';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Date of the holiday', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Holiday', @level2type = N'COLUMN', @level2name = N'HolidayDate';

