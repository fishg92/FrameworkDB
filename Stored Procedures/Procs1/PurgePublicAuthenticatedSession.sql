
/****** Object:  Stored Procedure dbo.AddAnnotation    Script Date: 8/21/2006 8:02:14 AM ******/



create  procedure [dbo].[PurgePublicAuthenticatedSession]

as

if exists (select * from Configuration where appid = -1 and ItemKey = 'PurgeTokensNightly' and ItemValue = 'True') BEGIN
	delete from dbo.PublicAuthenticatedSession
END

