DROP SEQUENCE seq_Donor;
DROP SEQUENCE seq_Donation;
DROP SEQUENCE seq_Payment;
DROP SEQUENCE seq_Fundraiser;
DROP SEQUENCE seq_DonationLog;

CREATE SEQUENCE seq_Donor
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_Donation
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_Payment
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_Fundraiser
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

CREATE SEQUENCE seq_DonationLog
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

---                      ---
---                      ---
--- DONORS AND DONATIONS ---
---                      ---
---                      ---

------------------------ TJ Augustine -----------------------
---Adding Donor
INSERT INTO Donor_T(
  Donor_ID,
  Donor_Name,
  Donor_Address,
  Donor_Type_Person,
  Donor_Type_Corporation,
  Donor_Phone
)
VALUES(
  seq_Donor.nextval,
  'TJ Augustine',
  '123 Appleseed Ln, Philadelphia, PA',
  1,
  0,
  9172304219
);

---Adding Person
INSERT INTO Person_T
VALUES(
  seq_Donor.currval,
  'alumni',
  2022
);

--- ^ PICK ONE v ---

-- ---Adding Corporation
-- INSERT INTO Corporation_T
-- VALUES(
--   seq_Donor.currval,
--   'Femjay Augustine'
-- );

------------------------ ADDING DONATION -----------------------

---Adding Donation
INSERT INTO Donation_T
VALUES(
  seq_Donation.nextval,
  seq_Donor.currval,
  '24-NOV-2020',
  150.00,
  1
);

------------------ ADDING PAYMENT-OF-DONATION ------------------

---Adding Payment
INSERT INTO Payment_T
VALUES(
  seq_Payment.nextval,
  seq_Donation.currval,
  '24-NOV-2020',
  150.00,
  'check'
);

-- ---Adding Credit Card
-- INSERT INTO CreditCard_T(
--   seq_Payment.currval,
--   24672999711,
--   '01-JAN-2025',
--   152
-- );

--- ^ PICK ONE v ---

---Adding Check
INSERT INTO Check_T
VALUES(
  seq_Payment.currval,
  1218,
  'Donation to Beta University'
);

------------------------ ADDING FUNDRAISER -----------------------

---Adding Fundraiser
INSERT INTO Fundraiser_T
VALUES(
  seq_Fundraiser.nextval,
  'Phonothon 2020',
  '24-NOV-2020'
);

---Adding Fundraisers Attended
INSERT INTO FundraisersAttended_T
VALUES(
  seq_Donor.currval,
  seq_Fundraiser.currval
);



------------------------ Christopher LaRosa -----------------------
---Adding Donor
INSERT INTO Donor_T(
  Donor_ID,
  Donor_Name,
  Donor_Address,
  Donor_Type_Person,
  Donor_Type_Corporation,
  Donor_Phone
)
VALUES(
  seq_Donor.nextval,
  'Christopher LaRosa',
  '321 Peach Road, Trenton, NJ',
  1,
  0,
  9174327137
);

---Adding Person
INSERT INTO Person_T
VALUES(
  seq_Donor.currval,
  'administrator',
  2021
);

--- ^ PICK ONE v ---

-- ---Adding Corporation
-- INSERT INTO Corporation_T
-- VALUES(
--   seq_Donor.currval,
--   'Femjay Augustine'
-- );

------------------------ ADDING DONATION -----------------------

---Adding Donation
INSERT INTO Donation_T
VALUES(
  seq_Donation.nextval,
  seq_Donor.currval,
  '26-NOV-2020',
  3000.00,
  3
);

------------------ ADDING PAYMENT-OF-DONATION ------------------

---Adding Payment---
INSERT INTO Payment_T
VALUES(
  seq_Payment.nextval,
  seq_Donation.currval,
  '26-NOV-2020',
  100.00,
  'check'
);

---Adding Check
INSERT INTO Check_T
VALUES(
  seq_Payment.currval,
  1219,
  'Donation 3000 to Beta University'
);

---Adding Payment---
INSERT INTO Payment_T
VALUES(
  seq_Payment.nextval,
  seq_Donation.currval,
  '27-NOV-2020',
  100.00,
  'credit'
);

---Adding Credit Card
INSERT INTO CreditCard_T
VALUES(
  seq_Payment.currval,
  24672999711,
  '01-JAN-2025',
  152
);

---Adding Payment---
INSERT INTO Payment_T
VALUES(
  seq_Payment.nextval,
  seq_Donation.currval,
  '28-NOV-2020',
  100.00,
  'credit'
);

---Adding Credit Card
INSERT INTO CreditCard_T
VALUES(
  seq_Payment.currval,
  24672999711,
  '01-JAN-2025',
  152
);

------------------------ ADDING FUNDRAISER -----------------------

---Adding Fundraiser
INSERT INTO Fundraiser_T
VALUES(
  seq_Fundraiser.nextval,
  'Donorthon 2020',
  '24-NOV-2020'
);

---Adding Fundraisers Attended
INSERT INTO FundraisersAttended_T
VALUES(
  seq_Donor.currval,
  seq_Fundraiser.currval
);




----- DISPLAY ALL FOR DEBUGGING -----
SELECT * FROM Donor_T;
SELECT * FROM Person_T;
SELECT * FROM Corporation_T;
SELECT * FROM Donation_T;
SELECT * FROM Payment_T;
SELECT * FROM CreditCard_T;
SELECT * FROM Check_T;
SELECT * FROM Fundraiser_T;
SELECT * FROM FundraisersAttended_T;