DELETE FROM podcasts;
INSERT INTO podcasts
SELECT Lesson_ID, Created, Created, Date, Title, Speaker, Audio_File_Name
FROM `veritasclass`.Lesson