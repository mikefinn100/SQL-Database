/*
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************

																		The order of some of the queries may be different from the pdf file submitted but everything there should be represented somewhere in this file.
																		
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************
***********************************************************************************************************************************************************************************************************************************************************


**********************************************   4 INNER JOINS    ************************************************************
*/


/*
Which members have been assigned Car parking Spaces?
*/
SELECT  Fname, Sname, pk_parking_space
FROM A_Members
INNER JOIN A_Parking_Space
ON pk_member_id = member_id;





/*
Which members were late with paying their membership fees and when did they actually pay them?
*/
SELECT  Fname, Sname, date_paid
FROM A_Members
INNER JOIN A_Payment
ON pk_member_id = member_id
WHERE date_paid > TO_DATE('04/FEB/2014','dd/mon/yyyy') AND category_id = 1;






/*
How many payments were made with cash?
*/
SELECT  count(type_id) AS NUmber_Of_Cash_Payments
FROM A_Payment
INNER JOIN A_Payment_Types
ON A_Payment.type_id = A_Payment_Types.pk_type_id
WHERE  type_id = 3;




/*
Find a list of all the members with car parking spaces and the space number?
*/
SELECT  Fname, Sname, pk_parking_space
FROM A_Members
INNER JOIN A_Parking_Space
ON A_Members.pk_member_id = A_Parking_Space.member_id;




/*
**********************************************   6 OUTER JOINS    ************************************************************
*/



/*
										2 LEFT OUTER JOINS
*/

/*
Show the parking space status of all of the members?
*/

SELECT Fname, Sname, pk_parking_space
FROM  A_Members
LEFT OUTER JOIN A_Parking_Space 
ON A_Members.pk_member_id = A_Parking_Space.member_id
ORDER BY pk_parking_space;







/*
Which members have taken lessons on what dates and which members have not yet taken lessons?
*/

SELECT  Fname, Sname, datetime_lesson
FROM A_Members
LEFT OUTER JOIN A_member_lesson
ON A_Members.pk_member_id = A_member_lesson.member_id
LEFT OUTER JOIN A_Lessons ON A_Lessons.pk_lesson_id = A_member_lesson.lesson_id
GROUP BY Fname, Sname, datetime_lesson
ORDER BY datetime_lesson
;




/*
										2 FULL OUTER JOINS
*/

/*
Show all members that have been assigned a car parking space, 
those that have not and the remaining available spots.

When creating the database I created the 150 car parking spaces so that they will just be assigned as and when 
they are needed.
*/

column c1 heading Fname 			Format a15
column c2 heading Sname    			Format a15
column c3 heading pk_parking_space	Format 99


SELECT Fname as c1, Sname as c2, pk_parking_space
FROM  A_Members
FULL OUTER JOIN A_Parking_Space 
ON A_Members.pk_member_id = A_Parking_Space.member_id
ORDER BY Fname, Sname;








/*
Show a list of the tournaments that each member has entered including members that have not entered any?
--there will be a couple of tournaments with no entrants and a couple of members that have not 
entered any tournaments
*/

column c1 heading Fname 			Format a15
column c2 heading Sname    			Format a15
column c3 heading tournament_name	Format a20

SELECT Fname as c1, Sname as c2, tournament_name as c3
FROM  A_Members
FULL OUTER JOIN A_Participation_Results
ON A_Members.pk_member_id = A_Participation_Results.cpk_member_id
FULL OUTER JOIN A_Tournaments 
ON A_Participation_Results.cpk_tournament_id = A_Tournaments.pk_tournament_id;







/*
										2 RIGHT OUTER JOINS
*/


/*
How many payments were made with each payment type? 
Were there any payment types not used? 
Sorted by the most popular.
*/

SELECT type_name, count(category_id)
FROM  A_Payment
RIGHT OUTER JOIN A_Payment_Types
ON A_Payment.type_id = A_Payment_Types.pk_type_id
Group by type_name
Order BY count(category_id) DESC
;








/*
Give a list of the coaches and their specialties including any specialties that do not 
have an assigned coach.
*/
column c1 heading Fname 			Format a15
column c2 heading Sname    			Format a15
column c3 heading Specialty 		Format a20

SELECT A_Coaches.Fname as c1, A_coaches.Sname as c2, specialty_name as c3
FROM  A_Coaches
FULL OUTER JOIN A_coach_specialty_junction
ON A_Coaches.pk_coach_id = A_coach_specialty_junction.coach_id
RIGHT OUTER JOIN A_Specialty
ON A_Specialty.pk_specialty_id = A_coach_specialty_junction.specialty_id;





















/*
							CUBE QUERY WITH AT LEAST TWO COLUMNS

In order to create a meaningful CUBE query I first had to create a VIEW to run it on. 
I called this vw_purchase_history and took in data from three tables. After this I performed 
the CUBE - which will measure total_paid against each of the attributes requested.
*/

column Name 						Format a20
column Description    			Format a25

CREATE OR REPLACE VIEW vw_purchase_history AS
SELECT A_Payment.date_paid as datePaid, 
A_Members.Fname||' '||A_Members.Sname AS Name, 
A_Payment_Categories.category_name as Description, 
(A_Payment_Categories.cost*A_Payment.quantity) as total_paid
FROM A_Payment
INNER JOIN A_Members 
ON A_Members.pk_member_id = A_Payment.member_id
INNER JOIN A_Payment_Categories
ON A_Payment.category_id = A_Payment_Categories.pk_category_id
;
SELECT * FROM vw_purchase_history Order By datePaid;

