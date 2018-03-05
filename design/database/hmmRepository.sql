/****** Object:  Table [dbo].[Users]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](100) NOT NULL,
	[LastName] [nvarchar](100) NOT NULL,
	[BirthDay] [datetime] NOT NULL,
	[AccountName] [nvarchar](256) NOT NULL,
	[Password] [nvarchar](128) NOT NULL,
	[Salt] [nvarchar](128) NOT NULL,
	[IsActivated] [bit] NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[IsActivated] [bit] NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteRenders]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteRenders](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](1000) NOT NULL,
	[Namespace] [nvarchar](1000) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_NoteRenders] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteCatalogues]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteCatalogues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Schema] [xml] NOT NULL,
	[RenderID] [int] NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_NoteCatalogues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ContactInfoCatalogues]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ContactInfoCatalogues](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ContactInfoCatalogues] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notes]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](1000) NOT NULL,
	[Content] [xml] NOT NULL,
	[CatalogId] [int] NOT NULL,
	[AuthorID] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Ts] [timestamp] NOT NULL,
 CONSTRAINT [PK_Notes] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Emails]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emails](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](1000) NOT NULL,
	[Owner] [int] NOT NULL,
	[IsPrimary] [bit] NOT NULL,
	[Catalog] [int] NOT NULL,
	[IsActivated] [bit] NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Emails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Phones]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phones](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[AreaCode] [int] NULL,
	[Phone] [nvarchar](1000) NOT NULL,
	[Extension] [int] NULL,
	[Owner] [int] NOT NULL,
	[Country] [nvarchar](3) NULL,
	[Catalog] [int] NOT NULL,
	[IsActivated] [bit] NOT NULL,
	[Description] [nvarchar](1000) NULL,
 CONSTRAINT [PK_Phones] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NoteTagRefs]    Script Date: 03/05/2018 16:05:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoteTagRefs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Note] [int] NOT NULL,
	[Tag] [int] NOT NULL,
 CONSTRAINT [PK_NoteTagRefs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_Emails_ContactInfoCatalogues]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Emails]  WITH CHECK ADD  CONSTRAINT [FK_Emails_ContactInfoCatalogues] FOREIGN KEY([Catalog])
REFERENCES [dbo].[ContactInfoCatalogues] ([ID])
GO
ALTER TABLE [dbo].[Emails] CHECK CONSTRAINT [FK_Emails_ContactInfoCatalogues]
GO
/****** Object:  ForeignKey [FK_Emails_Users]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Emails]  WITH CHECK ADD  CONSTRAINT [FK_Emails_Users] FOREIGN KEY([Owner])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Emails] CHECK CONSTRAINT [FK_Emails_Users]
GO
/****** Object:  ForeignKey [FK_Notes_NoteCatalogues]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_Notes_NoteCatalogues] FOREIGN KEY([CatalogId])
REFERENCES [dbo].[NoteCatalogues] ([ID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_NoteCatalogues]
GO
/****** Object:  ForeignKey [FK_Notes_Users]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Notes]  WITH CHECK ADD  CONSTRAINT [FK_Notes_Users] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Notes] CHECK CONSTRAINT [FK_Notes_Users]
GO
/****** Object:  ForeignKey [FK_NoteTagRefs_Notes]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[NoteTagRefs]  WITH CHECK ADD  CONSTRAINT [FK_NoteTagRefs_Notes] FOREIGN KEY([Note])
REFERENCES [dbo].[Notes] ([ID])
GO
ALTER TABLE [dbo].[NoteTagRefs] CHECK CONSTRAINT [FK_NoteTagRefs_Notes]
GO
/****** Object:  ForeignKey [FK_NoteTagRefs_Tags]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[NoteTagRefs]  WITH CHECK ADD  CONSTRAINT [FK_NoteTagRefs_Tags] FOREIGN KEY([Tag])
REFERENCES [dbo].[Tags] ([ID])
GO
ALTER TABLE [dbo].[NoteTagRefs] CHECK CONSTRAINT [FK_NoteTagRefs_Tags]
GO
/****** Object:  ForeignKey [FK_Phones_ContactInfoCatalogues]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Phones]  WITH CHECK ADD  CONSTRAINT [FK_Phones_ContactInfoCatalogues] FOREIGN KEY([Catalog])
REFERENCES [dbo].[ContactInfoCatalogues] ([ID])
GO
ALTER TABLE [dbo].[Phones] CHECK CONSTRAINT [FK_Phones_ContactInfoCatalogues]
GO
/****** Object:  ForeignKey [FK_Phones_Users]    Script Date: 03/05/2018 16:05:01 ******/
ALTER TABLE [dbo].[Phones]  WITH CHECK ADD  CONSTRAINT [FK_Phones_Users] FOREIGN KEY([Owner])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Phones] CHECK CONSTRAINT [FK_Phones_Users]
GO
