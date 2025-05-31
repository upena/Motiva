-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Ulises Peña
-- Create date: 30-05-2025
-- Description:	Count the characters in the input word
-- =============================================
CREATE PROCEDURE sp_characterCount
	@Word VARCHAR(100) = NULL
AS
BEGIN
	SET NOCOUNT ON;

	WITH Letters AS (
		SELECT 
			SUBSTRING(@Word, number, 1) AS letter
		FROM master..spt_values
		WHERE type = 'P'
		  AND number BETWEEN 1 AND LEN(@Word)
	)
	SELECT 
		letter,
		COUNT(*) AS frequency
	FROM Letters
	WHERE letter COLLATE Latin1_General_BIN LIKE '[a-zA-Z]'
	GROUP BY letter
	ORDER BY letter;

END
GO