SELECT datePaid, Name, Description, sum(total_paid) AS Total
FROM vw_purchase_history
GROUP BY CUBE (datePaid, name, Description);






















/*
																5 SUBQUERIES

*/




/*Who paid the most for lessons in one purchase and how much did they spend*/
SELECT Name, total_paid
FROM vw_purchase_history
WHERE total_paid=(SELECT MAX(total_paid)FROM vw_purchase_history 
WHERE Description LIKE 'Lesson%');









/*
Which players scored the worst scores in the Tiger Woods Open
In the sub part of the query I have joined the two tables because 
tournamnet name is not stored in A_Participation_Results.
In the first part I am returning the details about the rows select in the sub part
*/
SELECT DISTINCT Fname, Sname, score
FROM A_members
Inner JOIN A_Participation_Results 
ON A_Members.pk_member_id = A_Participation_Results.cpk_member_id
WHERE score = (SELECT MAX(score)FROM A_Participation_Results 
Inner JOIN A_Tournaments 
ON A_Tournaments.pk_tournament_id = A_Participation_Results.cpk_tournament_id
WHERE tournament_name='Tiger Woods Open');









/*Who were the first to pay their membership?*/
SELECT Name, datePaid
FROM vw_purchase_history
WHERE datePaid = (SELECT MIN(datePaid)FROM vw_purchase_history
WHERE Description = 'Annual Membership');







/* Who is the most long-standing member?*/
SELECT Fname||' '||Sname AS Name, date_joined
FROM A_Members
WHERE date_joined = (SELECT MIN(date_joined)FROM A_Members);






/*
Which players have average scores better than the overall average?
As handicaps are already taken to account when compiling all scores this is a 
good indicator of the form players
*/
SELECT DISTINCT Fname, Sname, avg(score) 
FROM A_members
FULL OUTER JOIN A_Participation_Results 
ON A_Members.pk_member_id = A_Participation_Results.cpk_member_id
WHERE score < (SELECT Avg(score)FROM A_Participation_Results)
GROUP BY Fname, Sname
Order By avg(score)
;






/*
What are the handicaps of the members scoring rounds lower than 70?
This would be a good indicator of whether a member’s handicap is still relevant or accurate.
*/

SELECT fname, handicap
FROM A_Members WHERE pk_member_id IN (SELECT cpk_member_id FROM A_Participation_Results WHERE score<70);





/*
								5 PL/SQL procedures as part of one package.




My first procedure  createLesson is working over multiple tables and as such it was easeier to 
create a view and have it work off that. The view below shows a summary of all of the lessons and 
there related information.
*/

column memberName            Format a20
column coachName             Format a20
column Specialty             Format 99

cl scr;
CREATE OR REPLACE VIEW vw_lesson_history AS
SELECT A_member_lesson.datetime_lesson as lessonDate, 
A_Members.Fname||' '||A_Members.Sname AS memberName, 
A_coach_specialty_junction.specialty_id AS Specialty,
A_Coaches.Fname ||' '|| A_Coaches.Sname AS coachName, 
A_Lessons.duration_in_hours hours
FROM A_Members
INNER JOIN A_member_lesson 
ON A_Members.pk_member_id = A_member_lesson.member_id
INNER JOIN A_Lessons
ON A_member_lesson.lesson_id = A_Lessons.pk_lesson_idSELECT * FROM vw_lesson_history ORDER by lessonDate;
--Shows the lessonhistory
INNER JOIN A_Coaches
ON A_Coaches.pk_coach_id = A_Lessons.coach_id
INNER JOIN A_coach_specialty_junction
ON A_Coaches.pk_coach_id = A_coach_specialty_junction.coach_id
--INNER JOIN A_Specialty
--ON A_Specialty.pk_specialty_id = A_coach_specialty_junction.specialty_id
;



cl scr;
CREATE OR REPLACE PACKAGE project_package AS
PROCEDURE createLesson(member IN NUMBER, duration_in_hours IN NUMBER, datetime_lesson DATE, specialtyID IN NUMBER);
PROCEDURE deleteLesson(lesson IN NUMBER);
PROCEDURE createMember(Fname IN NVARCHAR2, Sname IN NVARCHAR2, address_line_1 IN NVARCHAR2,
address_line_2 IN NVARCHAR2, address_line_3 IN NVARCHAR2, tel_no IN NVARCHAR2);
PROCEDURE deleteMember(member IN NUMBER);
PROCEDURE processPayment(	amountOfItems IN NUMBER, 
	member IN NUMBER , paymentType IN NUMBER, category IN NUMBER, lessonDate DATE := NULL);
PROCEDURE ShowMembershipLength;
PROCEDURE TournamentParticipants(tournamentNumber IN NUMBER);

END;
/

CREATE OR REPLACE PACKAGE BODY project_package AS

PROCEDURE createLesson(member IN NUMBER, 
duration_in_hours IN NUMBER, datetime_lesson DATE, specialtyID IN NUMBER)
-- the procedure takes in parameters to create the lesson
IS 
CURSOR dateToCheck IS SELECT lessonDate FROM vw_lesson_history 
where Specialty = specialtyID;
-- the cursor is created to iterate through all of the currently taken lesson times for that specialty
-- as a way of checking whether the time is available
dateWanted DATE;
-- stores each date in order to check whether it is availabale
timeNotAvail EXCEPTION;
-- user defined exception
coach int;
-- we are not told which coach when someone books a lesson they just 
-- enter the specialty that they want. The database needs to find a 
-- coach with that specialty and assign them to the lesson. 
-- The coach variable stores the coach_id

