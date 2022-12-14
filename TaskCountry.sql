CREATE DATABASE TaskDataBase

--CREATE TABLE COUNTRY (
 
-- ID INT PRIMARY KEY IDENTITY ,
-- NAME NVARCHAR(50) NOT NULL,
-- CODE NVARCHAR(50)
--)

--CREATE TABLE CITY(
--ID INT PRIMARY KEY IDENTITY,
--NAME NVARCHAR(50) NOT NULL,
--COUNTRY_ID INT NOT NULL FOREIGN KEY REFERENCES COUNTRY(ID),
--CODE NVARCHAR(50)
--)

--CREATE TABLE DISTRICT(
-- ID INT PRIMARY KEY IDENTITY,
-- NAME NVARCHAR(50) NOT NULL,
-- COUNTRY_ID INT NOT NULL FOREIGN KEY REFERENCES COUNTRY(ID),
-- CITY_ID INT NOT NULL FOREIGN KEY REFERENCES CITY(ID),
-- CODE NVARCHAR(50)
--)

--CREATE TABLE TOWN(
--ID INT PRIMARY KEY IDENTITY,
--NAME NVARCHAR(50)  NOT NULL,
--COUNTRY_ID INT FOREIGN KEY REFERENCES COUNTRY(ID),
--CITYID INT FOREIGN KEY REFERENCES CITY(ID),
--DISTRICT_ID INT FOREIGN KEY REFERENCES DISTRICT(ID),
--CODE NVARCHAR(50)
----)

--CREATE PROCEDURE CREATE_TABLES @COUNTRY_NAME AS NVARCHAR(50),@CITY_NAME AS NVARCHAR(50),
--@DISTRICT_NAME AS NVARCHAR(50),@TOWN_NAME AS NVARCHAR(50)
--AS
--BEGIN
--EXEC CITY_CREATED @COUNTRY_NAME=@COUNTRY_NAME
DECLARE @COUNTRY_NAME AS NVARCHAR(50)

DECLARE @COUNTRY_ID AS INT
--SELECT @COUNTRY_ID=ID FROM COUNTRY WHERE [NAME]=@COUNTRY_NAME

EXEC CREATE_CITY @NAME=@CITY_NAME,@ID=@COUNTRY_ID

DECLARE @CITY_ID AS INT
DECLARE @CITY_NAME AS NVARCHAR(50)

SELECT @CITY_ID=ID FROM CITY WHERE NAME=@CITY_NAME AND @COUNTRY_ID=@COUNTRY_ID


EXEC DISTRICT_CREATED @NAME=@DISTRICT_NAME,@COUNTRY_ID=@COUNTRY_ID,@CITY_ID=@CITY_ID

DECLARE @DISTRICT_ID AS INT
SELECT @DISTRICT_ID=ID FROM DISTRICT WHERE NAME=@DISTRICT_NAME AND @COUNTRY_ID=@COUNTRY_ID AND @CITY_ID=@CITY_ID

EXEC TOWN_CREATED @NAME=@TOWN_NAME,@COUNTRY_ID=@COUNTRY_ID,@CITY_ID=@CITY_ID,@DISTRICT_ID=@DISTRICT_ID

END

CREATE PROCEDURE COUNTRY_CREATED(@COUNTRY_NAME AS NVARCHAR(50))
AS
BEGIN
IF EXISTS(SELECT NAME FROM DBO.COUNTRY WHERE NAME=@COUNTRY_NAME)
	PRINT  @COUNTRY_NAME + ' '+'ALREADY EXSIST'
	ELSE
INSERT INTO DBO.COUNTRY
VALUES(@COUNTRY_NAME,'LQJK45')
	PRINT @COUNTRY_NAME +'COUNTRY ALREADY CREATED'
END


CREATE PROCEDURE CITY_CREATED @NAME AS NVARCHAR(50), @ID AS INT
AS 
BEGIN

IF  EXISTS(SELECT [NAME] FROM DBO.CITY WHERE [NAME]=@NAME AND COUNTRY_ID=@ID)
	PRINT @NAME+' CITY COUNTRY ALREADY HAS'
ELSE
	INSERT INTO DBO.CITY
	VALUES(@NAME,@ID,'HAG12')
	PRINT @NAME+ 'CITY CREATED'
END

CREATE PROCEDURE DISTRICT_CREATED @NAME AS NVARCHAR(50),@COUNTRY_ID AS INT ,@CITY_ID INT
AS
BEGIN
IF  EXISTS(SELECT NAME FROM DBO.DISTRICT WHERE NAME=@NAME AND COUNTRY_ID=@COUNTRY_ID AND CITY_ID=@CITY_ID)
	PRINT @NAME+'DISTRICT CITY OF COUNTRY ALREADY HAS'
ELSE
	INSERT INTO DBO.DISTRICT
	VALUES(@NAME,@COUNTRY_ID,@CITY_ID,'AJAH13')
	PRINT @NAME+ 'DISTRICT CREATED'
END

CREATE PROCEDURE TOWN @NAME AS NVARCHAR(50),@COUNTRY_ID AS INT ,@CITY_ID INT,@DISTRICT_ID AS INT
AS
BEGIN
IF  EXISTS(SELECT NAME FROM DBO.TOWN T WHERE NAME=@NAME AND COUNTRY__ID=@COUNTRY_ID AND DISTRICT_ID=@DISTRICT_ID)
	PRINT @NAME+'TOWN DISTRICT OF CITY OF COUNTRY  ALREADY HAS'
ELSE
	INSERT INTO DBO.TOWN
	VALUES(@NAME,@COUNTRY__ID,@CITY_ID,@DISTRICT_ID,'AJSKAK23')
	PRINT @NAME+ 'TOWN CREATED'
END