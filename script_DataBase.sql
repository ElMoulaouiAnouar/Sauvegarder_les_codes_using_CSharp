USE [master]
GO
/****** Object:  Database [RappeleCoder]    Script Date: 14/04/2021 10:38:40 ******/
CREATE DATABASE [RappeleCoder]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RappeleCoder', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RappeleCoder.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RappeleCoder_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\RappeleCoder_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RappeleCoder] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RappeleCoder].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RappeleCoder] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RappeleCoder] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RappeleCoder] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RappeleCoder] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RappeleCoder] SET ARITHABORT OFF 
GO
ALTER DATABASE [RappeleCoder] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RappeleCoder] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RappeleCoder] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RappeleCoder] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RappeleCoder] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RappeleCoder] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RappeleCoder] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RappeleCoder] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RappeleCoder] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RappeleCoder] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RappeleCoder] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RappeleCoder] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RappeleCoder] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RappeleCoder] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RappeleCoder] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RappeleCoder] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RappeleCoder] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RappeleCoder] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [RappeleCoder] SET  MULTI_USER 
GO
ALTER DATABASE [RappeleCoder] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RappeleCoder] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RappeleCoder] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RappeleCoder] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [RappeleCoder] SET DELAYED_DURABILITY = DISABLED 
GO
USE [RappeleCoder]
GO
/****** Object:  Table [dbo].[Tbl_code]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_code](
	[ID_code] [int] IDENTITY(1,1) NOT NULL,
	[txt_code] [nvarchar](max) NULL,
	[nom_code] [varchar](50) NOT NULL,
	[ID_longage] [int] NOT NULL,
 CONSTRAINT [PK_Tbl_code] PRIMARY KEY CLUSTERED 
(
	[ID_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Tbl_Longage]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Tbl_Longage](
	[ID_longage] [int] IDENTITY(1,1) NOT NULL,
	[nom_longage] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tbl_Longage] PRIMARY KEY CLUSTERED 
(
	[ID_longage] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Tbl_code]  WITH CHECK ADD  CONSTRAINT [FK_Tbl_code_Tbl_Longage] FOREIGN KEY([ID_longage])
REFERENCES [dbo].[Tbl_Longage] ([ID_longage])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tbl_code] CHECK CONSTRAINT [FK_Tbl_code_Tbl_Longage]
GO
/****** Object:  StoredProcedure [dbo].[addlongage]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[addlongage] @nomLongage varchar(50) as
insert into [dbo].[Tbl_Longage](nom_longage) values(@nomLongage)
GO
/****** Object:  StoredProcedure [dbo].[getcode]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[getcode] @id int,@nom_code varchar(50)
as
select Tbl_code.txt_code from Tbl_code where Tbl_code.ID_longage=@id and Tbl_code.nom_code=@nom_code
GO
/****** Object:  StoredProcedure [dbo].[getlongage]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getlongage] as select * from Tbl_Longage
GO
/****** Object:  StoredProcedure [dbo].[getNomCode]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[getNomCode] @id int
 as 
 select [nom_code] from Tbl_code where Tbl_code.ID_longage=@id
GO
/****** Object:  StoredProcedure [dbo].[removecode]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[removecode] @id int, @nom varchar(50) as 
delete from Tbl_code where Tbl_code.ID_longage=@id and Tbl_code.nom_code=@nom
GO
/****** Object:  StoredProcedure [dbo].[removelongage]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[removelongage] @nom varchar(50) as 
delete from Tbl_Longage where Tbl_Longage.nom_longage=@nom
GO
/****** Object:  StoredProcedure [dbo].[setcode]    Script Date: 14/04/2021 10:38:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[setcode] @id int,@nom_code varchar(50),@txt_code varchar(max)
as
insert into Tbl_code(ID_longage,nom_code,txt_code) values(@id,@nom_code,@txt_code)
GO
USE [master]
GO
ALTER DATABASE [RappeleCoder] SET  READ_WRITE 
GO