BEGIN

OPEN dateToCheck;
--open cursor
FETCH dateToCheck INTO dateWanted;
WHILE dateToCheck%FOUND LOOP
-- this iterates through the record set 
	if dateWanted = datetime_lesson
		THEN
	      raise_application_error(-20010, 'There are no coaches available for this time and date');	
	      -- if the date we want to book is already taken raise an exception
	end if;

FETCH dateToCheck INTO dateWanted;
END LOOP;
CLOSE dateToCheck;
--close cursor
-- If the date is available we need to find a coach that specialises in the requested
-- specialty
SELECT coach_id INTO coach FROM A_coach_specialty_junction
WHERE A_coach_specialty_junction.specialty_id = specialtyID AND ROWNUM <=1;

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  duration_in_hours, coach );
-- create the lesson

INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(member, A_Lessons_sequence.currval, datetime_lesson); 
--create the instance of the lesson

END createLesson;





PROCEDURE deleteLesson(lesson IN NUMBER)
IS 
--do a check to see if the lesson exists
BEGIN
-- needs to be deleted in the following order in order to satisfy key constraints
DELETE FROM A_member_lesson WHERE lesson_id = lesson;
DELETE FROM A_Lessons WHERE pk_lesson_ID = lesson;
END deleteLesson;


PROCEDURE createMember(Fname IN NVARCHAR2, Sname IN NVARCHAR2, address_line_1 IN NVARCHAR2,
address_line_2 IN NVARCHAR2, address_line_3 IN NVARCHAR2, tel_no IN NVARCHAR2)
IS 
NoFirstName Exception;
-- this is the user defined exception
BEGIN
IF Fname IS NULL 
   THEN
      RAISE NoFirstName;
END IF;
INSERT INTO A_Members
VALUES(A_Members_sequence.nextval, Fname, Sname, address_line_1, address_line_2, address_line_3, tel_no, CURRENT_DATE, Null); 
EXCEPTION
   WHEN NoFirstName THEN
	DBMS_OUTPUT.PUT_LINE('You have not entered a first name.');
	-- Prints to the console if the user leaves the first name blank
END createMember;




PROCEDURE deleteMember(member IN NUMBER)
IS 
--do a check to see if the lesson exists
BEGIN

-- ******needs to be deleted in the following order in order to satisfy key constraints******

UPDATE A_Parking_Space SET member_id = NULL WHERE member_id = member;
-- if the member has a car parking space that needs to be unassigned(not deleted as all of the 
  --parking spaces are always stored in the database)

DELETE FROM A_member_lesson WHERE member_id = member AND datetime_lesson > (sysdate);
-- this deletes an instance of a  future lesson. Only deletes the future lessons 
--as we wish to keep a record of all past lessons  

DELETE FROM A_Lessons WHERE pk_lesson_id = (SELECT lesson_id FROM A_member_lesson 
WHERE member_id = member AND datetime_lesson > (sysdate));
--deletes the lesson so that the coach is no longer assigned. 

DELETE FROM A_Participation_Results 
WHERE cpk_member_id = member AND cpk_tournament_id = (SELECT pk_tournament_id FROM A_Tournaments 
WHERE tournament_date > (sysdate));
-- this deletes any possible registration that the member might have for a future tournament. 

DELETE FROM A_Members WHERE pk_member_id = member;
--delete the member record in the Members table

END deleteMember;










PROCEDURE processPayment(	amountOfItems IN NUMBER, 
	member IN NUMBER , paymentType IN NUMBER, category IN NUMBER, lessonDate DATE := NULL)
--by setting lessonDate DATE := NULL we have made lessonDate an optional parameter
-- this is because when booking a lesson a date is required whilst the other payments do not need a date.
IS

Fname NVARCHAR2(30);
Sname NVARCHAR2(30);
tournament NUMBER;
duration_in_hours NUMBER;
specialty NUMBER;
space NUMBER;
membership_id NUMBER;
invalidCat EXCEPTION;
--membership_id is required because otherwise
--when we try to insert member into cpk_tournament we get an error as there is a 
--possibility of a NUll vale being entered into a primary key field.
BEGIN

savepoint beforeInsert;
-- no field exists to be populated. This could happen if a member tries to pay for a 
--tournament that does not exist yet.
-- or if they try to pay for a parking space but none are available.

SELECT A_Members.Fname INTO Fname FROM A_Members WHERE A_Members.pk_member_id = member;
--stores the members firstname in Fname

SELECT A_Members.Sname INTO Sname FROM A_Members WHERE A_Members.pk_member_id = member;
--stores the members firstname in Fname
membership_id := member;

SELECT pk_tournament_id INTO tournament FROM A_Tournaments WHERE (tournament_date - sysdate) BETWEEN 0 AND 7;
-- This stores the closest future tournament in the variable tournament
-- There is a business rule that their is a tournament every 7 days.

if tournament is NULL then
  tournament :=-1;
end if;

if membership_id is NULL then
  membership_id :=-1;
end if;
-- these are required to avoid the null value being inserted into a the composite primary key for the table
-- A_Participation_Results

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, sysdate, amountOfItems, member, paymentType, category); 
--this creates the payment

