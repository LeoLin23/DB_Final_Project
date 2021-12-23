CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_QueryTicket`(
    in in_departure_time datetime,
    in in_departure_station int,
    in in_arrival_station int,
    out num_row int(100)
)
BEGIN
    set @dep_date = date(in_departure_time);
    set @dep_time = date_format(in_departure_time, "%H:%i:%s");
    
    -- to store the trains which will departure from in_departure_station
    DROP TEMPORARY TABLE IF EXISTS `temp_1`;
    create temporary table temp_1 select train_id, departure_time from tbl_Train limit 0;
    
    insert into temp_1
    select train_id, departure_time from tbl_Train
    where in_departure_station = departure_station
    and @dep_time >= departure_time;
    
    -- to store the trains that will arrive at in_arrival_station
    DROP TEMPORARY TABLE IF EXISTS `temp_2`;
    create temporary table temp_2 select train_id from tbl_Train limit 0;
    
    insert into temp_2
    select train_id from tbl_Train
    where train_id in(select train_id from temp_1)
    and in_arrival_station = departure_station;
    
    -- to store the trains that will arrive at in_arrival_station
    DROP TEMPORARY TABLE IF EXISTS `valid_train`;
    create temporary table valid_train(
        train_id int primary key
    );
    
    -- check if there is any available seat
    insert into valid_train
    select train_id
    from tbl_Ticket
    where train_date = @dep_date
    and train_id in (select train_id from temp_2)
    group by train_id
    having count(*) < 40;
    
    alter table valid_train add column departure_station int default 1;
    update valid_train set departure_station = in_departure_station
    where train_id > 0;
    
    alter table valid_train add column arrival_station int default 1;
    update valid_train set arrival_station = in_arrival_station
    where train_id > 0;
    
    alter table valid_train add column departure_time time default null;
    update valid_train set departure_time = (
        select departure_time from temp_1 where
        valid_train.train_id = temp_1.train_id
    )
    where train_id > 0;
    
    set @time_offset = abs(
        (select time_marker from tbl_Station where in_departure_station = station_id)
        - (select time_marker from tbl_Station where in_arrival_station = station_id));
    
    alter table valid_train add column time_offset time default null;
    update valid_train set time_offset = sec_to_time(@time_offset*60)
    where train_id > 0;
    
    alter table valid_train add column arrival_time time generated always as (
        addtime(departure_time, time_offset)
    );
    
    -- price
    set @price = 100 * abs(
        (select location_marker from tbl_Station where in_departure_station = station_id)
        - (select location_marker from tbl_Station where in_arrival_station = station_id));
    alter table valid_train add column price int default 0;
    update valid_train set price = @price
    where train_id > 0;
    
    select train_id, departure_station, arrival_station, departure_time, arrival_time, price from valid_train;
        
    select count(*) into num_row from valid_train;
END