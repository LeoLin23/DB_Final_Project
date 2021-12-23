CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_Delete_bookticket`(
	in in_user_id int(10),
    in in_ticket_id int(11),
    out affected_row_num int(100)
)
BEGIN
	-- only delete the ticket if it is not paid
	delete from tbl_Ticket where
	in_user_id = user_id and
    in_ticket_id = ticket_id and
	pay_time is null;
    
    set affected_row_num = ROW_COUNT();
END