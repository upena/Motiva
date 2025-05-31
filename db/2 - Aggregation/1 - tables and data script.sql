USE [Exam]
GO
/****** Object:  Table [dbo].[tblAuthor]    Script Date: 2025/05/30 7:51:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAuthor](
	[AuthorId] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblAuthor] PRIMARY KEY CLUSTERED 
(
	[AuthorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDoctor]    Script Date: 2025/05/30 7:51:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDoctor](
	[DoctorId] [int] IDENTITY(1,1) NOT NULL,
	[DoctorNumber] [varchar](50) NOT NULL,
	[DoctorName] [varchar](50) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
	[FirstEpisodeDate] [datetime] NOT NULL,
	[LastEpisodeDate] [datetime] NOT NULL,
 CONSTRAINT [PK_tblDoctor] PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblEpisode]    Script Date: 2025/05/30 7:51:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEpisode](
	[EpisodeId] [int] IDENTITY(1,1) NOT NULL,
	[SeriesNumber] [varchar](50) NOT NULL,
	[EpisodeNumber] [varchar](50) NOT NULL,
	[EpisodeType] [varchar](50) NOT NULL,
	[Title] [varchar](50) NOT NULL,
	[EpisodeDate] [datetime] NOT NULL,
	[AuthorId] [int] NOT NULL,
	[DoctorId] [int] NOT NULL,
	[Notes] [varchar](50) NOT NULL,
 CONSTRAINT [PK_tblEpisode] PRIMARY KEY CLUSTERED 
(
	[EpisodeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[tblAuthor] ON 
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (1, N'Russel T. Davies')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (2, N'Matt Smith')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (3, N'Christopher Ecdeston')
GO
INSERT [dbo].[tblAuthor] ([AuthorId], [AuthorName]) VALUES (4, N'Peter Capaldi')
GO
SET IDENTITY_INSERT [dbo].[tblAuthor] OFF
GO
SET IDENTITY_INSERT [dbo].[tblDoctor] ON 
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (1, N'0001', N'David Tennant', CAST(N'2001-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (2, N'002', N'Matt Smith', CAST(N'2001-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (3, N'003', N'Christopher Ecdeston', CAST(N'2001-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[tblDoctor] ([DoctorId], [DoctorNumber], [DoctorName], [BirthDate], [FirstEpisodeDate], [LastEpisodeDate]) VALUES (4, N'004', N'Peter Capaldi', CAST(N'2001-05-25T00:00:00.000' AS DateTime), CAST(N'2025-06-04T00:00:00.000' AS DateTime), CAST(N'2025-07-02T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[tblDoctor] OFF
GO
SET IDENTITY_INSERT [dbo].[tblEpisode] ON 
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (2, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (3, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (4, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 3, 1, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (5, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 4, 4, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (6, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (7, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (8, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 3, 1, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (9, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 4, 4, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (10, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (11, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (12, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 3, 1, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (13, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 4, 4, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (14, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (15, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 1, 2, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (16, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 3, 1, N'Episodio')
GO
INSERT [dbo].[tblEpisode] ([EpisodeId], [SeriesNumber], [EpisodeNumber], [EpisodeType], [Title], [EpisodeDate], [AuthorId], [DoctorId], [Notes]) VALUES (17, N'1', N'1', N'Drama', N'500 days with summer', CAST(N'2025-05-01T00:00:00.000' AS DateTime), 4, 4, N'Episodio')
GO
SET IDENTITY_INSERT [dbo].[tblEpisode] OFF
GO
ALTER TABLE [dbo].[tblEpisode]  WITH CHECK ADD  CONSTRAINT [FK_tblEpisode_tblAuthor] FOREIGN KEY([AuthorId])
REFERENCES [dbo].[tblAuthor] ([AuthorId])
GO
ALTER TABLE [dbo].[tblEpisode] CHECK CONSTRAINT [FK_tblEpisode_tblAuthor]
GO
ALTER TABLE [dbo].[tblEpisode]  WITH CHECK ADD  CONSTRAINT [FK_tblEpisode_tblDoctor] FOREIGN KEY([DoctorId])
REFERENCES [dbo].[tblDoctor] ([DoctorId])
GO
ALTER TABLE [dbo].[tblEpisode] CHECK CONSTRAINT [FK_tblEpisode_tblDoctor]
GO
