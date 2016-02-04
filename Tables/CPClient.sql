CREATE TABLE [dbo].[CPClient] (
    [pkCPClient]                 DECIMAL (18)  IDENTITY (1, 1) NOT NULL,
    [LastName]                   VARCHAR (100) NULL,
    [FirstName]                  VARCHAR (100) NULL,
    [MiddleName]                 VARCHAR (100) NULL,
    [SSN]                        CHAR (10)     NULL,
    [NorthwoodsNumber]           VARCHAR (50)  NULL,
    [StateIssuedNumber]          VARCHAR (50)  NULL,
    [BirthDate]                  DATETIME      NULL,
    [BirthLocation]              VARCHAR (100) NULL,
    [Sex]                        CHAR (1)      NULL,
    [fkCPRefClientEducationType] DECIMAL (18)  NULL,
    [LockedUser]                 VARCHAR (20)  NULL,
    [LockedDate]                 DATETIME      NULL,
    [FormattedSSN]               AS            ((((substring(right('1000000000'+[SSN],(10)),(1),(3))+'-')+substring(right('1000000000'+[SSN],(10)),(4),(2)))+'-')+substring(right('1000000000'+[SSN],(10)),(6),(4))) PERSISTED,
    [MaidenName]                 VARCHAR (100) NULL,
    [LUPUser]                    VARCHAR (50)  NULL,
    [LUPDate]                    DATETIME      NULL,
    [CreateUser]                 VARCHAR (50)  NULL,
    [CreateDate]                 DATETIME      NULL,
    [Suffix]                     VARCHAR (20)  NULL,
    [SISNumber]                  VARCHAR (11)  NULL,
    [SchoolName]                 VARCHAR (100) NULL,
    [HomePhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClient__HomePh__203AFE9B] DEFAULT ('') NOT NULL,
    [CellPhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClient__CellPh__212F22D4] DEFAULT ('') NOT NULL,
    [WorkPhone]                  VARCHAR (10)  CONSTRAINT [DF__CPClient__WorkPh__2223470D] DEFAULT ('') NOT NULL,
    [WorkPhoneExt]               VARCHAR (10)  CONSTRAINT [DF__CPClient__WorkPh__23176B46] DEFAULT ('') NOT NULL,
    [DataCheckSum]               AS            (checksum([FirstName],[MiddleName],[LastName],[Suffix],[MaidenName],[SSN],[StateIssuedNumber],[BirthDate],[BirthLocation],[SchoolName],[Sex],[HomePhone],[CellPhone],[fkcprefclienteducationType],[Email])) PERSISTED,
    [Email]                      VARCHAR (250) NULL,
    CONSTRAINT [PK_CPClient] PRIMARY KEY NONCLUSTERED ([pkCPClient] ASC)
);


GO
CREATE NONCLUSTERED INDEX [idxClientFirstName]
    ON [dbo].[CPClient]([FirstName] ASC)
    INCLUDE([pkCPClient]);


GO
CREATE NONCLUSTERED INDEX [idxClientLastName]
    ON [dbo].[CPClient]([LastName] ASC, [FirstName] ASC)
    INCLUDE([pkCPClient]);


GO
CREATE NONCLUSTERED INDEX [idxNorthwoodsNumber]
    ON [dbo].[CPClient]([NorthwoodsNumber] ASC)
    INCLUDE([pkCPClient]) WITH (ALLOW_PAGE_LOCKS = OFF);


GO
CREATE NONCLUSTERED INDEX [idxClientSSN]
    ON [dbo].[CPClient]([SSN] ASC)
    INCLUDE([pkCPClient]);


GO
CREATE NONCLUSTERED INDEX [idxStateIssuedNumber]
    ON [dbo].[CPClient]([StateIssuedNumber] ASC)
    INCLUDE([pkCPClient]);


GO
CREATE NONCLUSTERED INDEX [fkCPRefClientEducationType]
    ON [dbo].[CPClient]([fkCPRefClientEducationType] ASC);


GO
CREATE NONCLUSTERED INDEX [FormattedSSN]
    ON [dbo].[CPClient]([FormattedSSN] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_CPClientChecksum]
    ON [dbo].[CPClient]([DataCheckSum] ASC);


GO
CREATE Trigger tr_CPClientAudit_UI On CPClient
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

Update CPClient
	 Set [CreateUser] = @AuditUser
,[CreateDate] = @Date
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From CPClient dbTable
	Inner Join Inserted i on dbtable.pkCPClient = i.pkCPClient
	Left Join Deleted d on d.pkCPClient = d.pkCPClient
	Where d.pkCPClient is null

Update CPClient
	 Set [CreateUser] = d.CreateUser
,[CreateDate] = d.CreateDate
,[LUPUser] = @AuditUser
,[LUPDate] = @Date
	From CPClient dbTable
	Inner Join Deleted d on dbTable.pkCPClient = d.pkCPClient

