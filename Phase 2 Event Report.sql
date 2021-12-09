--- Event Report
set serveroutput on;

CREATE OR REPLACE PROCEDURE Event_Report
IS
  Fundraiser_Name Fundraiser_T.Fundraiser_Name%type;
  Donor_Name Donor_T.Donor_Name%type;
  Donor_TotalDonations Donor_T.Donor_TotalDonations%type;

  CURSOR byEvent_cur IS
    SELECT f.Fundraiser_Name, d.Donor_Name, d.Donor_TotalDonations
    FROM Fundraiser_T f, Donor_T d, FundraisersAttended_T fa
    WHERE d.Donor_ID = fa.Attended_Donor_ID
      AND f.Fundraiser_ID = fa.Attended_Fundraiser_ID
    ORDER BY f.Fundraiser_Name;

BEGIN
  OPEN byEvent_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Fundraiser       Donor Name       Amount Donated');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  LOOP
      FETCH byEvent_cur INTO Fundraiser_Name, Donor_Name, Donor_TotalDonations;
      EXIT WHEN byEvent_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Fundraiser_Name || '                       ' ||
        Donor_Name || '                       $' ||
        Donor_TotalDonations
      );
  END LOOP;
  CLOSE byEvent_cur;
END;