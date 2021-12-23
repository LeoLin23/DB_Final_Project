CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_DeleteUserByUserID`(
	in in_user_id int(10),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_user_id = user_id) then
        /* if there exists any ticket booked by this user, it is paid,
        so both the ticket and the user cannot be deleted */
        if not exists (select user_id from tbl_Ticket where in_user_id = user_id) then
			-- clear user data
			update tbl_User
			set
				email = null,
				firstname = null,
				lastname = null,
				dob = null,
				salt = null,
				is_deleted = 1
			where
				user_id = in_user_id;
			
			-- clear user credential data
			update tbl_UserCredential
			set
				hashedPwd = null
			where
				user_id = in_user_id;
        end if; -- end if
	end if; -- end if
    
    set affected_row_num = ROW_COUNT();
END