CASE category
-- this case asigns the correct duration and specialty based on the correct category_id being entered
-- Nothing needs to occur when category_id = 1 as this membership.

WHEN 1 THEN 
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid their membership');

WHEN 2 THEN duration_in_hours := 1; Specialty := 1 ;
createLesson(member, duration_in_hours, lessonDate, specialty);
-- this calls another procedure to create the correct insert statements

WHEN 3 THEN duration_in_hours := 2; Specialty := 1;
createLesson(member, duration_in_hours, lessonDate, specialty);
-- this calls another procedure to create the correct insert statements etc

WHEN 4 THEN duration_in_hours := 1; Specialty :=  2;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 5 THEN duration_in_hours := 2; Specialty :=  2;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 6 THEN duration_in_hours := 1; Specialty :=  3;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 7 THEN duration_in_hours := 2; Specialty :=  3;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 8 THEN duration_in_hours := 1; Specialty :=  4;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 9 THEN duration_in_hours := 2; Specialty :=  4;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 10 THEN
-- 10 is the category type of a parking space
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a parking space');
SELECT pk_parking_space INTO space FROM A_Parking_Space where member_id IS NULL AND ROWNUM <=1; 
--selects the next available space
-- if all the parking spaces are already assigned the exception below will handle it by outputting the
-- error message and cancelling the payment.
UPDATE A_Parking_Space 
SET member_id = member WHERE pk_parking_space = space;


WHEN 11 THEN 
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 



WHEN 12 THEN
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 


WHEN 13 THEN
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 


WHEN 21 THEN duration_in_hours := 1; Specialty :=  5;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 22 THEN duration_in_hours := 2; Specialty :=  5;
createLesson(member, duration_in_hours, lessonDate, specialty);

ELSE DBMS_OUTPUT.PUT_LINE('No such category'); raise_application_error(-20011, 'This is not a category_id '||SQLCODE||' -ERROR- '||SQLERRM);	
END CASE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('The field you are trying to populate does not exist');
ROLLBACK to beforeInsert;
-- cancel the payment by the member. This will only delete the car parking payment as a member cannot 
--	have more than one assigned parking space
-- and as a result there will only be one payment where category =10.

WHEN invalidCat THEN
raise_application_error (-20006,'You have entered the incorrect category_id.');

END processPayment;









PROCEDURE ShowMembershipLength
IS
CURSOR memlen IS SELECT * FROM A_members Order by date_joined;
--create cursor
memberRow memlen%ROWTYPE;
membershipLength NUMBER;
date_joined DATE;
-- variables needed
BEGIN
OPEN memlen;
--open the cursor
FETCH memlen INTO memberRow;
--store the information from the cursor in the variable memberRow
WHILE memlen%FOUND LOOP
-- iterate through the record set until there are no more records
date_joined := memberRow.date_joined;
membershipLength := round(MONTHS_BETWEEN(sysdate, date_joined)/12);
--calculate how many whiole years the member has been joined
DBMS_OUTPUT.PUT_LINE('Name: ' ||memberRow.Fname||' '||memberRow.Sname|| ' Membership Length: '||membershipLength);

FETCH memlen INTO memberRow;
END LOOP;
-- close loop
CLOSE memlen;
--close the cursor
EXCEPTION
WHEN OTHERS THEN
raise_application_error(-20001, 'There was an error '||SQLCODE||' -ERROR- '||SQLERRM);	
--generic exception to deal which returns the error message associated with the most recently raised error exception
END ShowMembershipLength;





PROCEDURE TournamentParticipants(tournamentNumber IN NUMBER)
IS
CURSOR member IS SELECT Fname, Sname, tournament_name FROM A_members INNER JOIN A_Participation_results 
ON A_members.pk_member_id = A_Participation_results.cpk_member_id
INNER JOIN A_Tournaments
ON A_Participation_results.cpk_tournament_id = A_Tournaments.pk_tournament_id
WHERE tournamentNumber = A_Tournaments.pk_tournament_id;
-- creates a cursor from some joined tables.

memberRow member%ROWTYPE;

BEGIN
DBMS_OUTPUT.PUT_LINE('Member' ||'			'||'Tournament ');
OPEN member;
--open cursor
FETCH member INTO memberRow;
--store the information from the cursor in the variable memberRow

WHILE member%FOUND LOOP
-- iterate through the record set until there are no more records
DBMS_OUTPUT.PUT_LINE(memberRow.Fname || ' ' || memberRow.Sname ||'		'|| memberRow.tournament_name);	
FETCH member INTO memberRow;
END LOOP;
--end loop
CLOSE member;
--close cursor
EXCEPTION
WHEN OTHERS THEN
raise_application_error(-20001, 'There was an error '||SQLCODE||' -ERROR- '||SQLERRM);	
END TournamentParticipants;


END project_package;
/






/***************************** END OF PACKAGE**********************************************************
*******************************************************************************************************
*******************************************************************************************************


After this I have shown the creation of each procedure and shown the various 
tests to make sure it works as intended.

*/




CREATE OR REPLACE PROCEDURE createLesson(member IN NUMBER, 
duration_in_hours IN NUMBER, datetime_lesson DATE, specialtyID IN NUMBER)
-- the procedure takes in parameters to create the lesson
IS 
CURSOR dateToCheck IS SELECT lessonDate FROM vw_lesson_history 
where Specialty = specialtyID;
-- the cursor is created to iterate through all of the currently taken lesson times for that specialty
-- as a way of checking whether the time is available
dateWanted DATE;
-- stores each date in order to check whether it is availabale
timeNotAvail EXCEPTION;
-- user defined exception
coach int;
-- we are not told which coach when someone books a lesson they just 
-- enter the specialty that they want. The database needs to find a 
-- coach with that specialty and assign them to the lesson. 
-- The coach variable stores the coach_id

