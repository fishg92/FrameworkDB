CREATE TABLE [dbo].[CPClientExternalID] (
    [pkCPClientExternalID] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkCPClient]           DECIMAL (18) NOT NULL,
    [ExternalSystemName]   VARCHAR (50) NOT NULL,
    [ExternalSystemID]     VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CPClientExternalID] PRIMARY KEY CLUSTERED ([pkCPClientExternalID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [fkCPClient_ExternalSystemName]
    ON [dbo].[CPClientExternalID]([fkCPClient] ASC, [ExternalSystemName] ASC);


GO
CREATE NONCLUSTERED INDEX [ExternalSystemID_ExternalSystemName]
    ON [dbo].[CPClientExternalID]([ExternalSystemID] ASC, [ExternalSystemName] ASC);


GO
CREATE Trigger [dbo].[tr_CPClientExternalIDAudit_d] On [dbo].[CPClientExternalID]
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
From CPClientExternalIDAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClientExternalID] = d.[pkCPClientExternalID]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientExternalIDAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientExternalID]
	,[fkCPClient]
	,[ExternalSystemName]
	,[ExternalSystemID]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClientExternalID]
	,[fkCPClient]
	,[ExternalSystemName]
	,[ExternalSystemID]
From  Deleted
GO
CREATE Trigger [dbo].[tr_CPClientExternalIDAudit_UI] On [dbo].[CPClientExternalID]
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
From CPClientExternalIDAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClientExternalID] = i.[pkCPClientExternalID]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientExternalIDAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClientExternalID]
	,[fkCPClient]
	,[ExternalSystemName]
	,[ExternalSystemID]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClientExternalID]
	,[fkCPClient]
	,[ExternalSystemName]
	,[ExternalSystemID]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table associates People clients with an external ID value and the name of the system that ID comes from.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientExternalID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, auto-incrementing system ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientExternalID', @level2type = N'COLUMN', @level2name = N'pkCPClientExternalID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to the Client table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientExternalID', @level2type = N'COLUMN', @level2name = N'fkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of the external system that to map to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientExternalID', @level2type = N'COLUMN', @level2name = N'ExternalSystemName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID number to use to map People user to the external system', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClientExternalID', @level2type = N'COLUMN', @level2name = N'ExternalSystemID';

