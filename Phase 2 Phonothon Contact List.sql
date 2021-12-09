--- Phonothon Volunteer Contact List
set serveroutput on;

CREATE OR REPLACE PROCEDURE Phonothon_Contact_List
IS
  Donor_Name Donor_T.Donor_Name%type;
  Donor_Address Donor_T.Donor_Address%type;
  Donor_Phone Donor_T.Donor_Phone%type;
  Person_GradYear Person_T.Person_GradYear%type;
  Person_Category Person_T.Person_Category%type;
  LastYearDonation Donation_T.Donation_Amount%type;

  CURSOR byDonor_cur IS
    SELECT d.Donor_Name, d.Donor_Address, d.Donor_Phone, p.Person_GradYear, p.Person_Category, SUM(dn.Donation_Amount)
    FROM Donor_T d, Person_T p, Donation_T dn
    WHERE p.PDonor_ID = d.Donor_ID
    AND EXTRACT(YEAR FROM dn.Donation_Date) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY d.Donor_Name, d.Donor_Address, d.Donor_Phone, p.Person_GradYear, p.Person_Category;

BEGIN
  OPEN byDonor_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Name       Address       Phone       GradYear       Category       LastYearDonations');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
  LOOP
      FETCH byDonor_cur INTO Donor_Name, Donor_Address, Donor_Phone, Person_GradYear, Person_Category, LastYearDonation;
      EXIT WHEN byDonor_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '                       ' ||
        Donor_Address || '                       ' ||
        Donor_Phone || '                       ' ||
        Person_GradYear || '                       ' ||
        Person_Category || '                       ' ||
        LastYearDonation
      );
  END LOOP;
  CLOSE byDonor_cur;
END;