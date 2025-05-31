USE [Exam]
GO

/****** Object:  View [dbo].[episodecount_view]    Script Date: 2025/05/30 7:54:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[episodecount_view]
AS

	SELECT 
		a.AuthorName
		,d.DoctorName
		,COUNT(*) AS Episodes
	FROM tblEpisode e
	JOIN tblAuthor a ON a.AuthorId = e.AuthorId
	JOIN tblDoctor d ON d.DoctorId = e.DoctorId
	GROUP BY a.AuthorName,d.DoctorName

GO


