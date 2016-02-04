CREATE TABLE [dbo].[FormFavoriteDrawingLayer] (
    [Id]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [FavoriteId]  BIGINT          NOT NULL,
    [PageNumber]  INT             NOT NULL,
    [DrawingData] VARBINARY (MAX) NOT NULL,
    [CreateUser]  VARCHAR (50)    NULL,
    [LUPUser]     VARCHAR (50)    NULL,
    [CreateDate]  DATETIME2 (7)   NULL,
    [LUPDate]     DATETIME2 (7)   NULL,
    CONSTRAINT [PK_FormFavoriteDrawingLayer] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO

CREATE Trigger [dbo].[tr_FormFavoriteDrawingLayerAudit_d] On [dbo].[FormFavoriteDrawingLayer]
FOR Delete
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditMachine varchar(15)
		,@Date datetime2(7)

select @Date = SYSDATETIME()
		,@AuditUser = host_name()
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--End the current audit record
Update dbTable
	Set AuditEndDate = @Date
From FormFavoriteDrawingLayerAudit dbTable
Inner Join deleted d ON dbTable.[Id] = d.[Id]
Where dbTable.AuditEndDate is null

--Create new audit record
Insert into FormFavoriteDrawingLayerAudit
	(
		AuditStartDate
		, AuditEndDate
		, AuditUser
		, AuditMachine
		, AuditDeleted
		,[Id]
		,[FavoriteId]
		,[PageNumber]
		--We don't want to store the drawing data multiple times
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[Id]
	,[FavoriteId]
	,[PageNumber]
From  Deleted
GO

CREATE Trigger [dbo].[tr_FormFavoriteDrawingLayerAudit_UI] On [dbo].[FormFavoriteDrawingLayer]
FOR INSERT, UPDATE
As
SET NOCOUNT ON;

Declare @AuditUser varchar(50)
		,@AuditEndDate datetime2(7)
		,@AuditMachine varchar(15)
		,@Date datetime2(7)
		,@HostName varchar(50)

select @HostName = host_name()
		,@Date = SYSDATETIME()
		,@AuditUser = @HostName
		,@AuditMachine = ''
		
exec [dbo].[GetAuditDataFromContext] @AuditUser = @AuditUser output ,@AuditMachine = @AuditMachine output

--Insert Base Table
Update FormFavoriteDrawingLayer
	 Set [CreateUser] = @AuditUser
	,[CreateDate] = @Date
	,[LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFavoriteDrawingLayer dbTable
	Inner Join Inserted i on dbtable.Id = i.Id
	Left Join Deleted d on d.Id = d.Id
	Where d.Id is null

--Update Base Table
Update FormFavoriteDrawingLayer
	 Set [LUPUser] = @AuditUser
	,[LUPDate] = @Date
	From FormFavoriteDrawingLayer dbTable
	Inner Join Deleted d on dbTable.Id = d.Id

--Update Audit EndDate
Update dbTable
	Set AuditEndDate = @Date
From FormFavoriteDrawingLayerAudit dbTable
Inner Join inserted i ON dbTable.[Id] = i.[Id]
Where dbTable.AuditEndDate is null

--Create new audit record
Insert into FormFavoriteDrawingLayerAudit
	(
		AuditStartDate
		, AuditEndDate
		, AuditUser
		, AuditMachine
		, AuditDeleted
		,[Id]
		,[FavoriteId]
		,[PageNumber]
		--We don't want to store the drawing data multiple times
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[Id]
	,[FavoriteId]
	,[PageNumber]

From  Inserted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Table contains CoPilot drawings for Form Favorites shipped back from CoPilot', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Id with primary key', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'Id';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Id of the favorite that the drawing belongs to', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'FavoriteId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Page number of the drawing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'PageNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Binary data of the drawing', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'DrawingData';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: CreateUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: LUPUser', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: CreateDate', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FormFavoriteDrawingLayer', @level2type = N'COLUMN', @level2name = N'LUPDate';

