DELETE FROM contact_queue_items;

INSERT INTO contact_queue_items
SELECT Contact_Queue_ID, Add_Date_Time, Completed_Date_Time, family_id, Add_Notes, Is_Completed, Completed_Date_Time, Completed_By_Email, Completed_Notes
FROM `veritasclass`.Contact_Queue