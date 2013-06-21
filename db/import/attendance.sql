DELETE FROM attendances;
INSERT INTO attendances
SELECT Attendance_ID, family_id, Date, Husband_Present, Wife_Present, Date, Date
FROM `veritasclass`.Attendance
where Attendance_Type_ID = 1