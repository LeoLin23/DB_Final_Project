CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_GetStation`(
	out row_num int
)
BEGIN
	SELECT station_id, station_name FROM tbl_Station;
    SELECT COUNT(*) FROM tbl_Station INTO row_num;
END