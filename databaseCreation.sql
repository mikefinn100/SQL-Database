CREATE TABLE A_Payment_Types (
pk_type_id NUMBER(10) NOT NULL, type_name NVARCHAR2(30) NULL,
PRIMARY KEY (pk_type_id));
CREATE SEQUENCE A_Payment_Types_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 10000;

/*
I have written a sequence for each entity that has a surrogate primary key.
While it would be possible to subsume both A_Payment_Types and A_Payment_Categories into A_Payment I have decided that it would be better to store a value there rather than the string. 
For example, 1 will be stored in A_Payment instead of the string 'Visa'. This should lead to a more efficient database????
*/

INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Visa'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'MasterCard'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Cash'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Cheque'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Western Union'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Paypal'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Bank Transfer'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'American Express'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Bitcoin'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Gift Voucher'); 
INSERT INTO A_Payment_Types(pk_type_id, type_name) VALUES(A_Payment_Types_sequence.nextval,'Google Wallet'); 
 

CREATE TABLE A_Payment_Categories (
pk_category_id NUMBER(10) NOT NULL, category_name NVARCHAR2(30) NULL, cost NUMBER(10) NULL,
PRIMARY KEY (pk_category_id));
CREATE SEQUENCE A_Payment_Categories_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 10000;

/*
I considered storing the price in each entity such as A_Lessons or A_Tournament but thought it would be more efficient to just store it once 
for every item a member could possibly pay for in this system.
*/

INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Annual Membership', 1200) ; 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Driving 1 hr', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Driving 2 hr', 110); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Putting 1 hr', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Putting 2 hr', 110); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Irons 1 hr', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Irons 2 hr', 110); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Psychology 1 hr', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Lesson Psychology 2 hr', 110); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Car Parking Space', 100); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Class 3 Tournament Entry', 40); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Class 2 Tournament Entry', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Class 1 Tournament Entry', 75); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Fitness 2 hr', 60); 
INSERT INTO A_Payment_Categories(pk_category_id, category_name, cost) VALUES(A_Payment_Categories_sequence.nextval,'Fitness 2 hr', 110); 


CREATE TABLE A_Members (
pk_member_id NUMBER(10) NOT NULL ,
Fname NVARCHAR2(30) NULL,
Sname NVARCHAR2(30) NULL,
address_line_1 NVARCHAR2(30) NULL,
address_line_2 NVARCHAR2(30) NULL,
address_line_3 NVARCHAR2(30) NULL,
tel_no NVARCHAR2(30) NULL,
date_joined DATE,
handicap NUMBER(10) NULL,
PRIMARY KEY(pk_member_id)
);
CREATE SEQUENCE A_Members_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 10000;

/*
As there is an assumption that every member must have an address in Ireland to attain membership I originally had the attributes street_address, city_address and county_address. 
This however did not make a lot of sense when speaking of people from outside the city so I changed it to the more generic address_line_1, address_line_2, address_line_3.

I have used 'to_date' to insert the date and have used the format 'mm/dd/yyyy'. For this field 'date_joined' I only need to record the date and not the time. 
Later in this database I have used the format 'yyyy/mm/dd hh24:mi:ss' as it is more appropriate.

Tel_no is stored as a NVARCHAR as no computation will ever be done n it and it solves the leading 0 omission problem that occurs if it is entered as a NUMBER.

In the example case where a member has not yet received their handicap it will be stored as -1.
*/

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Sharon', 'Dooley', '21 Main Street', 'Midleton', 'Cork', '0872791234', to_date('03/03/2001','mm/dd/yyyy'), 14 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Sheila', 'Dooley', 'Rathellen', 'Castletown', 'Cork', '0871298121', to_date('11/6/2004','mm/dd/yyyy'), 11 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Jenny', 'Finn', '7 Rathmines Road', 'Rathmines', 'Dublin', '0872755552', to_date('02/21/2006','mm/dd/yyyy'), 20 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Harold', 'Ramis', '17 Mailor Street', 'Dungarvan', 'Waterford', '0873418762', to_date('10/30/2005','mm/dd/yyyy'), 17 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Dougie', 'Hauser', 'Westpoint House', 'Bunclody', 'Wexford', '0864325762', to_date('02/17/2012','mm/dd/yyyy'), 15 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Reginald', 'Magee', '210 Elmwood Avenue', 'Harolds Cross', 'Dublin', '0864988761', to_date('12/24/2013','mm/dd/yyyy'), 15 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Peter', 'Toohey', '1 Meadow Mews', 'Dingle', 'Kerry', '0851278435', to_date('08/03/2006','mm/dd/yyyy'), 13 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Angie', 'Nutley', 'Suncourt ', 'Dunmanway', 'Cork', '0862165430', to_date('10/03/2000','mm/dd/yyyy'), 13 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Sarah', 'Cullen', 'Glaramara', 'Mallow', 'Cork', '0858763214', to_date('12/14/2008','mm/dd/yyyy'), 5 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Alice', 'MacDonald', '217 Glasheen Road', 'Ballyphehane', 'Cork', '0877651900', to_date('02/28/2008','mm/dd/yyyy'), 21 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Mike', 'Finn', '603 Patrick Street', '', 'Cork', '0872798762', to_date('12/03/2006','mm/dd/yyyy'), 18 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Peter', 'Maguire', '3 Washington Street', '', 'Cork', '0872123762', to_date('12/07/2009','mm/dd/yyyy'), 12 ); 

INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Steph', 'McPhail', '3 Harolds Drive', '', 'Cork', '0872123762', to_date('12/07/2009','mm/dd/yyyy'), 12 ); 


INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Helen', 'Sweeney', '113 MacCurtain Street', '', 'Cork', '0872111762', to_date('02/07/2014','mm/dd/yyyy'), -1 ); 
	
INSERT INTO A_Members(pk_member_id, Fname,Sname, address_line_1, address_line_2, address_line_3, tel_no, date_joined, handicap) 
VALUES(A_Members_sequence.nextval,'Anthony', 'Sweeney', '113 MacCurtain Street', '', 'Cork', '0853888976', to_date('02/07/2014','mm/dd/yyyy'), -1 ); 
	

CREATE TABLE A_Payment (
pk_payment_id NUMBER(10) NOT NULL ,
date_paid DATE,
quantity NUMBER(10) NULL,
member_id NUMBER(10) NULL,
type_id NUMBER(10) NULL,
category_id NUMBER(10) NULL,
PRIMARY KEY(pk_payment_id),
FOREIGN KEY(member_id)
REFERENCES A_Members(pk_member_id),
FOREIGN KEY(type_id)
REFERENCES A_Payment_Types(pk_type_id),
FOREIGN KEY(category_id)
REFERENCES A_Payment_Categories(pk_category_id)
);
CREATE SEQUENCE A_Payment_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 10000000;

/*
Originally I did not have the attribute 'quantity' but as it seemed logical that a member would buy more than one lesson at a time I have included it.

*/

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 1,  2, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/03/2014','mm/dd/yyyy'), 1, 2,  4, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/01/2014','mm/dd/yyyy'), 1, 3,  1, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/04/2014','mm/dd/yyyy'), 1, 4,  1, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/03/2014','mm/dd/yyyy'), 1, 5,  4, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/01/2014','mm/dd/yyyy'), 1, 6,  5, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/05/2014','mm/dd/yyyy'), 1, 7,  7, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/05/2014','mm/dd/yyyy'), 1, 8,  2, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 9,  2, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/03/2014','mm/dd/yyyy'), 1, 10,  1, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/03/2014','mm/dd/yyyy'), 1, 11,  3, 1); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/01/2014','mm/dd/yyyy'), 1, 12,  3, 1); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 1,  2, 2); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/11/2014','mm/dd/yyyy'), 1, 2,  2, 2); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/12/2014','mm/dd/yyyy'), 1, 3,  2, 4); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/04/2014','mm/dd/yyyy'), 1, 4,  3, 4); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/22/2014','mm/dd/yyyy'), 1, 5,  10, 4); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/22/2014','mm/dd/yyyy'), 1, 6,  10, 6); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 1,  1, 6); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/07/2014','mm/dd/yyyy'), 1, 2,  1, 8); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/13/2014','mm/dd/yyyy'), 1, 1,  2, 2); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/02/2014','mm/dd/yyyy'), 1, 2,  3, 2); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/21/2014','mm/dd/yyyy'), 3, 7,  2, 3); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/02/2014','mm/dd/yyyy'), 10, 8, 2, 3); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/30/2014','mm/dd/yyyy'), 4, 9,  1, 3); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/25/2014','mm/dd/yyyy'), 4, 7,  1, 5); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 4, 8,  1, 7); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/19/2014','mm/dd/yyyy'), 6, 9,  3, 9); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/11/2014','mm/dd/yyyy'), 1, 5,  10, 7); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/09/2014','mm/dd/yyyy'), 4, 4,  6, 5); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/04/2014','mm/dd/yyyy'), 1, 1,  1, 3); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/05/2014','mm/dd/yyyy'), 1, 2,  3, 3);

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/03/2014','mm/dd/yyyy'), 1, 1,  3, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/03/2014','mm/dd/yyyy'), 1, 2,  3, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('03/02/2014','mm/dd/yyyy'), 1, 4,  3, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/02/2014','mm/dd/yyyy'), 1, 6,  3, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/02/2014','mm/dd/yyyy'), 1, 7,  2, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/21/2014','mm/dd/yyyy'), 1, 8,  1, 10); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/01/2014','mm/dd/yyyy'), 1, 9  6, 10); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 2,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 11,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 10,  1, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 8,  10, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/05/2014','mm/dd/yyyy'), 1, 9  10, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/12/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/12/2014','mm/dd/yyyy'), 1, 2,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/12/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/12/2014','mm/dd/yyyy'), 1, 11,  2, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/19/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/19/2014','mm/dd/yyyy'), 1, 11,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/19/2014','mm/dd/yyyy'), 1, 10,  1, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/19/2014','mm/dd/yyyy'), 1, 8,  10, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/19/2014','mm/dd/yyyy'), 1, 9  10, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 2,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 3,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 5,  1, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 6,  10, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 7  10, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 8,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 9,  1, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 10,  10, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('01/26/2014','mm/dd/yyyy'), 1, 11, 10, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 2,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 7,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/02/2014','mm/dd/yyyy'), 1, 9,  1, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/09/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/09/2014','mm/dd/yyyy'), 1, 11,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/09/2014','mm/dd/yyyy'), 1, 7,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/09/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/09/2014','mm/dd/yyyy'), 1, 9,  1, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/16/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/16/2014','mm/dd/yyyy'), 1, 11,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/16/2014','mm/dd/yyyy'), 1, 7,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/16/2014','mm/dd/yyyy'), 1, 10,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/16/2014','mm/dd/yyyy'), 1, 9,  1, 11); 

INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 1,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 10,  3, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 6,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 4,  2, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 9,  1, 11); 
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 3,  3, 11);
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 2,  3, 11);
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 5,  3, 11);
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 7,  6, 11);
INSERT INTO A_Payment(pk_payment_id, date_paid, quantity, member_id, type_id, category_id) 
VALUES(A_Payment_sequence.nextval, to_date('02/23/2014','mm/dd/yyyy'), 1, 8,  3, 11);


CREATE TABLE A_Parking_Space (
pk_parking_space NUMBER(10) NOT NULL, member_id NUMBER(10) NULL,
PRIMARY KEY (pk_parking_space),
FOREIGN KEY(member_id)
REFERENCES A_Members(pk_member_id)
);
CREATE SEQUENCE A_Parking_Space_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 150;

/*
As the car park has 150 spaces available to use I have set the max value in this sequence to be 500 as there needs only to be room for a reasonable amount of expansion.

I have created the 142 extra unused car parking spaces so that they can be assigned rather than created when needed.

*/

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 1); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 2); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 3); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 4); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 5); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 8); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 9); 
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, 10); 

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);

 INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);

INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);
INSERT INTO A_Parking_Space(pk_parking_space, member_id) 
VALUES(A_Parking_Space_sequence.nextval, Null);





CREATE TABLE A_Tournaments (
pk_tournament_id NUMBER(10) NOT NULL,
tournament_name NVARCHAR2(30) NULL,
tournament_date DATE,
PRIMARY KEY (pk_tournament_id)
);
CREATE SEQUENCE A_Tournaments_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 10000;

