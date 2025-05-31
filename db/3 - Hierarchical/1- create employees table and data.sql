USE [Exam]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 2025/05/30 8:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](50) NOT NULL,
	[last_name] [varchar](50) NOT NULL,
	[manager_id] [int] NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[employees] ON 
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (1, N'Alvin', N'Smith', NULL)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (2, N'Jose', N'Jones', 1)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (3, N'Amado', N'Taylor', 1)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (4, N'Stuart', N'Williams', 1)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (5, N'Demarcus', N'Brown', 2)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (6, N'Mark', N'Davies', 2)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (7, N'Merlin', N'Evans', 2)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (8, N'Elroy', N'Wilson', 7)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (9, N'Charles', N'Thomas', 7)
GO
INSERT [dbo].[employees] ([employee_id], [first_name], [last_name], [manager_id]) VALUES (10, N'Rudolph', N'Roberts', 7)
GO
SET IDENTITY_INSERT [dbo].[employees] OFF
GO
