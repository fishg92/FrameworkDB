




CREATE VIEW [dbo].[CompassClientInformation]
AS

SELECT     
[Case Number] = cc.StateCaseNumber
, SSN = c.FormattedSSN
, [First Name] = c.FirstName
, MI = c.MiddleName
, [Last Name] = c.LastName
, CaseWorker = vcwp.UserName
, DOB = CONVERT(VARCHAR(10), CONVERT(DATETIME, c.BirthDate, 101), 101)
, [Type] = pt.ProgramType
, [Participant Type] = CASE WHEN jc.PrimaryParticipantOnCase = 1 THEN 'Case Head' END
, [Address Line 1] = a.Street1 
, [Address Line 2] = a.Street2
, City = a.City
, [State] = a.State
, Zip = a.Zip
, [Individual ID] = c.StateIssuedNumber
, [State ID] = c.StateIssuedNumber
, Race = NULL
, Sex = c.Sex
, Phone = CASE WHEN c.HomePhone = '0' THEN NULL ELSE SUBSTRING(c.HomePhone, 1, 3) + '-' + SUBSTRING(c.HomePhone, 4, 3) + '-' + SUBSTRING(c.HomePhone, 7, 4) END
, [Worker Number] = CASE WHEN pt.pkProgramType = 1 THEN vcwp.StateID END
, [District Number] = vcwp.StateID
, [CaseWorker Full Name] = vcwp.FirstName + ' ' + vcwp.LastName
, [Worker Phone Number] = SUBSTRING(vcwp.PhoneNumber, 1, 3) + '-' + SUBSTRING(vcwp.PhoneNumber, 4, 3) + '-' + SUBSTRING(vcwp.PhoneNumber, 7, 4) + RTRIM(' ' + ISNULL(vcwp.Extension, ''))
, [FSIS Number] = CASE WHEN pt.pkProgramType = 1 THEN cc.StateCaseNumber END
, [EIS Number] = CASE WHEN pt.pkProgramType = 2 THEN cc.StateCaseNumber END
, [County Case Num] = cc.LocalCaseNumber
, [Compass Number] = c.NorthwoodsNumber
, [SIS Number] = c.SISNumber
, [School Attended] = c.SchoolName
, [ProgramTypeID] = ISNULL(cc.fkCPRefClientCaseProgramType,-1)
, pkCPClient
, [Worker First Name] = vcwp.FirstName
, [Worker Last Name] = vcwp.LastName
, c.Email
FROM            dbo.CPClient AS c WITH (NOLOCK) 
LEFT OUTER JOIN dbo.CPJoinClientClientCase AS jc WITH (NOLOCK) ON c.pkCPClient = jc.fkCPClient 
LEFT OUTER JOIN dbo.CPClientCase AS cc WITH (NOLOCK) ON jc.fkCPClientCase = cc.pkCPClientCase 
LEFT OUTER JOIN dbo.CPJoinClientClientAddress AS ja WITH (NOLOCK) ON c.pkCPClient = ja.fkCPClient 
LEFT OUTER JOIN dbo.CPClientAddress AS a WITH (NOLOCK) ON ja.fkCPClientAddress = a.pkCPClientAddress 
LEFT OUTER JOIN dbo.ProgramType AS pt WITH (NOLOCK) ON cc.fkCPRefClientCaseProgramType = pt.pkProgramType 
LEFT OUTER JOIN (SELECT     au.pkApplicationUser
							, au.FirstName
							, au.LastName
							, au.CountyCode
							, au.UserName
							, au.StateID
							, au.PhoneNumber
							, au.Extension
                            FROM          dbo.ApplicationUser AS au (NOLOCK) 
							) AS vcwp 
					ON cc.fkApplicationUser = vcwp.pkApplicationUser
GROUP BY cc.StateCaseNumber
	, c.FormattedSSN
	, c.FirstName
	, c.MiddleName
	, c.LastName
	, vcwp.UserName
	, c.BirthDate
	, pt.ProgramType
	, pt.pkProgramType
	, jc.PrimaryParticipantOnCase
	, a.Street1
	, a.Street2
	, a.City
	, a.State
	, a.Zip
	, c.StateIssuedNumber
	, c.Sex
	, vcwp.PhoneNumber
	, vcwp.StateID
	, vcwp.Extension
	, cc.LocalCaseNumber
	, c.NorthwoodsNumber
	, cc.fkCPClientCaseHead
	, c.pkCPClient
	, c.HomePhone
	, vcwp.FirstName
	, vcwp.LastName
	, c.SISNumber
	, c.SchoolName
	, cc.fkCPRefClientCaseProgramType
	, c.Email

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4[30] 2[40] 3) )"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2[66] 3) )"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2) )"
      End
      ActivePaneConfig = 14
   End
   Begin DiagramPane = 
      PaneHidden = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 121
               Right = 272
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "jc"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 241
               Right = 283
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "cc"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 361
               Right = 289
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ja"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 481
               Right = 271
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "a"
            Begin Extent = 
               Top = 486
               Left = 38
               Bottom = 601
               Right = 264
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "pt"
            Begin Extent = 
               Top = 606
               Left = 38
               Bottom = 721
               Right = 234
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "vcp"
            Begin Extent = 
               Top = 6
               Left = 310
               Bottom = 84
               Right = 477
            End
            DisplayFlags = 280
            TopCo', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'CompassClientInformation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'lumn = 0
         End
         Begin Table = "vcwp"
            Begin Extent = 
               Top = 6
               Left = 515
               Bottom = 114
               Right = 694
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      PaneHidden = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      PaneHidden = 
      Begin ColumnWidths = 12
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'CompassClientInformation';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'CompassClientInformation';

