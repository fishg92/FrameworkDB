CREATE PROCEDURE [dbo].[FormatProg] @Name VARCHAR(100)
AS 
    BEGIN
SET nocount on

Create table #SQLText 
(
--Maximum number of characters on a line in SQL Management Studio is 256. 
[Text] varchar (270)
)

insert into #SQLText EXEC sp_helptext @Name --Get Text of SQL Object

--select * from #sqltext
DECLARE @Delimeter CHAR(1) 
SET @Delimeter = '@' --used to find declared variables

DECLARE @WorkingText As varchar (270) -- The line of text currently being manipulated.
DECLARE @SetStatementText As varchar (270)

DECLARE @DontAllowSetStatement As Bit
DECLARE @PassedDeclarationArea As Bit 
DECLARE @PassedCreateStatement As Bit

DECLARE @isStoredProcedure As Bit 
DECLARE @isAnyFunc As Bit 
DECLARE @isTabularFunction As Bit 

DECLARE @CurrentlyPrintingReturnTable As Bit
DECLARE @ReturnTableName as varchar (256) 
DECLARE @NeedToParseWordsBefore_As As Bit
DECLARE @DeleteReturnStatement As Bit

SET @PassedDeclarationArea = 0
SET @PassedCreateStatement = 0
SET @CurrentlyPrintingReturnTable = 0
SET @isTabularFunction = 0
SET @isAnyFunc  = 0
SET @isTabularFunction = 0
SET @DeleteReturnStatement = 0
--Loop though the SQL Statement line by line, formatting as necessary
DECLARE c1 CURSOR READ_ONLY
FOR
SELECT [text]
FROM #sqltext

OPEN c1

FETCH NEXT FROM c1
INTO @WorkingText

WHILE @@FETCH_STATUS = 0
BEGIN

      SET @DontAllowSetStatement = 0
      SET @SetStatementText = ''
      SET @NeedToParseWordsBefore_As = 0
      
----------SPECIAL FORMATTING-------------------------------------
      IF @PassedDeclarationArea = 0 --Remove hidden control characters that are annoying, trim any whitespace, open / close parens on declare / set area
            BEGIN
                        SET @WorkingText = REPLACE(@WorkingText, CHAR(13), '')
                        SET @WorkingText = REPLACE(@WorkingText, CHAR(10), '')
                        SET @WorkingText = REPLACE(@WorkingText, CHAR(9), '')
                        SET @WorkingText = REPLACE(@WorkingText, ', ', ',')
                        SET @WorkingText = LTrim(@WorkingText)
                        SET @WorkingText = RTrim(@WorkingText)
                        
                        IF @CurrentlyPrintingReturnTable = 0
                              BEGIN
                                    IF @WorkingText = ')' or @WorkingText = '('
                                    SET @WorkingText = ''
                              END

            END
                  --We can't say like '% As %' because that could be the middle of a declaration statement         
      IF @WorkingText like 'AS%'
            BEGIN
                  SET @WorkingText = SUBSTRING(@WorkingText,3, LEN(@WorkingText) -2)
                  SET @PassedDeclarationArea = 1
                  SET @CurrentlyPrintingReturnTable = 0
            END 
      
      IF @WorkingText = 'AS'    
            BEGIN
                  SET @WorkingText = ''
                  SET @PassedDeclarationArea = 1
                  SET @CurrentlyPrintingReturnTable = 0
            END
      IF @WorkingText like '% AS'   
            BEGIN
                  SET @WorkingText =  SUBSTRING(@WorkingText, 0, LEN(@WorkingText) - 2)
                  SET @PassedDeclarationArea = 1      
                  SET @CurrentlyPrintingReturnTable = 0
                  SET @NeedToParseWordsBefore_As = 1              
            END

