
/*

exec dbo.spCPSearchClient
@stateIssuedNumber = '849264163K'

*/


CREATE proc [dbo].[spCPSearchClient]
(	 
 @LastName VARCHAR(100)				=null
,@FirstName VARCHAR(100)			=null
,@MiddleName VARCHAR(100)			=null
,@SSN VARCHAR(9)					=null
,@NorthwoodsNumber VARCHAR(50)		=null
,@StateIssuedNumber VARCHAR(50)		=null	
,@BirthDate DATETIME				=null
,@Sex CHAR(1)						=null
,@Street1 VARCHAR(100)				=null
,@Street2 VARCHAR(100)				=null
,@Street3 VARCHAR(100)				=null
,@City VARCHAR(100)					=null
,@State VARCHAR(50)					=null
,@Zip CHAR(5)						=null
,@ZipPlus4 CHAR(4)					=null
,@PhoneNumber VARCHAR(10)			=null
,@Extension VARCHAR(10)				=null
,@StateCaseNumber VARCHAR(20)		=null
,@LocalCaseNumber VARCHAR(20)		=null
)

AS

SELECT
    c.pkCPClient
   ,c.LastName
   ,c.FirstName
   ,c.MiddleName
   ,c.SSN
   ,c.NorthwoodsNumber
   ,c.StateIssuedNumber
   ,c.BirthDate
   ,c.BirthLocation
   ,c.Sex
   ,[EductionType] = rcet.Description
   ,ca.pkCPClientAddress
   ,[AddressType] = rcat.Description
   ,ca.Street1
   ,ca.Street2
   ,ca.Street3
   ,ca.City
   ,ca.[State]
   ,ca.Zip
   ,ca.ZipPlus4
   ,cp.pkCPClientPhone
   ,[PhoneType] = rpt.Description
   ,cp.Number
   ,cp.Extension
   ,cc.pkCPClientCase
	,cc.StateCaseNumber
	,cc.LocalCaseNumber
	,[ClientCaseProgramType] = rccpt.Description
	,cc.fkCPCaseWorker

FROM
    dbo.cpClient c (NOLOCK)
RIGHT JOIN dbo.CPJoinClientClientAddress jcca (NOLOCK)
    ON c.pkCPClient = jcca.fkCPClient
RIGHT JOIN dbo.CPClientAddress ca (NOLOCK)
    ON jcca.fkCPClientAddress = ca.pkCPClientAddress
RIGHT JOIN dbo.CPJoinClientClientPhone jccp (NOLOCK)
    ON c.pkCPClient = jccp.fkCPClient
RIGHT JOIN dbo.CPClientPhone cp (NOLOCK)
    ON jccp.fkCPClientPhone = cp.pkCPClientPhone
LEFT JOIN dbo.CPRefClientEducationType rcet (NOLOCK)
    ON c.fkCPRefClientEducationType = rcet.pkCPRefClientEducationType
RIGHT JOIN dbo.CPRefClientAddressType rcat (NOLOCK)
    ON ca.fkCPRefClientAddressType = rcat.pkCPRefClientAddressType
RIGHT JOIN dbo.CPRefPhoneType rpt (NOLOCK)
    ON cp.fkCPRefPhoneType = rpt.pkCPRefPhoneType
RIGHT JOIN dbo.CPJoinClientClientCase jccc (NOLOCK)
	ON c.pkCPClient = jccc.fkCPClient
RIGHT JOIN dbo.CPClientCase cc (NOLOCK)
	ON jccc.fkCPClientCase = cc.pkCPClientCase
RIGHT JOIN CPRefClientCaseProgramType rccpt (NOLOCK)
	ON cc.fkCPRefClientCaseProgramType = rccpt.pkCPRefClientCaseProgramType
WHERE 1=1

and   	(@LastName is null or c.LastName like @LastName + '%')
and 	(@FirstName is null or c.FirstName like @FirstName + '%')
and 	(MiddleName is null or c.MiddleName like @MiddleName + '%')
and   	(@SSN is null or c.SSN = @SSN)
and   	(@NorthwoodsNumber is null or c.NorthwoodsNumber LIKE '%' + @NorthwoodsNumber + '%')
and   	(@StateIssuedNumber is null or c.StateIssuedNumber like '%' + @StateIssuedNumber + '%')
and   	(@BirthDate is null or c.BirthDate = @BirthDate)
and   	(@Sex is null or c.Sex = @Sex)
and   	(@Street1 is null or ca.Street1 = @Street1)
and   	(@Street2 is null or ca.Street2 = @Street2)
and   	(@Street3 is null or ca.Street3 = @Street3)
and   	(@City is null or ca.City = @City)
and   	(@State is null or ca.State = @State)
and   	(@Zip is null or ca.Zip = @Zip)
and   	(@ZipPlus4 is null or ca.ZipPlus4 = @ZipPlus4)
and   	(@PhoneNumber is null or cp.Number = @PhoneNumber)
and   	(@Extension is null or cp.Extension = @Extension)
and   	(@StateCaseNumber is null or cc.StateCaseNumber = @StateCaseNumber)
and   	(@LocalCaseNumber is null or cc.LocalCaseNumber = @LocalCaseNumber)
