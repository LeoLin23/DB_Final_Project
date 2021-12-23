CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_GetBookTicketByUser`(
	in in_user_id int(10),
    out num_row int(100)
)
BEGIN
	-- return the unpaid tickets
	select
		ticket_id,
		user_id as userID,
		train_id,
		seat_id,
		book_time
	from tbl_Ticket
	where 
	in_user_id = user_id and
	pay_time is null;
	
    select count(*) from tbl_Ticket where
    in_user_id = user_id and
	pay_time is null
    into num_row;
    
    
END