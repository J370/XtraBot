DROP Database GUARDIANS;

Create Database GUARDIANS
GO

Use GUARDIANS
GO


--/***************************************************************/
--/***           Delete tables before creating                 ***/
--/***************************************************************/


/*Table : dbo.Host */
if exists (select * from sysobjects 
  where id = object_id('dbo.Host') and sysstat & 0xf = 3)
  drop table dbo.Host
GO


/*Table : dbo.Bin */
if exists (select * from sysobjects 
  where id = object_id('dbo.Bin') and sysstat & 0xf = 3)
  drop table dbo.Bin
GO




/***************************************************************/
/***                     Creating tables                     ***/
/***************************************************************/

/*Table : dbo.School*/
CREATE TABLE dbo.Host
(
  CommandNumber           int IDENTITY(1,1),
  Command                 varchar(500)    NULL,
  CONSTRAINT PK_CommandNumber PRIMARY KEY NONCLUSTERED (CommandNumber)
)
GO

/*Table : dbo.Lecturer*/
CREATE TABLE dbo.Bin
(
  RequestNumber           int IDENTITY(1,1),
  Request                 varchar(500)    NULL,
  CONSTRAINT PK_RequestNumber PRIMARY KEY NONCLUSTERED (RequestNumber)
)
GO