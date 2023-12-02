# DAMG6210_Event_Management_System
A SQL project developed for DAMG6210, an event management system designed to efficiently organize and manage events.

Database Used : Oracle 19c

Language : Oracle PL/SQL

### Problem statement
Proposed Event Booking System addresses challenges in fragmented event management, providing a centralized, user-friendly platform. It ensures data consistency and prevents overbooking by efficiently managing concurrent transactions. Aimed at streamlining event organization, ticket sales, and user interactions, it enhances efficiency and security in the entertainment industry.

### Roles

<ol>
<li>Event App Admin </<li>
<li>Event Manager </<li>
<li>Attendee</li>
</ol>


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
Run the <b>PKG_APP_ADMIN/pkg_app_admin.sql</b> to create package for Event App admin.
</li>
<li>
Run the <b>PKG_EVENT_MANAGER/pkg_event_manager.sql</b> to create package for event manager.
</li>
<li>
Run the <b>PKG_ATTENDEE/pkg_attendee.sql</b> to create package for attendee.
</li>
<li>
Run the <b>Functions.sql</b> to create functions.
</li>
<li>
Run the <b>Trigger.sql</b> to create trigger.
</li>
<li>
Run the <b>Index.sql</b> to create Index.
</li>
<li>
Run the <b>ProcedureGrantPermission.sql</b> to grant permission for the users.
</li>
<li>
Run <b>PKG_Inserts/Inserts_Event_App_Admin.sql</b> to insert data into the event app managed tables.
</li>
<li>Connect as Event Manager into database</li>
<li>
Run <b>PKG_Inserts/Inserts_Event_Manager.sql</b> to insert data into the event manager managed tables.
</li>
<li>Connect as Attendee into database</li>
<li>
Run <b>PKG_Inserts/Inserts_Attendee.sql</b> to insert data into the attendee managed tables.
</li>
<li>
Incase of errors <b>ProcedureCleanup.sql</b> can be run to drop tables, constraints, views, sequences and users.
</li>
</ol>