BEGIN

OPEN dateToCheck;
--open cursor
FETCH dateToCheck INTO dateWanted;
WHILE dateToCheck%FOUND LOOP
-- this iterates through the record set 
	if dateWanted = datetime_lesson
		THEN
	      raise_application_error(-20010, 'There are no coaches available for this time and date');	
	      -- if the date we want to book is already taken raise an exception
	end if;

FETCH dateToCheck INTO dateWanted;
END LOOP;
CLOSE dateToCheck;
--close cursor
-- If the date is available we need to find a coach that specialises in the requested
-- specialty
SELECT coach_id INTO coach FROM A_coach_specialty_junction
WHERE A_coach_specialty_junction.specialty_id = specialtyID AND ROWNUM <=1;

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  duration_in_hours, coach );
-- create the lesson

INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(member, A_Lessons_sequence.currval, datetime_lesson); 
--create the instance of the lesson

END;
/

execute createLesson(1, 2, TO_DATE('2014/05/05 19:00:00','yyyy/mm/dd hh24:mi:ss'), 3)
-- member_id = 1 ---- number of hours = 2 ------specialty = 3 (Irons)
--tests
SELECT * from A_member_lesson WHERE member_ID = 1;
--this shows that the instance of a lesson has been created
SELECT * from A_Lessons WHERE pk_lesson_ID >20;
--this shows that a lesson has been assigned a coach who specialises in specialty = 3 (Irons)
-- >20 is just from my knowledge that only 20 lessons currently exist in the
-- database so any created by the procedure should be dispalyed as they will have a primary
--key >20 due to it being created by the A_Lessons.sequence

execute createLesson(2, 2, TO_DATE('2014/05/05 19:00:00','yyyy/mm/dd hh24:mi:ss'), 3)
--this shows that if any member(in this case member_id =2) tries to book a 
--Irons lessona t this time and date an error will be thrown
SELECT * from A_member_lesson WHERE member_ID = 2;
--this shows that the instance of a lesson has not been created










/*
It seemed logical to create a deleteLesson procedure after createLesson
*/

CREATE OR REPLACE PROCEDURE deleteLesson(lesson IN NUMBER)
IS 
--do a check to see if the lesson exists
BEGIN
-- needs to be deleted in the following order in order to satisfy key constraints
DELETE FROM A_member_lesson WHERE lesson_id = lesson;
DELETE FROM A_Lessons WHERE pk_lesson_ID = lesson;
END;
/
execute deleteLesson()
-- this will only work if a parameter is entered in (). As the lesson_id to be entered is originally
-- created by a sequence I cannot be sure that you have not entered in lessons as your own test and 
-- as such any number i put in there could result in an error. I tried putting 
-- A_Lessons_sequence.currval but it cannot be sued as a target or parameter.

SELECT * from A_member_lesson WHERE member_ID = 1;
SELECT * from A_Lessons WHERE pk_lesson_ID >20;
--this shows that the instance of a lesson has been deleted from both tables. Again I am using 20 as
--i know that there are only 20 original lessons.



















/*
This procedure enters a member into the database. If that member's name is ommitted it throwsa user defined 
error and does not allow the insert to occur. Obviously i could write a lot of these exceptions for this procedure 
but the point has hopefully been illustrated with the NoFirstName Exception.

The user does not enter a primary key or the date as these will be taken care of by the procedure. 
A handicap is always set to NULL for a new member as they have to apply for it in the first year of membership.
*/


CREATE OR REPLACE PROCEDURE createMember(Fname IN NVARCHAR2, Sname IN NVARCHAR2, address_line_1 IN NVARCHAR2,
address_line_2 IN NVARCHAR2, address_line_3 IN NVARCHAR2, tel_no IN NVARCHAR2)
IS 
NoFirstName Exception;
-- this is the user defined exception
BEGIN
IF Fname IS NULL 
   THEN
      RAISE NoFirstName;
END IF;
INSERT INTO A_Members
VALUES(A_Members_sequence.nextval, Fname, Sname, address_line_1, address_line_2, address_line_3, tel_no, CURRENT_DATE, Null); 
EXCEPTION
   WHEN NoFirstName THEN
	DBMS_OUTPUT.PUT_LINE('You have not entered a first name.');
	-- Prints to the console if the user leaves the first name blank
END;
/
/*
Below are tests to test the results of the createMember procedure.
*/
execute createMember('Simon','Coveney', '21 Youghal Road', 'Youghal', 'Cork', '0879999123')

SELECT * FROM A_Members WHERE Sname = 'Coveney';

execute createMember('','Enfield', '21 Someother Street', 'Passagewest', 'Cork', '0871111234')

SELECT * FROM A_Members WHERE Sname = 'Enfield';

DELETE FROM A_Members WHERE Sname = 'Enfield';













CREATE OR REPLACE PROCEDURE deleteMember(member IN NUMBER)
IS 
--do a check to see if the lesson exists
BEGIN

-- ******needs to be deleted in the following order in order to satisfy key constraints******