/*
I have created a tournament for each Sunday in 2014 up until the 22nd February as I hope this will be a sufficient sample size to work with.
*/

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Arnold Palmer Open', to_date('01/05/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Lee Westwood Open',  to_date('01/12/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Scott Verplank Open',  to_date('01/19/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Padraig Harrington Open',  to_date('01/26/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'David Duval Open', to_date('02/02/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Justin Rose Open', to_date('02/09/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Jack Nicklaus Open', to_date('02/16/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Tiger Woods Open', to_date('02/22/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Sergio Garcia Open', to_date('03/01/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Jordan Spieth Open', to_date('04/19/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Bubba Watson Open', to_date('04/26/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Gary Player Open', to_date('05/03/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Jamie Donaldson Open', to_date('05/10/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Greg Norman Open', to_date('05/17/2014','mm/dd/yyyy'));

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Nick Faldo Open', to_date('05/24/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Seve Ballesteros Open', to_date('05/31/2014','mm/dd/yyyy')); 

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Paul McGinley Open', to_date('06/07/2014','mm/dd/yyyy'));  

INSERT INTO A_Tournaments(pk_tournament_id, tournament_name, tournament_date) 
VALUES(A_Tournaments_sequence.nextval, 'Paul Lawrie Open', to_date('03/08/2014','mm/dd/yyyy')); 



CREATE TABLE A_Prizes (
cpk_prize_position NUMBER(10) NOT NULL, 
cpk_tournament_id NUMBER(10) NOT NULL,
prize_description NVARCHAR2(100) NULL,
PRIMARY KEY (cpk_prize_position, cpk_tournament_id),
FOREIGN KEY(cpk_tournament_id)
REFERENCES A_Tournaments(pk_tournament_id)
);

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 1, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 1, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 1, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 2, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 2, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 2, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 3, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 3, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 3, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 4, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 4, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 4, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 5, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 5, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 5, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 6, 'Trophy and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 6, 'Medal and gift voucher'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 6, 'Gift voucher'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 7, 'Trophy and a New Titleist Driver'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 7, 'Medal and New Titleist Pitching Wedge'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 7, 'Gift voucher for a free 2hr lesson'); 

INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(1, 8, 'Trophy and a Set of Nike Golf Clubs'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(2, 8, 'Medal and a New Nike Putter'); 
INSERT INTO A_Prizes(cpk_prize_position, cpk_tournament_id, prize_description) 
VALUES(3, 8, 'Gift voucher for a free 2hr lesson'); 



CREATE TABLE A_Participation_Results (
cpk_member_id NUMBER(10) NOT NULL ,
cpk_tournament_id NUMBER(10) NOT NULL,
score NUMBER(10) NULL,
PRIMARY KEY(cpk_member_id, cpk_tournament_id),
FOREIGN KEY(cpk_member_id)
REFERENCES A_Members(pk_member_id),
FOREIGN KEY(cpk_tournament_id)
REFERENCES A_Tournaments(pk_tournament_id)
);

/*
I originally thought that i would store the results in this entity but it a leader board is easily calculated from the scores.
*/

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 1, 75); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(2, 1, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 1, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 1, 79);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(10, 1, 81);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(8, 1, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 1, 73);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 2, 74); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(2, 2, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 2, 73);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 2, 79);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 3, 75); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 3, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(10, 3, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(8, 3, 79);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 3, 81);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 4, 75); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(2, 4, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(3, 4, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 4, 79);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(5, 4, 81);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(6, 4, 76);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(7, 4, 78);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(8, 4, 78); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 4, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(10, 4, 70);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 4, 81);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 5, 75); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(2, 5, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(7, 5, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 5, 79);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 5, 81);


INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 6, 78); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 6, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(7, 6, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 6, 70);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 6, 69);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 7, 78); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(11, 7, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(7, 7, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(10, 7, 70);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 7, 69);

INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(1, 8, 75); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(2, 8, 72);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(3, 8, 66);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(4, 8, 67);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(5, 8, 69);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(6, 8, 76);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(7, 8, 78);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(8, 8, 78); 
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(9, 8, 71);
INSERT INTO A_Participation_Results(cpk_member_id, cpk_tournament_id, score) 
VALUES(10, 8, 70);


CREATE TABLE A_Specialty (
pk_specialty_id NUMBER(10) NOT NULL ,
specialty_name NVARCHAR2(30) NULL,
PRIMARY KEY(pk_specialty_id)
);
CREATE SEQUENCE A_Specialty_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 100;

/*
Again the maxvalue only needs to be as large as this record could possibly expand.
*/

INSERT INTO A_Specialty(pk_specialty_id, specialty_name) 
VALUES(A_Specialty_sequence.nextval, 'Driving');
INSERT INTO A_Specialty(pk_specialty_id, specialty_name) 
VALUES(A_Specialty_sequence.nextval, 'Putting');
INSERT INTO A_Specialty(pk_specialty_id, specialty_name) 
VALUES(A_Specialty_sequence.nextval, 'Irons');
INSERT INTO A_Specialty(pk_specialty_id, specialty_name) 
VALUES(A_Specialty_sequence.nextval, 'Psychology');
INSERT INTO A_Specialty(pk_specialty_id, specialty_name) 
VALUES(A_Specialty_sequence.nextval, 'Fitness');



CREATE TABLE A_Coaches (
pk_coach_id NUMBER(10) NOT NULL,
Fname NVARCHAR2(30) NULL,
Sname NVARCHAR2(30) NULL,
tel_no NVARCHAR2(30) NULL,
PRIMARY KEY(pk_coach_id)
);
CREATE SEQUENCE A_Coaches_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 100;

/*Again the tel_no is stored as a NVARCHAR*/

INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Alan', 'Pearson', '0862131230'); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Adam', 'Scotson', '0875623872'); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Paul', 'Hammill', '0859878876'); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Larry', 'Paige', '0850776054'); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Tommy', 'Pollett', '0861602314'); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Ciaran', 'McCarthy', '0877067065' ); 
INSERT INTO A_Coaches(pk_coach_id, Fname, Sname, tel_no) 
VALUES(A_Coaches_sequence.nextval,'Jimmy', 'Fox', '0879985432'); 



