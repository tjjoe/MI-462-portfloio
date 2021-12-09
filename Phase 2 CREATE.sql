DROP TABLE Donor_T CASCADE CONSTRAINTS;
DROP TABLE Person_T CASCADE CONSTRAINTS;
DROP TABLE Corporation_T CASCADE CONSTRAINTS;

DROP TABLE Donation_T CASCADE CONSTRAINTS;

DROP TABLE Payment_T CASCADE CONSTRAINTS;
DROP TABLE CreditCard_T CASCADE CONSTRAINTS;
DROP TABLE Check_T CASCADE CONSTRAINTS;

DROP TABLE Fundraiser_T CASCADE CONSTRAINTS;
DROP TABLE FundraisersAttended_T CASCADE CONSTRAINTS;

DROP TABLE DonationLog_T CASCADE CONSTRAINTS;

CREATE TABLE Donor_T (
  Donor_ID NUMBER NOT NULL,
  Donor_Name VARCHAR2(30) NOT NULL,
  Donor_Address VARCHAR2(50),
  Donor_Type_Person NUMBER(1),
  Donor_Type_Corporation NUMBER(1),
  Donor_Phone NUMBER(11),
  Donor_TotalDonations NUMBER DEFAULT 0,
  Donor_Circle VARCHAR2(15),
  CONSTRAINT Donor_PK PRIMARY KEY (Donor_ID)
);

CREATE TABLE Person_T (
  PDonor_ID NUMBER NOT NULL,
  Person_Category VARCHAR2(15) CHECK (Person_Category IN (
    'senior', 'alumni', 'parent', 'administrator'
  )),
  Person_GradYear NUMBER,
  CONSTRAINT Person_PK PRIMARY KEY (PDonor_ID),
  CONSTRAINT Person_FK FOREIGN KEY (PDonor_ID) REFERENCES Donor_T(Donor_ID)
);

CREATE TABLE Corporation_T (
  CDonor_ID NUMBER NOT NULL,
  Corporation_SpouseName VARCHAR2(30),
  CONSTRAINT Corporation_PK PRIMARY KEY (CDonor_ID),
  CONSTRAINT Corporation_FK FOREIGN KEY (CDonor_ID) REFERENCES Donor_T(Donor_ID)
);

CREATE TABLE Donation_T(
  Donation_ID NUMBER NOT NULL,
  Donor_ID NUMBER NOT NULL,
  Donation_Date DATE,
  Donation_Amount NUMBER NOT NULL,
  Donation_NumPayments NUMBER CHECK (Donation_NumPayments >= 1),
  CONSTRAINT Donation_PK PRIMARY KEY (Donation_ID),
  CONSTRAINT Donation_FK FOREIGN KEY (Donor_ID) REFERENCES Donor_T(Donor_ID)
);

CREATE TABLE Payment_T(
  Payment_ID NUMBER NOT NULL,
  Donation_ID NUMBER NOT NULL,
  Payment_Date DATE,
  Payment_Amount NUMBER,
  Payment_Method VARCHAR2(10) CHECK (Payment_Method IN (
    'credit', 'check'
  )),
  CONSTRAINT Payment_PK PRIMARY KEY (Payment_ID),
  CONSTRAINT Payment_FK FOREIGN KEY (Donation_ID) REFERENCES Donation_T(Donation_ID)
);

CREATE TABLE CreditCard_T(
  Credit_Payment_ID NUMBER NOT NULL,
  Credit_CardNum NUMBER NOT NULL,
  Credit_ExpDate DATE NOT NULL,
  Credit_SecurityNum NUMBER NOT NULL,
  CONSTRAINT CreditCard_PK PRIMARY KEY (Credit_Payment_ID),
  CONSTRAINT CreditCard_FK FOREIGN KEY (Credit_Payment_ID) REFERENCES Payment_T(Payment_ID)
);

CREATE TABLE Check_T(
  Check_Payment_ID NUMBER NOT NULL,
  Check_Num NUMBER NOT NULL,
  Check_Comments VARCHAR2(50),
  CONSTRAINT Check_PK PRIMARY KEY (Check_Payment_ID),
  CONSTRAINT Check_FK FOREIGN KEY (Check_Payment_ID) REFERENCES Payment_T(Payment_ID)
);

CREATE TABLE Fundraiser_T(
  Fundraiser_ID NUMBER NOT NULL,
  Fundraiser_Name VARCHAR2(30) NOT NULL,
  Fundraiser_Date DATE,
  CONSTRAINT Fundraiser_PK PRIMARY KEY (Fundraiser_ID)
);

CREATE TABLE FundraisersAttended_T(
  Attended_Donor_ID NUMBER NOT NULL,
  Attended_Fundraiser_ID NUMBER NOT NULL,
  CONSTRAINT Attended_PK PRIMARY KEY (Attended_Donor_ID, Attended_Fundraiser_ID),
  CONSTRAINT Attended_Donor_FK FOREIGN KEY (Attended_Donor_ID) REFERENCES Donor_T(Donor_ID),
  CONSTRAINT Attended_Fundraiser_FK FOREIGN KEY (Attended_Fundraiser_ID) REFERENCES Fundraiser_T(Fundraiser_ID)
);

CREATE TABLE DonationLog_T(
  DonationLog_ID NUMBER NOT NULL,
  DonationLog_Date DATE,
  CONSTRAINT DonationLog_PK PRIMARY KEY (DonationLog_ID)
);