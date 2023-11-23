--Cleanup activity
-- Drop table 
-- Drop sequenes
-- Drop users

SET SERVEROUTPUT ON;
--Drop tables
DECLARE
    v_table_exists VARCHAR2(1) := 'Y';
    v_sql VARCHAR2(2000);
BEGIN
    DBMS_OUTPUT.PUT_LINE('Start schema cleanup');

    FOR i IN (
        SELECT 'booking' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'ticket' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'promotions' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'reviews' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'events' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'event_type' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'attendee' TABLE_NAME FROM DUAL
        UNION ALL
        SELECT 'venue' TABLE_NAME FROM DUAL
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Drop table ' || i.TABLE_NAME);
        
        BEGIN
            -- Check if the table exists
            SELECT 'Y' INTO v_table_exists
            FROM USER_TABLES
            WHERE TABLE_NAME = UPPER(i.TABLE_NAME);
            -- Drop the table
            v_sql := 'DROP TABLE ' || i.TABLE_NAME;
            EXECUTE IMMEDIATE v_sql;
            DBMS_OUTPUT.PUT_LINE('Table ' || i.TABLE_NAME || ' dropped successfully');
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Table already dropped');
        END;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Schema cleanup successfully completed');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Failed to execute code: ' || SQLERRM);
END;
/

--Drop Sequences
DECLARE
    v_seq_exists VARCHAR(1) := 'Y';
    v_sql        VARCHAR(2000);
BEGIN
    dbms_output.put_line('Start sequence cleanup');

    FOR i IN (
        SELECT 'SEQ_BOOKING' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_EVENT' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_EVENT_TYPE' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_PROMOTIONS' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_REVIEWS' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_ATTENDEE' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_VENUE' seq_name FROM dual
        UNION ALL
        SELECT 'SEQ_TICKET' seq_name FROM dual
    ) LOOP
        dbms_output.put_line('Drop sequence ' || i.seq_name);

        BEGIN
            SELECT 'Y'
            INTO v_seq_exists
            FROM user_sequences
            WHERE sequence_name = i.seq_name;

            v_sql := 'DROP SEQUENCE ' || i.seq_name;
            EXECUTE IMMEDIATE v_sql;

            dbms_output.put_line('Sequence ' || i.seq_name || ' dropped successfully');
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line('Sequence already dropped');
        END;
    END LOOP;

    dbms_output.put_line('Sequence cleanup successfully completed');

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('***Failed to execute code: ' || sqlerrm || '***');
END;
/

-- Drop Users
DECLARE
    v_user_not_in_all_users VARCHAR2(50);
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

        -- Check if the user exists in all_users
        SELECT COUNT(*)
        INTO v_user_count
        FROM all_users
        WHERE username = v_user_not_in_all_users;

        IF v_user_count = 0 THEN
            DBMS_OUTPUT.PUT_LINE('User ' || v_user_not_in_all_users || ' does not exists.');
        ELSE
            EXECUTE IMMEDIATE 'DROP USER ' || v_user_not_in_all_users || ' CASCADE';
            DBMS_OUTPUT.PUT_LINE('User ' || v_user_not_in_all_users || ' dropped.');
        END IF;
    END LOOP;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

