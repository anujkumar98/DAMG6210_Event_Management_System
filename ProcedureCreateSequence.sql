DECLARE
    v_seq_name VARCHAR2(30);
    v_seq_count NUMBER;
BEGIN
    FOR seq_info IN (
        WITH application_sequence_name AS (
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
        )
        SELECT seq_name FROM application_sequence_name
    ) LOOP
        v_seq_name := seq_info.seq_name;

        -- Check if the sequence exists in user_sequences
        SELECT COUNT(*)
        INTO v_seq_count
        FROM user_sequences
        WHERE sequence_name = v_seq_name;

        IF v_seq_count = 0 THEN
            -- If count is 0, sequence doesn't exist, create it
            EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || v_seq_name;
            DBMS_OUTPUT.PUT_LINE('Sequence ' || v_seq_name || ' created.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Sequence ' || v_seq_name || ' already exists.');
        END IF;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