UPDATE A_Parking_Space SET member_id = NULL WHERE member_id = member;
-- if the member has a car parking space that needs to be unassigned(not deleted as all of the 
  --parking spaces are always stored in the database)

DELETE FROM A_member_lesson WHERE member_id = member AND datetime_lesson > (sysdate);
-- this deletes an instance of a  future lesson. Only deletes the future lessons 
--as we wish to keep a record of all past lessons  

DELETE FROM A_Lessons WHERE pk_lesson_id = (SELECT lesson_id FROM A_member_lesson 
WHERE member_id = member AND datetime_lesson > (sysdate));
--deletes the lesson so that the coach is no longer assigned. 

DELETE FROM A_Participation_Results 
WHERE cpk_member_id = member AND cpk_tournament_id = (SELECT pk_tournament_id FROM A_Tournaments 
WHERE tournament_date > (sysdate));
-- this deletes any possible registration that the member might have for a future tournament. 

DELETE FROM A_Members WHERE pk_member_id = member;
--delete the member record in the Members table

END;
/

-- to ensure this works I created a member and registered him to a 
--future tournament and future lessons
execute createMember('Simon','Coveney', '21 Youghal Road', 'Youghal', 'Cork', '0879999123')
--this creates the member Simon Coveney

execute createLesson(A_Members_sequence.currval, 1, TO_DATE('2014/06/06 18:00:00','yyyy/mm/dd hh24:mi:ss'), 1)
--this assigns a coach to a lesson and creates an instance of that lesson
--currval as we have just created a user that we want to test on. 
--This is just for testing purposes.

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(A_Members_sequence.currval, 21, NULL);
-- this registers Simon Coveney for a The Harris English open which is in September




--Running the following Select statements show what occurs after a member 
--is created with future tournaments and lessons
SELECT * FROM A_Members WHERE Fname= 'Simon';

SELECT * FROM A_member_lesson WHERE member_id = (SELECT pk_member_id FROM A_Members WHERE Fname= 'Simon');

SELECT * FROM A_Lessons WHERE pk_lesson_id = 
(SELECT lesson_id FROM A_member_lesson WHERE member_id = 
  (SELECT pk_member_id FROM A_Members WHERE Fname= 'Simon') AND datetime_lesson > (sysdate));


-- this is the test of deleteMember
execute deleteMember(A_Members_sequence.currval);
-- the use of A_Members_sequence.currval in these tests are for example purposes only
-- using this as a way of deleting people in reality would be dangerous and prone to human error

--Running the following Select statements show what occurs after deleteMember
SELECT * FROM A_Members WHERE Fname= 'Simon';

SELECT * FROM A_member_lesson WHERE member_id = (SELECT pk_member_id FROM A_Members WHERE Fname= 'Simon');

SELECT * FROM A_Lessons WHERE pk_lesson_id = 
(SELECT lesson_id FROM A_member_lesson WHERE member_id = 
  (SELECT pk_member_id FROM A_Members WHERE Fname= 'Simon') AND datetime_lesson > (sysdate));















/*
This procedure processes a payment and should be the defult option for any attempte payments.
Whatever the member pays for the correct tables will be updated in the database. 
This also shows the use of Savepoint and Rollback as the tests will show.

*/

cl scr;
CREATE OR REPLACE PROCEDURE processPayment(	amountOfItems IN NUMBER, 
	member IN NUMBER , paymentType IN NUMBER, category IN NUMBER, lessonDate DATE := NULL)
--by setting lessonDate DATE := NULL we have made lessonDate an optional parameter
-- this is because when booking a lesson a date is required whilst the other payments do not need a date.
IS

Fname NVARCHAR2(30);
Sname NVARCHAR2(30);
tournament NUMBER;
duration_in_hours NUMBER;
specialty NUMBER;
space NUMBER;
membership_id NUMBER;
invalidCat EXCEPTION;
--membership_id is required because otherwise
--when we try to insert member into cpk_tournament we get an error as there is a 
--possibility of a NUll vale being entered into a primary key field.
BEGIN

savepoint beforeInsert;
-- no field exists to be populated. This could happen if a member tries to pay for a 
--tournament that does not exist yet.
-- or if they try to pay for a parking space but none are available.

SELECT A_Members.Fname INTO Fname FROM A_Members WHERE A_Members.pk_member_id = member;
--stores the members firstname in Fname

SELECT A_Members.Sname INTO Sname FROM A_Members WHERE A_Members.pk_member_id = member;
--stores the members firstname in Fname
membership_id := member;

SELECT pk_tournament_id INTO tournament FROM A_Tournaments WHERE (tournament_date - sysdate) BETWEEN 0 AND 7;
-- This stores the closest future tournament in the variable tournament
-- There is a business rule that their is a tournament every 7 days.

if tournament is NULL then
  tournament :=-1;
end if;

if membership_id is NULL then
  membership_id :=-1;
end if;
-- these are required to avoid the null value being inserted into a the composite primary key for the table
-- A_Participation_Results

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, sysdate, amountOfItems, member, paymentType, category); 
--this creates the payment

CASE category
-- this case asigns the correct duration and specialty based on the correct category_id being entered
-- Nothing needs to occur when category_id = 1 as this membership.

WHEN 1 THEN 
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid their membership');

WHEN 2 THEN duration_in_hours := 1; Specialty := 1 ;
createLesson(member, duration_in_hours, lessonDate, specialty);
-- this calls another procedure to create the correct insert statements

