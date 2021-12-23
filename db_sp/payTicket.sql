CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_PayTicket`(
	in in_user_id int(10),
	in in_ticket_id int(11),
    out affected_row_num int(100)
)
BEGIN
	DROP TEMPORARY TABLE IF EXISTS `result_set`;
	create temporary table result_set
	select ticket_id, train_id, user_id, tbl_Ticket.departure_station, arrival_station,
	seat_id, book_time, departure_time, arrival_time, price, pay_time from tbl_Train
	inner join tbl_Ticket
	using (train_id)
	where in_ticket_id = ticket_id
	and tbl_Ticket.departure_station = tbl_Train.departure_station;
	
    alter table result_set
    add primary key (ticket_id);
    
    select departure_station into @dep_station from result_set;
    select arrival_station into @arr_station from result_set;
    
	set @time_offset = sec_to_time(60*abs(
		(select time_marker from tbl_Station where station_id = @dep_station)
		- (select time_marker from tbl_Station where station_id = @arr_station)));
	
    update result_set
    set arrival_time = addtime(departure_time, @time_offset)
    where in_ticket_id = ticket_id;
    
	-- validate time
    if curdate() <= (
		select date_add(date(book_time), interval 2 day) from tbl_Ticket
		where in_ticket_id = ticket_id
	) then
		if curdate() = ( -- if current date is the same as book_time
				select train_date from tbl_Ticket
				where in_ticket_id = ticket_id
			) then -- check if is out of the 30 min limitation
				if curtime() <= (
					select subtime(departure_time, "0:30") from result_set
				) then
					update tbl_Ticket
					set pay_time = now()
					where in_ticket_id = ticket_id;
					set affected_row_num = row_count();
                    
					update result_set
					set pay_time = now()
					where in_ticket_id = ticket_id;
                    select * from result_set;
				else
					set affected_row_num = 0;
				end if; -- end if
		else 
			update tbl_Ticket
			set pay_time = now()
			where in_ticket_id = ticket_id;
			set affected_row_num = row_count();
            
			update result_set
			set pay_time = now()
			where in_ticket_id = ticket_id;
            select * from result_set;
        end if; -- end if
	else
		set affected_row_num = 0;
    end if; -- end if
    
    
END