----------END SPECIAL FORMATTING------------------


      IF @PassedDeclarationArea = 1 And @NeedToParseWordsBefore_As = 0 
            BEGIN
            
                  
            ---God punished us with the Return statement. Hooray for tabs, carriage return, and other invisible ascii!
            
                  DECLARE @SelectText as varchar (256)
                  
                  IF @isTabularFunction = 1
                        SET @SelectText = 'SELECT * From ' + @ReturnTableName
                  Else 
                        SET @SelectText = 'SELECT '
                  
                  If @DeleteReturnStatement = 1 and @WorkingText like '%return%'
                        SET @WorkingText = ''
            
            
                  IF @WorkingText like 'return %'
                              SET @WorkingText = REPLACE(@WorkingText, 'Return ', @SelectText)


                  
                  IF ((PATINDEX('%Return %', @WorkingText) > 0)  or (PATINDEX('Return', @WorkingText) > 0 )) and @isAnyFunc = 1 
                        BEGIN
                              
                              IF PATINDEX('RETURN %', @WorkingText) > 0 or PATINDEX( '%' + CHAR(9) + 'RETURN %' , @WorkingText) > 0  or PATINDEX( '%' + CHAR(32) + 'RETURN %' , @WorkingText) > 0
                                    BEGIN
                                          DECLARE @ReturnValue varchar (100)
                                          SET @WorkingText = Rtrim(@WorkingText)
                                          SET @WorkingText = Ltrim(@WorkingText)
                                          SET @ReturnValue = REPLACE(@WorkingText, 'Return ',@SelectText) 
                                          SET @WorkingText = @ReturnValue     
                                    END         
                        END

                  IF @WorkingText = 'return' + CHAR(13) + CHAR(10)
                                    BEGIN
                                          SET @WorkingText = @SelectText + CHAR(13) + CHAR(10)
                                    END   
            
                  Print @WorkingText
            END   
--(IF @PassedDeclarationArea = 0 or @NeedToParseWordsBefore_As = 1)
Else 
--(IF @PassedDeclarationArea = 0 or @NeedToParseWordsBefore_As = 1)
      
 BEGIN 
 
      IF @WorkingText like '%Create%' 
            
            BEGIN
                  
                  DECLARE @EndNameIndex int
                  DECLARE @StartNameIndex int
                  DECLARE @TitleName varchar (100)
                  IF @WorkingText like '% Proc%' 
                        BEGIN 
                              SET @WorkingText = SUBSTRING(@WorkingText, CHARINDEX('Create', @WorkingText), LEN(@WorkingText) - CHARINDEX('Create', @WorkingText) + 1)
                              SET @StartNameIndex = PATINDEX('%].%', @WorkingText) + 2
                              
                              SET @TitleName = SUBSTRING(@WorkingText, @StartNameIndex, (LEN(@WorkingText)- @StartNameIndex) + 1)

                              SET @EndNameIndex = PATINDEX('%]%', @TitleName)
                              SET @TitleName = SUBSTRING(@TitleName, 1, @EndNameIndex)
                              
                              IF @TitleName = ''
                                    BEGIN
                                          SET @StartNameIndex = PATINDEX('% Proc%', @WorkingText) + 1
                                          SET @TitleName = SUBSTRING(@WorkingText, @StartNameIndex, (LEN(@WorkingText)- @StartNameIndex + 1))
                                          SET @StartNameIndex = PATINDEX('% %', @TitleName)
                                          SET @TitleName = '[' + SUBSTRING(@TitleName, @StartNameIndex + 1, LEN(@TitleName) - @StartNameIndex + 2) + ']'
                                    END
                              
                              Print '--Query Made From Stored Procedure ' + @TitleName + CHAR(13)
                              
                              SET @WorkingText = SUBSTRING(@WorkingText, CHARINDEX(@Delimeter, @WorkingText), LEN(@WorkingText) - CHARINDEX(@Delimeter, @WorkingText) +1 )
                              SET @isStoredProcedure = 1
                              SET @PassedCreateStatement = 1
                              IF @WorkingText not like '%@%'
                                          SET @WorkingText = '' 
                        END
                  
                  IF @WorkingText like '% Func%'
                        BEGIN
                              SET @WorkingText = SUBSTRING(@WorkingText, CHARINDEX('Create', @WorkingText), LEN(@WorkingText) - CHARINDEX('Create', @WorkingText) + 1)
                              SET @StartNameIndex = PATINDEX('%].%', @WorkingText) + 2
                              SET @TitleName = SUBSTRING(@WorkingText, @StartNameIndex, (LEN(@WorkingText)- @StartNameIndex + 1))

                              SET @EndNameIndex = PATINDEX('%]%', @TitleName)
                              
                              SET @TitleName = SUBSTRING(@TitleName, 1, @EndNameIndex)
                              IF @TitleName = ''
                                    BEGIN
                                          SET @StartNameIndex = PATINDEX('% Func%', @WorkingText) + 1                                                 
                                          SET @TitleName = SUBSTRING(@WorkingText, @StartNameIndex, (LEN(@WorkingText)- @StartNameIndex + 1))
                                          SET @StartNameIndex = PATINDEX('% %', @TitleName)
                                          SET @TitleName = '[' + SUBSTRING(@TitleName, @StartNameIndex +1, LEN(@TitleName) - @StartNameIndex +2) + ']'
                                    END
                                    
                              Print '--Query Made From Function ' + @TitleName + CHAR(13)
                              
                              SET @WorkingText = SUBSTRING(@WorkingText, CHARINDEX(@Delimeter, @WorkingText), LEN(@WorkingText) - CHARINDEX(@Delimeter, @WorkingText) +1)
                              SET @isAnyFunc = 1
                              SET @PassedCreateStatement = 1
                              IF @WorkingText not like '%@%'
                                          SET @WorkingText = '' 
                        END

            END

