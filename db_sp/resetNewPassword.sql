CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_ResetNewPassword`(
	in in_user_id int(10),
    in in_hashedPwd char(255),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_user_id = user_id) then
		update tbl_UserCredential
        set
			hashedPwd = in_hashedPwd
		where
			user_id = in_user_id;
	set affected_row_num = ROW_COUNT();
	end if; -- end if
END