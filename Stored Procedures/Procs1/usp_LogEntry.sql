
CREATE PROC [dbo].[usp_LogEntry]
(
	@Source varchar(100) -- where the tracer is declared
	, @ApplicationID int
	, @EntryType varchar(255)
	, @Message text
	, @AssociateWith varchar(200)
	, @CreateUser varchar(50)
)
AS
declare @ConfiguredTraceLevel varchar(1)
set @ConfiguredTraceLevel  = '1'
select @ConfiguredTraceLevel = ItemValue from Configuration where itemKey = 'LoggingLevel'

declare @LogThis bit
set @LogThis = 0

/* TraceLevel = Verbose */
if @ConfiguredTraceLevel = '4' 
BEGIN
	set @LogThis = 1
END 

/* TraceLevel = Info */
if @ConfiguredTraceLevel = '3' and (@EntryType = 'Information' or @EntryType = '2' or @EntryType = 'Warning' or @EntryType = '1' or @EntryType = 'CriticalError' or @EntryType = '0' )
BEGIN
	set @LogThis = 1
END

/* TraceLevel = Warning */
if @ConfiguredTraceLevel = '2' and (@EntryType = 'Warning' or @EntryType = '1' or @EntryType = 'CriticalError'  or @EntryType = '0' )
BEGIN
	set @LogThis = 1
END

/* TraceLevel = Error */
if @ConfiguredTraceLevel = '1' and (@EntryType = 'CriticalError'  or @EntryType = '0' )
BEGIN
	set @LogThis = 1
END
	if @LogThis = 1 BEGIN
	INSERT INTO Logging
		(
			[DateTime]
			, Source
			, ApplicationID
			, EntryType
			, Message
			, AssociateWith
			, CreateUser
			, CreateDate
		)
	VALUES (GetDate()
	, @Source
	, @ApplicationID
	, @EntryType
	, @Message
	, @AssociateWith
	, @CreateUser
	, getdate()
	)
END