CREATE TABLE A_coach_specialty_junction(
coach_id int NOT NULL,
specialty_id int NOT NULL,
CONSTRAINT PK_coach_specialty PRIMARY KEY(coach_id, specialty_id),
FOREIGN KEY (coach_id) REFERENCES A_Coaches(pk_coach_id),
FOREIGN KEY (specialty_id) REFERENCES A_Specialty(pk_specialty_id)
);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(1,1);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(2,1);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(3,2);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(4,2);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(5,3);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(6,3);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(7,4);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(1,4);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(3,3);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(7,3);
INSERT INTO A_coach_specialty_junction(coach_id, specialty_id) 
VALUES(2,2);


CREATE TABLE A_Lessons (
pk_lesson_id NUMBER(10) NOT NULL,
duration_in_hours NUMBER(10) NULL,
coach_id NUMBER(10) NOT NULL,
PRIMARY KEY(pk_lesson_id),
FOREIGN KEY(coach_id)
REFERENCES A_Coaches(pk_coach_id)
);
CREATE SEQUENCE A_Lessons_sequence START WITH 1
INCREMENT BY 1
minvalue 1
maxvalue 100000;

/*
Here I need to use the extended formate of date so the to_date format is stated as '2014/02/03 18:00:00', 'yyyy/mm/dd hh24:mi:ss'.
*/

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours, coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 1 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 1 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 1 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1,  2 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 1 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 2 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 2 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 1 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2,  2 ); 



INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1,  3 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1,  3 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 4 ); 



INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 5 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 6 ); 




INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  1, 7 ); 



INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 3 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 4 ); 



INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 5 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 6 ); 

INSERT INTO A_Lessons(pk_lesson_id, duration_in_hours,  coach_id) 
VALUES(A_Lessons_sequence.nextval,  2, 7 ); 


/*
alter session set nls_date_format = 'dd.mm.yyyy hh24:mi'; // will give the time ass well as the date. The default is just the date.
*/


CREATE TABLE A_member_lesson(
    member_id int NOT NULL,
    lesson_id int NOT NULL,
    datetime_lesson DATE,
    CONSTRAINT PK_member_lessons PRIMARY KEY(member_id, lesson_id),
    FOREIGN KEY (member_id) REFERENCES A_Members(pk_member_id),
    FOREIGN KEY (lesson_id) REFERENCES A_Lessons(pk_lesson_id)
);

/*
This is the junction table that breaks down the M:M relationship between member and lesson. 
It only exists to record each instance where an individual member takes an individual lesson.
*/

INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(1,1, TO_DATE('2014/02/03 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(2,2, TO_DATE('2014/02/12 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(3,3, TO_DATE('2014/03/14 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(4,4, TO_DATE('2014/03/05 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(5,5, TO_DATE('2014/02/22 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(6,6, TO_DATE('2014/01/03 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(1,7, TO_DATE('2014/02/03 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(2,8, TO_DATE('2014/03/06 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(1,9, TO_DATE('2014/03/07 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(2,10, TO_DATE('2014/02/13 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(7,11, TO_DATE('2014/02/05 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(8,12, TO_DATE('2014/02/03 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(9,13, TO_DATE('2014/01/23 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(7,14, TO_DATE('2014/01/08 18:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(8,15, TO_DATE('2014/03/23 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(9,16, TO_DATE('2014/04/03 19:00:00','yyyy/mm/dd hh24:mi:ss')); 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(5,17, TO_DATE('2014/03/13 19:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(4,18, TO_DATE('2014/02/24 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(1,19,TO_DATE('2014/02/03 18:00:00','yyyy/mm/dd hh24:mi:ss')) ; 
INSERT INTO A_member_lesson(member_id, lesson_id, datetime_lesson) 
VALUES(2,20,TO_DATE('2014/02/20 18:00:00','yyyy/mm/dd hh24:mi:ss')); 

