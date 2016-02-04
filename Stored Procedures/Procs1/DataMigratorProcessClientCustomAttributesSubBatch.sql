





CREATE proc [dbo].[DataMigratorProcessClientCustomAttributesSubBatch]
	@fkCPImportBatch decimal
	,@SubBatchID int
as

declare @CheckSumForBlankData int
set @CheckSumForBlankData = binary_checksum('','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','')




update CPClientCustomAttribute
 set 									DATA1  = case when  s.Data1 = '' then CPClientCustomAttribute.Data1 else s.Data1 end
										, DATA2  = case when  s.Data2 = '' then CPClientCustomAttribute.Data2 else s.Data2 end
										, DATA3  = case when  s.Data3 = '' then CPClientCustomAttribute.Data3 else s.Data3 end
										, DATA4  = case when  s.Data4 = '' then CPClientCustomAttribute.Data4 else s.Data4 end
										, DATA5  = case when  s.Data5 = '' then CPClientCustomAttribute.Data5 else s.Data5 end
										, DATA6  = case when  s.Data6 = '' then CPClientCustomAttribute.Data6 else s.Data6 end
										, DATA7  = case when  s.Data7 = '' then CPClientCustomAttribute.Data7 else s.Data7 end
										, DATA8  = case when  s.Data8 = '' then CPClientCustomAttribute.Data8 else s.Data8 end
										, DATA9  = case when  s.Data9 = '' then CPClientCustomAttribute.Data9 else s.Data9 end
										, DATA10  = case when  s.Data10 = '' then CPClientCustomAttribute.Data10 else s.Data10 end
										, DATA11  = case when  s.Data11 = '' then CPClientCustomAttribute.Data11 else s.Data11 end
										, DATA12  = case when  s.Data12 = '' then CPClientCustomAttribute.Data12 else s.Data12 end
										, DATA13  = case when  s.Data13 = '' then CPClientCustomAttribute.Data13 else s.Data13 end
										, DATA14  = case when  s.Data14 = '' then CPClientCustomAttribute.Data14 else s.Data14 end
										, DATA15  = case when  s.Data15 = '' then CPClientCustomAttribute.Data15 else s.Data15 end
										, DATA16  = case when  s.Data16 = '' then CPClientCustomAttribute.Data16 else s.Data16 end
										, DATA17  = case when  s.Data17 = '' then CPClientCustomAttribute.Data17 else s.Data17 end
										, DATA18  = case when  s.Data18 = '' then CPClientCustomAttribute.Data18 else s.Data18 end
										, DATA19  = case when  s.Data19 = '' then CPClientCustomAttribute.Data19 else s.Data19 end
										, DATA20  = case when  s.Data20 = '' then CPClientCustomAttribute.Data20 else s.Data20 end
										, DATA21  = case when  s.Data21 = '' then CPClientCustomAttribute.Data21 else s.Data21 end
										, DATA22  = case when  s.Data22 = '' then CPClientCustomAttribute.Data22 else s.Data22 end
										, DATA23  = case when  s.Data23 = '' then CPClientCustomAttribute.Data23 else s.Data23 end
										, DATA24  = case when  s.Data24 = '' then CPClientCustomAttribute.Data24 else s.Data24 end
										, DATA25  = case when  s.Data25 = '' then CPClientCustomAttribute.Data25 else s.Data25 end
										, DATA26  = case when  s.Data26 = '' then CPClientCustomAttribute.Data26 else s.Data26 end
										, DATA27  = case when  s.Data27 = '' then CPClientCustomAttribute.Data27 else s.Data27 end
										, DATA28  = case when  s.Data28 = '' then CPClientCustomAttribute.Data28 else s.Data28 end
										, DATA29  = case when  s.Data29 = '' then CPClientCustomAttribute.Data29 else s.Data29 end
										, DATA30  = case when  s.Data30 = '' then CPClientCustomAttribute.Data30 else s.Data30 end
										, DATA31  = case when  s.Data31 = '' then CPClientCustomAttribute.Data31 else s.Data31 end
										, DATA32  = case when  s.Data32 = '' then CPClientCustomAttribute.Data32 else s.Data32 end
										, DATA33  = case when  s.Data33 = '' then CPClientCustomAttribute.Data33 else s.Data33 end
										, DATA34  = case when  s.Data34 = '' then CPClientCustomAttribute.Data34 else s.Data34 end
										, DATA35  = case when  s.Data35 = '' then CPClientCustomAttribute.Data35 else s.Data35 end
										, DATA36  = case when  s.Data36 = '' then CPClientCustomAttribute.Data36 else s.Data36 end
										, DATA37  = case when  s.Data37 = '' then CPClientCustomAttribute.Data37 else s.Data37 end
										, DATA38  = case when  s.Data38 = '' then CPClientCustomAttribute.Data38 else s.Data38 end
										, DATA39  = case when  s.Data39 = '' then CPClientCustomAttribute.Data39 else s.Data39 end
										, DATA40  = case when  s.Data40 = '' then CPClientCustomAttribute.Data40 else s.Data40 end
from DataMigratorStaging s
join CPClientCustomAttribute on
 CPClientCustomAttribute.fkCPClient = s.fkCPClient
and CPClientCustomAttribute.DataCheckSum <> s.CustomAttributeChecksum
where s.ExclusionFlag = 0
and s.fkCPImportBatch = @fkCPImportBatch
and s.SubBatchID = @SubBatchID
--and s.CustomAttributeChecksum <>  @CheckSumForBlankData

insert into CPClientCustomAttribute
	(fkCPClient,DATA1,DATA2,DATA3,DATA4,DATA5,DATA6,DATA7,DATA8,DATA9,DATA10
		,DATA11,DATA12,DATA13,DATA14,DATA15,DATA16,DATA17,DATA18,DATA19,DATA20
		,DATA21,DATA22,DATA23,DATA24,DATA25,DATA26,DATA27,DATA28,DATA29,DATA30
		,DATA31,DATA32,DATA33,DATA34,DATA35,DATA36,DATA37,DATA38,DATA39,DATA40)
select distinct
		fkCPClient,DATA1,DATA2,DATA3,DATA4,DATA5,DATA6,DATA7,DATA8,DATA9,DATA10
		,DATA11,DATA12,DATA13,DATA14,DATA15,DATA16,DATA17,DATA18,DATA19,DATA20
		,DATA21,DATA22,DATA23,DATA24,DATA25,DATA26,DATA27,DATA28,DATA29,DATA30
		,DATA31,DATA32,DATA33,DATA34,DATA35,DATA36,DATA37,DATA38,DATA39,DATA40
	from DataMigratorStaging s
	where s.ExclusionFlag = 0
	and s.fkCPClient is not null
	and s.SubBatchID = @SubBatchID
	and s.fkCPImportBatch = @fkCPImportBatch
	and not exists (select* from CPClientCustomAttribute 
						where CPClientCustomAttribute.fkCPClient = s.fkCPClient)
	and s.CustomAttributeChecksum <>  @CheckSumForBlankData




