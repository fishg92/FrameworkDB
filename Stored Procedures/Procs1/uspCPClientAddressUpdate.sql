﻿----------------------------------------------------------------------------
-- Update a single record in CPClientAddress
----------------------------------------------------------------------------
CREATE PROC [dbo].[uspCPClientAddressUpdate]
(	  @pkCPClientAddress decimal(18, 0)
	, @fkCPRefClientAddressType decimal(18, 0) = NULL
	, @Street1 varchar(100) = NULL
	, @Street2 varchar(100) = NULL
	, @Street3 varchar(100) = NULL
	, @City varchar(100) = NULL
	, @State varchar(50) = NULL
	, @Zip char(5) = NULL
	, @ZipPlus4 char(4) = NULL
	, @LockedUser varchar(50) = NULL
	, @LockedDate datetime = NULL
	, @LUPUser varchar(50)
	, @LUPMac char(17)
	, @LUPIP varchar(15)
	, @LUPMachine varchar(15)
)
AS
exec dbo.SetAuditDataContext @LupUser, @LupMachine

UPDATE	CPClientAddress
SET	fkCPRefClientAddressType = ISNULL(@fkCPRefClientAddressType, fkCPRefClientAddressType),
	Street1 = ISNULL(@Street1, Street1),
	Street2 = ISNULL(@Street2, Street2),
	Street3 = ISNULL(@Street3, Street3),
	City = ISNULL(@City, City),
	State = ISNULL(@State, State),
	Zip = ISNULL(@Zip, Zip),
	ZipPlus4 = ISNULL(@ZipPlus4, ZipPlus4),
	LockedUser = ISNULL(@LockedUser, LockedUser),
	LockedDate = ISNULL(@LockedDate, LockedDate)
WHERE 	pkCPClientAddress = @pkCPClientAddress