--End date current audit record
Update dbTable
	Set AuditEndDate = @Date
From CPClientAudit dbTable
Inner Join inserted i ON dbTable.[pkCPClient] = i.[pkCPClient]
Where dbTable.AuditEndDate is null

Update CPClient
	set CPClient.NorthwoodsNumber =	case when CPClient.NorthwoodsNumber = '' then
								dbo.GetNorthwoodsNumber(CPClient.pkCPClient)
							else
								CPClient.NorthwoodsNumber
							end
From CPClient 
Inner Join inserted i ON CPClient.[pkCPClient] = i.[pkCPClient]
--create new audit record
Insert into CPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClient]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[SSN]
	,[NorthwoodsNumber]
	,[StateIssuedNumber]
	,[BirthDate]
	,[BirthLocation]
	,[Sex]
	,[fkCPRefClientEducationType]
	,[LockedUser]
	,[LockedDate]
	,[FormattedSSN]
	,[MaidenName]
	,[Suffix]
	,[SISNumber]
	,[SchoolName]
	,[HomePhone]
	,[CellPhone]
	,[WorkPhone]
	,[WorkPhoneExt]
	,[DataCheckSum]
	,[Email]

	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 0
	,[pkCPClient]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[SSN]
	,[NorthwoodsNumber]
	,[StateIssuedNumber]
	,[BirthDate]
	,[BirthLocation]
	,[Sex]
	,[fkCPRefClientEducationType]
	,[LockedUser]
	,[LockedDate]
	,[FormattedSSN]
	,[MaidenName]
	,[Suffix]
	,[SISNumber]
	,[SchoolName]
	,[HomePhone]
	,[CellPhone]
	,[WorkPhone]
	,[WorkPhoneExt]
	,[DataCheckSum]
	,[Email]

From  Inserted
GO
CREATE Trigger tr_CPClientAudit_d On CPClient
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
From CPClientAudit dbTable
Inner Join deleted d ON dbTable.[pkCPClient] = d.[pkCPClient]
Where dbTable.AuditEndDate is null

--create new audit record
Insert into CPClientAudit
	(
	AuditStartDate
	, AuditEndDate
	, AuditUser
	, AuditMachine
	, AuditDeleted
	,[pkCPClient]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[SSN]
	,[NorthwoodsNumber]
	,[StateIssuedNumber]
	,[BirthDate]
	,[BirthLocation]
	,[Sex]
	,[fkCPRefClientEducationType]
	,[LockedUser]
	,[LockedDate]
	,[FormattedSSN]
	,[MaidenName]
	,[Suffix]
	,[SISNumber]
	,[SchoolName]
	,[HomePhone]
	,[CellPhone]
	,[WorkPhone]
	,[WorkPhoneExt]
	,[DataCheckSum]
	,[Email]
	)
	Select
	@Date
	, AuditEndDate = null
	, @AuditUser
	, @AuditMachine
	, AuditDeleted = 1
	,[pkCPClient]
	,[LastName]
	,[FirstName]
	,[MiddleName]
	,[SSN]
	,[NorthwoodsNumber]
	,[StateIssuedNumber]
	,[BirthDate]
	,[BirthLocation]
	,[Sex]
	,[fkCPRefClientEducationType]
	,[LockedUser]
	,[LockedDate]
	,[FormattedSSN]
	,[MaidenName]
	,[Suffix]
	,[SISNumber]
	,[SchoolName]
	,[HomePhone]
	,[CellPhone]
	,[WorkPhone]
	,[WorkPhoneExt]
	,[DataCheckSum]
	,[Email]
From  Deleted
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'This table contains basic client biographical information.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary auto-incrementing system identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'pkCPClient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client last name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'LastName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client first name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'FirstName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client middle name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'MiddleName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client Social Security number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'SSN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Arbitrary Northwoods identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'NorthwoodsNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'State ID number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'StateIssuedNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Birth date', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'BirthDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Birth location', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'BirthLocation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client gender', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'Sex';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Foreign key to Cleint Education type reference table', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'fkCPRefClientEducationType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'LockedUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Deprecated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'LockedDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Computed column that displays the formatted SSN for a client (XXX-XX-XXXX)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'FormattedSSN';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client maiden name', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'MaidenName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'LUPUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Last Update Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'LUPDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create User
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'CreateUser';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Auditing information: Create Date
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'CreateDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name suffix (Jr., III, etc).', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'Suffix';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Secondary client identification number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'SISNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Name of school that educated the client', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'SchoolName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Home phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'HomePhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Cell phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'CellPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Work phone number', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'WorkPhone';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Work phone number extension', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'WorkPhoneExt';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Value used internally for data import operations', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'DataCheckSum';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Client email address', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'CPClient', @level2type = N'COLUMN', @level2name = N'Email';

