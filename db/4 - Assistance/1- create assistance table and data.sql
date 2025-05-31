USE [Exam]
GO
/****** Object:  Table [dbo].[assistance]    Script Date: 2025/05/30 8:06:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[assistance](
	[assistance_id] [int] IDENTITY(1,1) NOT NULL,
	[employee_id] [int] NOT NULL,
	[absence_type_id] [int] NOT NULL,
	[num_of_hours] [int] NOT NULL,
	[absence_date] [datetime] NOT NULL,
 CONSTRAINT [PK_assistance] PRIMARY KEY CLUSTERED 
(
	[assistance_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[assistance] ON 
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (1, 5, 2, 9, CAST(N'2017-01-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (2, 5, 2, 9, CAST(N'2017-01-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (3, 5, 3, 6, CAST(N'2017-01-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (4, 6, 2, 6, CAST(N'2017-01-02T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (5, 6, 3, 6, CAST(N'2017-01-05T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (6, 6, 8, 9, CAST(N'2017-01-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (7, 7, 2, 2, CAST(N'2017-12-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (8, 7, 8, 5, CAST(N'2017-12-13T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (9, 7, 8, 1, CAST(N'2017-12-08T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (10, 7, 8, 9, CAST(N'2017-12-07T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (11, 8, 2, 3, CAST(N'2017-09-14T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (12, 8, 3, 2, CAST(N'2017-09-15T00:00:00.000' AS DateTime))
GO
INSERT [dbo].[assistance] ([assistance_id], [employee_id], [absence_type_id], [num_of_hours], [absence_date]) VALUES (13, 8, 8, 9, CAST(N'2017-09-18T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[assistance] OFF
GO