--Parse the string and create a new line for each variable declared. 
IF CHARINDEX(@Delimeter, @WorkingText) <> 0 and @PassedCreateStatement = 1 and @WorkingText not like '%Returns%'

      BEGIN
            
            SET @WorkingText = SUBSTRING(@WorkingText, CHARINDEX(@Delimeter, @WorkingText), LEN(@WorkingText) - CHARINDEX(@Delimeter, @WorkingText) + 1 )
            SET @WorkingText = LTRIM(@WorkingText)
            SET @WorkingText = RTRIM(@WorkingText)
      
---------------Parsing While Loop------------------------------------------------
            DECLARE @NewLine varchar(256)
            DECLARE @StartPos int , @Length int
            WHILE LEN(@WorkingText) > 0
             BEGIN
                  
                  SET @StartPos = CHARINDEX(@Delimeter, @WorkingText)
                SET @DontAllowSetStatement = 0
                  
                  IF @StartPos < 0 
                        SET @StartPos = 0
                
                  SET @Length = LEN(@WorkingText) - @StartPos - 1
                
                  IF @Length < 0 
                        SET @Length = 0
                 
                  IF @StartPos > 0 
                        
                        BEGIN
                        
                              DECLARE @TempText as varchar (256)
                              SET @TempText = SUBSTRING(@WorkingText, 1, @StartPos - 1)         
                                    IF LEN(@TempText) > 2
                                          BEGIN
                                                SET @TempText = LTRIM(@TempText)
                                                SET @TempText = RTRIM(@TempText)


                                                IF PATINDEX('%' + SPACE(1) + 'output%', @WorkingText) <> 0
                                                      BEGIN
                                                      SET @DontAllowSetStatement = 1
                                                      SET @WorkingText = Replace(@WorkingText, ' output' , '')
                                                      END

                                                IF PATINDEX('%=%',@TempText) <> 0  
                                                      BEGIN 
                                                            SET @WorkingText = SUBSTRING(@WorkingText,0, PATINDEX('%=%',@WorkingText)) 
                                                      END
                                                                                    
                                                IF @TempText like '%,'
                                                      Print 'DECLARE   '  + '@' +  SUBSTRING(@TempText, 1, LEN(@TempText) -1) 
                                                Else
                                                      Print 'DECLARE   '  + '@' +  @TempText  
                                                                                    
                                                IF @DontAllowSetStatement = 0
                                                      BEGIN
                                                            SET @SetStatementText = REPLACE(@WorkingText, 'DECLARE   ', '')
                                                            
                                                            SET @SetStatementText = LTrim(@SetStatementText)
                                                            SET @SetStatementText = RTrim(@SetStatementText)

                                                            SET @SetStatementText = SUBSTRING(@SetStatementText,0, PATINDEX( '%' + SPACE(1) + '%', @SetStatementText))
                                                            SET @SetStatementText = 'SET       ' + '@' + @SetStatementText + ' = '
                                                            Print @SetStatementText + CHAR (13)
                                                      END
                                                                                    

                                                                                    
                                                SET @WorkingText = SUBSTRING(@WorkingText, @StartPos + 1, LEN(@WorkingText) - @StartPos)
                                          END
                                    Else
                                          SET @WorkingText = SUBSTRING(@WorkingText, @StartPos + 1, LEN(@WorkingText) - @StartPos)
                        END
                  ELSE
                          BEGIN           
                                          
                              IF PATINDEX('%' + SPACE(1) + 'output%', @WorkingText) <> 0
                                    BEGIN
                                          SET @DontAllowSetStatement = 1
                                          SET @WorkingText = Replace(@WorkingText, ' output' , '')
                                    END
                                          
                                                      
                              IF PATINDEX('%=%',@WorkingText) <> 0  
                                    BEGIN 
                                          
                                          SET @WorkingText = SUBSTRING(@WorkingText,0, PATINDEX('%=%',@WorkingText)) 
                                    END
                                                      
                              IF SUBSTRING(@WorkingText, LEN(@WorkingText), 1) = ')'
                                    BEGIN
                                          IF    isnumeric(SUBSTRING(@WorkingText, LEN(@WorkingText) - 1, 1)) = 0
                                                SET @WorkingText = SUBSTRING(@WorkingText, 0, LEN(@WorkingText))
                                    END
                  
                              IF @WorkingText like '%,' 
                                    Print 'DECLARE   '  + '@' +  SUBSTRING(@WorkingText, 1, LEN(@WorkingText) - 1)
                              Else 
                                    Print 'DECLARE   '  + '@' +  SUBSTRING(@WorkingText, 1, LEN(@WorkingText)) 
                                          
                              IF @DontAllowSetStatement = 0
                                    BEGIN
                                          SET @SetStatementText = REPLACE(@WorkingText, 'DECLARE   ', '')
                                          
                                          SET @SetStatementText = LTrim(@SetStatementText)
                                          SET @SetStatementText = RTrim(@SetStatementText)

                                          SET @SetStatementText = SUBSTRING(@SetStatementText,0, PATINDEX( '%' + SPACE(1) + '%', @SetStatementText))
                                          SET @SetStatementText = 'SET       ' + '@' + @SetStatementText + ' = '
                                          Print @SetStatementText + CHAR (13)
                                    END

                              SET @WorkingText = ''   
                          END
            END