WHEN 3 THEN duration_in_hours := 2; Specialty := 1;
createLesson(member, duration_in_hours, lessonDate, specialty);
-- this calls another procedure to create the correct insert statements etc

WHEN 4 THEN duration_in_hours := 1; Specialty :=  2;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 5 THEN duration_in_hours := 2; Specialty :=  2;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 6 THEN duration_in_hours := 1; Specialty :=  3;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 7 THEN duration_in_hours := 2; Specialty :=  3;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 8 THEN duration_in_hours := 1; Specialty :=  4;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 9 THEN duration_in_hours := 2; Specialty :=  4;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 10 THEN
-- 10 is the category type of a parking space
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a parking space');
SELECT pk_parking_space INTO space FROM A_Parking_Space where member_id IS NULL AND ROWNUM <=1; 
--selects the next available space
-- if all the parking spaces are already assigned the exception below will handle it by outputting the
-- error message and cancelling the payment.
UPDATE A_Parking_Space 
SET member_id = member WHERE pk_parking_space = space;


WHEN 11 THEN 
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 



WHEN 12 THEN
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 


WHEN 13 THEN
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a tournament');
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(membership_id, tournament, -1); 


WHEN 21 THEN duration_in_hours := 1; Specialty :=  5;
createLesson(member, duration_in_hours, lessonDate, specialty);

WHEN 22 THEN duration_in_hours := 2; Specialty :=  5;
createLesson(member, duration_in_hours, lessonDate, specialty);

ELSE DBMS_OUTPUT.PUT_LINE('No such category'); raise_application_error(-20011, 'This is not a category_id '||SQLCODE||' -ERROR- '||SQLERRM);	
END CASE;

EXCEPTION
WHEN NO_DATA_FOUND THEN
dbms_output.put_line('The field you are trying to populate does not exist');
ROLLBACK to beforeInsert;
-- cancel the payment by the member. This will only delete the car parking payment as a member cannot 
--	have more than one assigned parking space
-- and as a result there will only be one payment where category =10.

WHEN invalidCat THEN
raise_application_error (-20006,'You have entered the incorrect category_id.');

END;
/
show errors;




















/* This procedure shows the number of years that each member has been with the club*/


CREATE OR REPLACE PROCEDURE ShowMembershipLength
IS
CURSOR memlen IS SELECT * FROM A_members Order by date_joined;
--create cursor
memberRow memlen%ROWTYPE;
membershipLength NUMBER;
date_joined DATE;
-- variables needed
BEGIN
OPEN memlen;
--open the cursor
FETCH memlen INTO memberRow;
--store the information from the cursor in the variable memberRow
WHILE memlen%FOUND LOOP
-- iterate through the record set until there are no more records
date_joined := memberRow.date_joined;
membershipLength := round(MONTHS_BETWEEN(sysdate, date_joined)/12);
--calculate how many whiole years the member has been joined
DBMS_OUTPUT.PUT_LINE('Name: ' ||memberRow.Fname||' '||memberRow.Sname|| ' Membership Length: '||membershipLength);

FETCH memlen INTO memberRow;
END LOOP;
-- close loop
CLOSE memlen;
--close the cursor
EXCEPTION
WHEN OTHERS THEN
raise_application_error(-20001, 'There was an error '||SQLCODE||' -ERROR- '||SQLERRM);	
--generic exception to deal which returns the error message associated with the most recently raised error exception
END;
/
execute ShowMembershipLength;



















/*
This procedure shows what members entered a particular tournament when you input the tournament ID.
*/


CREATE OR REPLACE PROCEDURE TournamentParticipants(tournamentNumber IN NUMBER)
IS
CURSOR member IS SELECT Fname, Sname, tournament_name FROM A_members INNER JOIN A_Participation_results 
ON A_members.pk_member_id = A_Participation_results.cpk_member_id
INNER JOIN A_Tournaments
ON A_Participation_results.cpk_tournament_id = A_Tournaments.pk_tournament_id
WHERE tournamentNumber = A_Tournaments.pk_tournament_id;
-- creates a cursor from some joined tables.

memberRow member%ROWTYPE;

BEGIN
DBMS_OUTPUT.PUT_LINE('Member' ||'			'||'Tournament ');
OPEN member;
--open cursor
FETCH member INTO memberRow;
--store the information from the cursor in the variable memberRow

WHILE member%FOUND LOOP
-- iterate through the record set until there are no more records
DBMS_OUTPUT.PUT_LINE(memberRow.Fname || ' ' || memberRow.Sname ||'		'|| memberRow.tournament_name);	
FETCH member INTO memberRow;
END LOOP;
--end loop
CLOSE member;
--close cursor
EXCEPTION
WHEN OTHERS THEN
raise_application_error(-20001, 'There was an error '||SQLCODE||' -ERROR- '||SQLERRM);	
END;
/
--test below
execute TournamentParticipants(2);



















/*
**********************************  2 FUNCTIONS ***********************
*/



/*
This functions returns the length of and individual member's membership from an inputted member_id
*/

CREATE OR REPLACE FUNCTION MembershipLength(member IN NUMBER)
return number
IS
date_joined DATE;
--needs to store the date the member joined
membershipLength NUMBER;
-- creates a variable to store the number to be outputted

BEGIN
SELECT A_Members.date_joined INTO date_joined FROM A_Members where A_Members.pk_member_id = member;
membershipLength := round(MONTHS_BETWEEN(sysdate, date_joined)/12);
-- just gives the number of full years as this is all that is relevant
return membershipLength;
-- value to be returned as specificed at the start of the function
END;
/

