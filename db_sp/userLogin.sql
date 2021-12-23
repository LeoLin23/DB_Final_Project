CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_UserLogin`(
	in in_email varchar(255),
    in in_hashedPwd char(255),
	out row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_email = email) then
		select user_id into @query_user_id from tbl_User 
        where in_email = email;
        
		select hashedPwd into @validPwd from tbl_UserCredential
        where user_id = @query_user_id;
        if (@validPwd = in_hashedPwd) then
			set row_num = @query_user_id;
		else
			set row_num = @query_user_id;
		end if; -- end if
	end if; -- end if
END