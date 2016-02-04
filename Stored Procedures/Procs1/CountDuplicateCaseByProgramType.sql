CREATE PROC [dbo].[CountDuplicateCaseByProgramType]
(	  @fkProgramType decimal
)
AS
--Get Cases that will be affected , per program type
Declare @Result as table (
#Cases  int
)

  
insert into @Result (#Cases)

select count (statecasenumber)as #Cases from dbo.CPClientCase (nolock)
where fkCPRefClientCaseProgramType  = @fkProgramType
group by statecasenumber
having count(statecasenumber) > 1

If @@RowCount = 0 
	Select 0
Else
	begin
	update @Result
	set #Cases = #Cases - 1
	Where #Cases > 1
	Select sum(#Cases) from @Result
    end
