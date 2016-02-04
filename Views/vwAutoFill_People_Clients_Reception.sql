-- View

CREATE VIEW [ud].[vwAutoFill_People_Clients_Reception]
AS
SELECT     
	  [Case Number]
	, SSN
	, [First Name]
	, MI
	, [Last Name]
	, CaseWorker AS [Case Manager]
	, [Address Line 1]
	, [Address Line 2]
	, City
	, [State]
	, Zip
	, [Individual ID]
	, [Individual ID] AS [State ID]
	, [Compass Number]
	, DOB AS [Birth Date]
FROM         CompassClientInformation