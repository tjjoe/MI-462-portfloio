--- Class Representatitve Contact List
set serveroutput on;

CREATE OR REPLACE PROCEDURE Representative_Contact_List
IS
  Donor_Name Donor_T.Donor_Name%type;
  Donor_Address Donor_T.Donor_Address%type;
  Donor_Phone Donor_T.Donor_Phone%type;
  LastYearDonation Donation_T.Donation_Amount%type;
  ThisYearDonation Donation_T.Donation_Amount%type;

  CURSOR byCurrentYear_cur IS
    SELECT d.Donor_Name, d.Donor_Address, d.Donor_Phone, SUM(dn.Donation_Amount)
    FROM Donor_T d, Donation_T dn
    WHERE EXTRACT(YEAR FROM dn.Donation_Date) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY Donor_Name, Donor_Address, Donor_Phone;

  CURSOR byLastYear_cur IS
    SELECT d.Donor_Name, d.Donor_Address, d.Donor_Phone, SUM(dn.Donation_Amount)
    FROM Donor_T d, Donation_T dn
    WHERE EXTRACT(YEAR FROM dn.Donation_Date) = EXTRACT(YEAR FROM SYSDATE) - 1
    GROUP BY Donor_Name, Donor_Address, Donor_Phone;

BEGIN
  OPEN byCurrentYear_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Name       Address       Phone       CurrentYearDonations');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
  LOOP
      FETCH byCurrentYear_cur INTO Donor_Name, Donor_Address, Donor_Phone, ThisYearDonation;
      EXIT WHEN byCurrentYear_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '                       ' ||
        Donor_Address || '                       ' ||
        Donor_Phone || '                       ' ||
        ThisYearDonation
      );
  END LOOP;
  CLOSE byCurrentYear_cur;

  OPEN byLastYear_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Name       Address       Phone       LastYearDonations');
  DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------');
  LOOP
      FETCH byLastYear_cur INTO Donor_Name, Donor_Address, Donor_Phone, LastYearDonation;
      EXIT WHEN byLastYear_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '                       ' ||
        Donor_Address || '                       ' ||
        Donor_Phone || '                       ' ||
        LastYearDonation
      );
  END LOOP;
  CLOSE byLastYear_cur;
END;