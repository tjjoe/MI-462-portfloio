--- Payments Due Report
set serveroutput on;

CREATE OR REPLACE PROCEDURE Payments_Due_Report
IS
  Donor_Name Donor_T.Donor_Name%type;
  Donor_Address Donor_T.Donor_Address%type;
  Donation_Amount Donation_T.Donation_Amount%type;
  Donation_Date Donation_T.Donation_Date%type;
  Donation_NumPayments Donation_T.Donation_NumPayments%type;
  NumPaymentsMade NUMBER;
  TotalPaid NUMBER;

  CURSOR byDue_cur IS
    SELECT donor.Donor_Name, donor.Donor_Address, donation.Donation_Amount, donation.Donation_Date, donation.Donation_NumPayments, COUNT(p.Payment_ID), SUM(p.Payment_Amount)
    FROM Donor_T donor, Donation_T donation, Payment_T p
    WHERE donation.Donor_ID = donor.Donor_ID
      AND p.Donation_ID = donation.Donation_ID
    GROUP BY donor.Donor_Name, donor.Donor_Address, donation.Donation_Amount, donation.Donation_Date, donation.Donation_NumPayments;

BEGIN
  OPEN byDue_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Donor Name       Donor Address       Donation Amount       Donation Date       NumPayments       NumPaymentsMade       TotalPaid');
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------------------------------------------');
  LOOP
      FETCH byDue_cur INTO Donor_Name, Donor_Address, Donation_Amount, Donation_Date, Donation_NumPayments, NumPaymentsMade, TotalPaid;
      EXIT WHEN byDue_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '               ' ||
        Donor_Address || '               ' ||
        Donation_Amount || '               ' ||
        Donation_Date || '               ' ||
        Donation_NumPayments || '               ' ||
        NumPaymentsMade || '               ' ||
        TotalPaid
      );
  END LOOP;
  CLOSE byDue_cur;
END;