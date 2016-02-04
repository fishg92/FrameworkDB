CREATE TABLE [dbo].[ApplicationUserCustomAppOrder] (
    [pkApplicationUserCustomAppOrder] DECIMAL (18) IDENTITY (1, 1) NOT NULL,
    [fkApplicationUser]               DECIMAL (18) NOT NULL,
    [fkNCPApplication]                DECIMAL (18) NOT NULL,
    [AppLoadOrder]                    INT          NOT NULL,
    [LUPUser]                         VARCHAR (50) NULL,
    [LUPDate]                         DATETIME     NULL,
    [CreateUser]                      VARCHAR (50) NULL,
    [CreateDate]                      DATETIME     NULL,
    CONSTRAINT [PK_ApplicationUserCustomAppOrder] PRIMARY KEY CLUSTERED ([pkApplicationUserCustomAppOrder] ASC)
);


GO
CREATE NONCLUSTERED INDEX [fkApplicationUser]
    ON [dbo].[ApplicationUserCustomAppOrder]([fkApplicationUser] ASC)
    INCLUDE([fkNCPApplication]);


GO
CREATE NONCLUSTERED INDEX [fkNCPApplication]
    ON [dbo].[ApplicationUserCustomAppOrder]([fkNCPApplication] ASC);


GO
CREATE Trigger [dbo].[tr_ApplicationUserCustomAppOrderAudit_d] On [dbo].[ApplicationUserCustomAppOrder]
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
From ApplicationUserCustomAppOrderAudit dbTable
Inner Join deleted d ON dbTable.[pkApplicationUserCustomAppOrder] = d.[pkApplicationUserCustomAppOrder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserCustomAppOrderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserCustomAppOrder]
	,[fkApplicationUser]
	,[fkNCPApplication]
	,[AppLoadOrder]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkApplicationUserCustomAppOrder]
	,[fkApplicationUser]
	,[fkNCPApplication]
	,[AppLoadOrder]
From  Deleted
GO
CREATE Trigger [dbo].[tr_ApplicationUserCustomAppOrderAudit_UI] On [dbo].[ApplicationUserCustomAppOrder]
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

Update ApplicationUserCustomAppOrder
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserCustomAppOrder dbTable
	Inner Join Inserted i on dbtable.pkApplicationUserCustomAppOrder = i.pkApplicationUserCustomAppOrder
	Left Join Deleted d on d.pkApplicationUserCustomAppOrder = d.pkApplicationUserCustomAppOrder
	Where d.pkApplicationUserCustomAppOrder is null

Update ApplicationUserCustomAppOrder
	 Set [CreateUser] = d.CreateUser
	,[CreateDate] = d.CreateDate
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From ApplicationUserCustomAppOrder dbTable
	Inner Join Deleted d on dbTable.pkApplicationUserCustomAppOrder = d.pkApplicationUserCustomAppOrder
--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From ApplicationUserCustomAppOrderAudit dbTable
Inner Join inserted i ON dbTable.[pkApplicationUserCustomAppOrder] = i.[pkApplicationUserCustomAppOrder]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into ApplicationUserCustomAppOrderAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkApplicationUserCustomAppOrder]
	,[fkApplicationUser]
	,[fkNCPApplication]
	,[AppLoadOrder]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkApplicationUserCustomAppOrder]
	,[fkApplicationUser]
	,[fkNCPApplication]
	,[AppLoadOrder]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'Description', @value = N'This table allows a user to set up a custom order for the list of applications in the bottom left corner of the Pilot screen.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table allows a user to set up a custom order for the list of applications in the bottom left corner of the Pilot screen.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary, self-incrementing ID as primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'pkApplicationUserCustomAppOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to ApplicationUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'fkApplicationUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to NCPApplication', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'fkNCPApplication';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Orders the applications in the tray', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'AppLoadOrder';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ApplicationUserCustomAppOrder', @level2type = N'COLUMN', @level2name = N'CreateDate';

