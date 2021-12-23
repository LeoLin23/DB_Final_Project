CREATE DEFINER=`ncu-107403519`@`192.168.56.1` PROCEDURE `sp_RegisterUser`(
	in in_email varchar(255),
    in in_firstname varchar(100),
    in in_lastname varchar(100),
    in in_dob date,
    in in_salt char(64),
    in in_hashedPwd char(255),
    out affected_row_num int(100)
)
BEGIN
	if exists (select user_id from tbl_User where in_email = email) then
		set affected_row_num = 0;
	else
		-- User table
		INSERT INTO tbl_User
		VALUES (
			null, -- user_id
			in_email,
			in_firstname,
			in_lastname,
			in_dob,
			in_salt,
            CURDATE(),
            0
		);
        
        -- UserCredential table
        select user_id, register_date into @uid, @r_date from tbl_User where in_email = email;
        
        insert into tbl_UserCredential
        values (
			null, -- user_credential
            @uid,
            in_hashedPwd,
            @r_date
        );
        
		set affected_row_num = ROW_COUNT();
	end if; -- end if
END