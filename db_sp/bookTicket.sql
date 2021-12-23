CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_BookTicket`(
	in in_user_id int(10),
    in in_train_id int(11),
	in in_departure_station int,
	in in_arrival_station int,
	in in_train_date date,
    out num_row int(100)
)
BEGIN
	select seat_id into @seat_id from tbl_Seat
    order by rand()
    limit 1;
    
    while (
		exists 
			(select seat_id from tbl_Ticket 
			where
				@seat_id = seat_id
            and
				in_train_id = train_id
			and
				in_train_date = train_date)
    ) do
		select seat_id into @seat_id from tbl_Seat
		order by rand()
		limit 1;
    end while; -- end while
    
    set @price = 100 * abs(
		(select location_marker from tbl_Station where in_departure_station = station_id)
		- (select location_marker from tbl_Station where in_arrival_station = station_id));
    
    insert into tbl_Ticket
    values (
		null,
        in_user_id,
        in_train_date,
        in_train_id,
        in_departure_station,
        in_arrival_station,
        @seat_id,
        @price,
        now(),
        null
	);
    
    select ticket_id, user_id, train_id, departure_station, arrival_station, seat_id,
		book_time, train_date
	from tbl_Ticket
    where ticket_id = last_insert_id();
    
    select count(*) from tbl_Ticket 
    where
		in_user_id = user_id
	and in_train_id = train_id
    and @seat_id = seat_id
    and in_departure_station = departure_station
    and in_arrival_station = arrival_station
    into num_row;
    
END