------------------------END Of Parse While Loop------------------------------------------
  END
Else --(If line does not contain a '@' symbol, or the initial CREATE statement)
      BEGIN
            
            IF @PassedCreateStatement = 1
            BEGIN
                   
                  IF @WorkingText like '%Returns%' and @WorkingText like '%Table%' and @WorkingText not like '%RETURNS TABLE%'
                        BEGIN
                              SET @isTabularFunction = 1
                              SET @CurrentlyPrintingReturnTable = 1
                              SET @ReturnTableName = SUBSTRING(@WorkingText, CHARINDEX('@', @WorkingText), LEN(@WorkingText) - CHARINDEX('@', @WorkingText) +1  )
                              SET @ReturnTableName = SUBSTRING(@ReturnTableName, 1, CHARINDEX( SPACE(1)+ 'Table', @ReturnTableName))
                              SET @WorkingText = REPLACE(@WorkingText, 'Returns', 'DECLARE')
                        END
                        
                  If @WorkingText like '%RETURNS TABLE%'
                        Begin
                        Set @WorkingText = ''
                        Set @DeleteReturnStatement = 1
                        End
                        
                  IF @WorkingText like '%Returns%'  and @isTabularFunction = 0
                              SET @WorkingText = '--' + @WorkingText    
                                          
                  IF @WorkingText <> ''
                        Print @WorkingText
            END
      END

END
                        
      FETCH NEXT FROM c1
      INTO @WorkingText

END

CLOSE c1
DEALLOCATE c1

drop table #sqltext

END

