DELETE FROM families;
INSERT INTO families
SELECT family_id,
`Last_Name`, `Address`, `City_State_Zip`, `Home_Phone`,`Anniversary`,
 `His_First_Name`, `His_Email_Address`, `His_Cell_Phone`,  `His_Birthday`,
`Her_First_Name`, `Her_Email_Address`, `Her_Cell_Phone`, `Her_Birthday`,
  `Notes`, `Is_Member`, `Is_Member_Date`,  `Is_Active`, `Create_Date`, `sysdate`
FROM `veritasclass`.Couple