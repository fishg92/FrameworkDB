

--exec usp_automatedtest_DeleteClientbyFirstAndLastName 'TheDude', 'Fella'
CREATE proc usp_automatedtest_DeleteClientbyFirstAndLastName
	@FirstName as varchar (50)
	,@LastName as varchar (50)
as


declare @pks table( pkCPClient decimal (18,0))


insert into @pks(pkCPClient)
select pkcpclient
from cpclient
where Firstname = @FirstName
and LastName = @LastName

delete a 
from dbo.CPClientCustomAttribute as a
inner join @pks as ClientList 
on pkCpClient = a.fkcpclient
where fkCPClient = pkCPClient

delete b 
from dbo.CPClientMarriageRecord as b
inner join @pks as ClientList 
on pkCpClient = b.fkcpclient
where fkCPClient = pkCPClient

delete c
from dbo.CPClientMilitaryRecord as c
inner join @pks as ClientList 
on pkCpClient = c.fkcpclient
where fkCPClient = pkCPClient


delete d
from dbo.CPJoinClientAlertFlagTypeNT as d 
inner join @pks as ClientList 
on pkCpClient = d.fkcpclient
where fkCPClient = pkCPClient

delete e
from dbo.CPJoinClientClientAddress as e
inner join @pks as ClientList 
on pkCpClient = e.fkcpclient
where fkCPClient = pkCPClient

delete f
from dbo.CPJoinClientClientCase as f
inner join @pks as ClientList 
on pkCpClient = f.fkcpclient
where fkCPClient = pkCPClient

delete g 
from dbo.CPJoinClientClientPhone as g
inner join @pks as ClientList 
on pkCpClient = g.fkcpclient
where fkCPClient = pkCPClient

delete h

from dbo.CPJoinClientEmployer as h
inner join @pks as ClientList 
on pkCpClient = h.fkcpclient
where fkCPClient = pkCPClient

delete i 
from dbo.CPJoinClientNarrativeNT as i 
inner join @pks as ClientList 
on pkCpClient = i.fkcpclient
where fkCPClient = pkCPClient

delete j 
from dbo.CPJoinCPClientCPClientrefRelationship as j
inner join @pks as ClientList 
on pkCpClient = j.fkCPClientChild
where fkCPClientChild = pkCPClient

delete k
from dbo.CPJoinCPClientCPClientrefRelationship as k
inner join @pks as ClientList 
on pkCpClient = k.fkCPClientParent
where fkCPClientParent = pkCPClient

delete l
from dbo.CPClient as l
inner join @pks as ClientList 
on Clientlist.pkCpClient = l.pkcpclient
where Clientlist.pkCPClient = l.pkCPClient