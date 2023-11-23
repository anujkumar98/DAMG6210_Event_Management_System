# DAMG6210_Event_Management_System
A SQL project developed for DAMG6210, an event management system designed to efficiently organize and manage events.

Database Used : Oracle 19c

Language : Oracle PL/SQL

### Problem statement
Proposed Event Booking System addresses challenges in fragmented event management, providing a centralized, user-friendly platform. It ensures data consistency and prevents overbooking by efficiently managing concurrent transactions. Aimed at streamlining event organization, ticket sales, and user interactions, it enhances efficiency and security in the entertainment industry.

### Steps to run


<ol>
<li>
Run <b>ProcedureCreateUsers.sql</b> as ADMIN to create the users.
</li>
<li>
Connect as  <b>EVENT_APP_ADMIN</b> into the database.
</li>
<li>
Run the  <b>ProcedureCreateTables.sql</b> to create the tables and adding foreign key constraints for the tables.
</li>
<li>
Run the  <b>ProcedureCreateSequence.sql</b> to create the sequences.
</li>
<li>
Run the <b>UserDefinedViews.sql</b> to create views for DML.
</li>
<li>
Connect back as <b>ADMIN</b> to grant permission for the users.
</li>
<li>
Run the <b>ProcedureGrantPermission.sql</b> to grant permission for the users.
</li>
<li>
Run the <b>ProcedureGrantPermission.sql</b> to grant permission for the users.
</li>
<li>
Connect as  <b>EVENT_APP_ADMIN</b> into the database.
</li>
<li>
Run the <b>ProcedureInsertData.sql</b> to create procedures for DML.
</li>
<li>
Incase of errors <b>ProcedureCleanup.sql</b> can be run to drop tables, constraints, views, sequences and users.
</li>
</ol>