--exec MergeCPClientCaseByProgramType
CREATE proc [dbo].[MergeCPClientCaseByProgramType]
	@fkProgramType decimal
	,@LUPUser varchar(100)
as

set nocount on

Declare @ErrorOccurred as bit
set @ErrorOccurred = 0

Declare @CasesToMerge as table 
(
	StateCaseNumber varchar (20)
)

	Insert into @CasesToMerge (StateCaseNumber)
	select StateCaseNumber 
	from dbo.CPClientCase (nolock)
	where fkCPRefClientCaseProgramType  = @fkProgramType
	group by statecasenumber
	having count(statecasenumber) > 1

	DECLARE @StateCaseNumber varchar (20)
	DECLARE @MasterpkCPClientCase decimal (18,0) 
	DECLARE @getStateCaseNumber CURSOR

	SET @getStateCaseNumber = CURSOR FOR

	SELECT StateCaseNumber
	FROM @CasesToMerge
	OPEN @getStateCaseNumber
	
	FETCH NEXT
	FROM @getStateCaseNumber INTO @StateCaseNumber
	
	WHILE @@FETCH_STATUS = 0
		BEGIN
			set @MasterpkCPClientCase = (select top 1 pkCPClientCase from dbo.CPClientCase (nolock) where StateCaseNumber = @StateCaseNumber and fkCPRefClientCaseProgramType  = @fkProgramType)
			Print 'Master record - ' + cast(@MasterpkCPClientCase as varchar)

			DECLARE @pkCPClientCase decimal (18,0) 
			DECLARE @LocalCaseNumber varchar (20)
			DECLARE @getpkCPClientCase CURSOR

			SET @getpkCPClientCase = CURSOR FOR

			SELECT pkCPClientCase, LocalCaseNumber
			FROM dbo.CPClientCase (nolock)
			where StateCaseNumber = @StateCaseNumber
			and fkCPRefClientCaseProgramType  = @fkProgramType
			OPEN @getpkCPClientCase
			
			FETCH NEXT
			FROM @getpkCPClientCase INTO @pkCPClientCase, @LocalCaseNumber
			
			WHILE @@FETCH_STATUS = 0
				BEGIN
					Print @pkCPClientCase

					If @pkCPClientCase <> @MasterpkCPClientCase
						Begin
							--Merge Members and Case Activity, Delete Case and Record Action
							exec MergeDuplicateCase @MasterpkCPClientCase, @pkCPClientCase, @LocalCaseNumber, @StateCaseNumber, @LUPUser
							
							if @@error <> 0
								begin
									set @ErrorOccurred = 1
									break
								end
						End

					FETCH NEXT
					FROM @getpkCPClientCase INTO @pkCPClientCase, @LocalCaseNumber
				END

			CLOSE @getpkCPClientCase
			DEALLOCATE @getpkCPClientCase

			if @@error <> 0
				begin
					set @ErrorOccurred = 1
					break
				end

			FETCH NEXT
			FROM @getStateCaseNumber INTO @StateCaseNumber
		END

	CLOSE @getStateCaseNumber
	DEALLOCATE @getStateCaseNumber

	Select @ErrorOccurred