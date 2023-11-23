SET SERVEROUTPUT ON;
alter session set nls_timestamp_format = 'DD-MON-RR HH.MI';

DECLARE
    v_user_not_in_all_users VARCHAR2(50);
    v_password              VARCHAR2(50);
    v_user_count            NUMBER;
BEGIN
    FOR i IN (
        WITH application_users AS (
            SELECT 'EVENT_APP_ADMIN' AS app_user FROM dual
            UNION ALL
            SELECT 'EVENT_MANAGER' AS app_user FROM dual
            UNION ALL
            SELECT 'ATTENDEE' AS app_user FROM dual
        )
        SELECT app_user
        FROM application_users
    ) LOOP
        v_user_not_in_all_users := i.app_user;
        v_password := 'Password123#';

        -- Check if the user exists in all_users
        SELECT COUNT(*)
        INTO v_user_count
        FROM all_users
        WHERE username = v_user_not_in_all_users;
        IF v_user_count = 0 THEN
            -- If count is 0, user doesnt exist, create it
            EXECUTE IMMEDIATE 'CREATE USER ' || v_user_not_in_all_users || ' IDENTIFIED BY ' || v_password;
            DBMS_OUTPUT.PUT_LINE('User ' || v_user_not_in_all_users || ' created successfully with password ' || v_password);
            IF v_user_not_in_all_users = 'EVENT_APP_ADMIN' THEN
                -- EVENT_APP_ADMIN gets all privileges on the tablespace
                
                EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO ' || v_user_not_in_all_users;
                EXECUTE IMMEDIATE 'ALTER USER '|| v_user_not_in_all_users || ' QUOTA UNLIMITED ON DATA';
                EXECUTE IMMEDIATE 'GRANT CREATE VIEW TO '|| v_user_not_in_all_users;
                DBMS_OUTPUT.PUT_LINE('Granted ALL PRIVILEGES to ' || v_user_not_in_all_users);
            ELSIF v_user_not_in_all_users = 'EVENT_MANAGER' THEN
                -- EVENT_MANAGER gets specific privileges
                EXECUTE IMMEDIATE 'GRANT CONNECT, RESOURCE TO ' || v_user_not_in_all_users;
                EXECUTE IMMEDIATE 'ALTER USER '|| v_user_not_in_all_users || ' QUOTA 250M ON DATA';
                DBMS_OUTPUT.PUT_LINE('Granted CONNECT, RESOURCE and TABLESPACE to ' || v_user_not_in_all_users);
            ELSIF v_user_not_in_all_users = 'ATTENDEE' THEN
                -- ATTENDEE gets specific privileges
                EXECUTE IMMEDIATE 'GRANT CONNECT TO ' || v_user_not_in_all_users;
                EXECUTE IMMEDIATE 'ALTER USER ' || v_user_not_in_all_users || ' QUOTA 250M ON DATA';
                DBMS_OUTPUT.PUT_LINE('Granted CONNECT and RESOURCE to ' || v_user_not_in_all_users);
            END IF;
        ELSE
            DBMS_OUTPUT.PUT_LINE('User ' || v_user_not_in_all_users || ' already exists.');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