SELECT MembershipLength(2) from dual;



/*
This function returns the winner of a tournament when the tournament_id is supplied
as a parameter
*/

CREATE OR REPLACE FUNCTION tournamentWinner(tournament IN NUMBER)
return NVARCHAR2
IS
lowestScore NUMBER;
--needs to store the date the member joined
nameOfWinner NVARCHAR2(30);
--value to be returned

BEGIN

SELECT MIN(SCORE) INTO lowestScore FROM A_Participation_Results WHERE cpk_tournament_id = tournament;
--stores the lowest score from the tournament requested

SELECT Fname || ' ' || Sname AS fullname INTO nameOfWinner FROM A_members 
WHERE pk_member_id = (SELECT cpk_member_id FROM A_Participation_Results 
	WHERE score =lowestScore AND cpk_tournament_id = tournament);
-- A subquery to find the details of the member who has the lowest score reorded in A_Participation_Results

return nameOfWinner;
-- value to be returned as specificed at the start of the function
END;
/

SELECT tournamentWinner(2) from dual;












/*
**************************    3 Triggers
*/

/*
This trigger alerts us when a member's handicap goes below 5 and 
reminds us to send them a congratulatory certificate. It only alerts if the player 
had a handicap over 5 before the update.
*/







CREATE OR REPLACE TRIGGER trig_lowHandicap
AFTER UPDATE ON A_Members
FOR EACH ROW
BEGIN
IF :new.handicap < 5 AND :old.Handicap >= 5 THEN
DBMS_OUTPUT.PUT_LINE(:new.Fname || ' ' || :new.Sname ||' has received a new handicap of '|| :new.handicap || '. Send them a congratulatory certificate to : ');
DBMS_OUTPUT.PUT_LINE(:new.address_line_1);
DBMS_OUTPUT.PUT_LINE(:new.address_line_2);
DBMS_OUTPUT.PUT_LINE(:new.address_line_3);
END IF;

END;
/
show errors


UPDATE A_Members
SET handicap = 6
WHERE Fname = 'Mike';
-- updates Mike's handicap to 6 for to set up the next tests
UPDATE A_Members
SET handicap = 4
WHERE Fname = 'Mike';
-- outputs the alert message

UPDATE A_Members
SET handicap = 3
WHERE Fname = 'Mike';
--does not output any message as Mike's 
--handicap is already below 5 after the last update













/*
This trigger checks all payments in case a member without a handicap tries to pay for a tournament.
This is strictly not allowed at the club.
*/


CREATE OR REPLACE TRIGGER noHandicap
BEFORE INSERT ON A_Payment
FOR EACH ROW

DECLARE
Fname NVARCHAR2(30);
Sname NVARCHAR2(30);
handicap NUMBER;

BEGIN

SELECT A_Members.handicap INTO handicap FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;
SELECT A_Members.Fname INTO Fname FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;
SELECT A_Members.Sname INTO Sname FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;

if :new.category_id in (11, 12, 13) THEN
-- 11,12,13 are the category types of tournaments
  if handicap = -1 THEN
  -- -1 is the default for no handicap
        raise_application_error( -20001, Fname || ' ' || Sname || 
		' has attempted to pay for a tournament without a handicap');
    END IF; 
end if;
END;
/

-- tests this trigger because member_id =14 does not have a handicap
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 14,  3, 11); 

--this shows that the payment did not go through.
SELECT * FROM A_Payment where date_paid = to_date('01/26/2014','mm/dd/yyyy') AND member_id = 14;












/*A trigger created to show when a member is assigned a car parking space
This will only occur on UPDATE as all available car parking sapces are already stored in the database
*/
cl scr;
CREATE OR REPLACE TRIGGER parkingAssigned
AFTER INSERT ON A_Payment
FOR EACH ROW

DECLARE
Fname NVARCHAR2(30);
Sname NVARCHAR2(30);
member NUMBER;
space NUMBER;

BEGIN

SELECT A_Members.Fname INTO Fname FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;
SELECT A_Members.Sname INTO Sname FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;
SELECT A_Members.pk_member_id INTO member FROM A_Members
WHERE A_Members.pk_member_id = :new.member_id;

if :new.category_id = 10 THEN
-- 10 is the category type of a parking space
DBMS_OUTPUT.PUT_LINE(Fname || ' ' || Sname || ' has paid for a parking space');
SELECT pk_parking_space INTO space FROM A_Parking_Space where member_id IS NULL AND ROWNUM <=1; 
--selects the next available space
-- if all the parking spaces are already assigned the exception below will handle it by outputting the
-- error message and cancelling the payment.

UPDATE A_Parking_Space 
SET member_id = member WHERE pk_parking_space = space;
end if;
--assigns the member a parking space

EXCEPTION
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('There are no available parking spaces.');
    DELETE FROM A_Payment WHERE :new.member_id = member AND :new.category_id = 10;
    -- cancel the payment by the member. This will only delete the car parking payment as a member cannot have more than one assigned parking space
    -- and as a result there will only be one payment where category =10.
END;
/
show errors

-- tests this trigger because member_id =14 does not have a parking space
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 14,  3, 10); 
--should print to screen thaat this member has paid for a parking space
SELECT * FROM A_Parking_Space where member_id =14;
-- shows that an available parking space has been assigned to them.








