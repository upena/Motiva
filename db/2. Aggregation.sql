SELECT 
	a.AuthorName
	,d.DoctorName
	,COUNT(*) AS Episodes
FROM tblEpisode e
JOIN tblAuthor a ON a.AuthorId = e.AuthorId
JOIN tblDoctor d ON d.DoctorId = e.DoctorId
GROUP BY a.AuthorName,d.DoctorName