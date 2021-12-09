--- Annual Report to Donors
--- Listing by Catagory, Year, and Donor Circle
set serveroutput on;

CREATE OR REPLACE PROCEDURE Annual_Report
IS
  Donor_Name Donor_T.Donor_Name%type;
  Person_Category Person_T.Person_Category%type;
  Person_GradYear Person_T.Person_GradYear%type;
  Donor_Circle Donor_T.Donor_Circle%type;
  Donor_TotalDonations Donor_T.Donor_TotalDonations%type;

  v_Total_Raised Donation_T.Donation_Amount%type;

  CURSOR Category_cur IS
    SELECT d.Donor_Name, p.Person_Category
    FROM Donor_T d, Person_T p
    WHERE d.Donor_ID = p.PDonor_ID
    ORDER BY p.Person_Category;
  
  CURSOR GradYear_cur IS
    SELECT d.Donor_Name, p.Person_GradYear
    FROM Donor_T d, Person_T p
    WHERE d.Donor_ID = p.PDonor_ID
    ORDER BY p.Person_GradYear;

  CURSOR DonorCircle_cur IS
    SELECT d.Donor_Name, d.Donor_Circle
    FROM Donor_T d
    ORDER BY d.Donor_Circle;

  CURSOR byYear_cur IS
    SELECT SUM(d.Donor_TotalDonations), p.Person_GradYear
    FROM Donor_T d, Person_T p
    WHERE p.PDonor_ID = d.Donor_ID
    GROUP BY p.Person_GradYear;

  CURSOR byCategory_cur IS
    SELECT SUM(d.Donor_TotalDonations), p.Person_Category
    FROM Donor_T d, Person_T p
    WHERE p.PDonor_ID = d.Donor_ID
    GROUP BY p.Person_Category;

  CURSOR byDonorCircle_cur IS
    SELECT SUM(d.Donor_TotalDonations), d.Donor_Circle
    FROM Donor_T d
    GROUP BY d.Donor_Circle;

  CURSOR byClassDonorCircle_cur IS
    SELECT SUM(d.Donor_TotalDonations), p.Person_GradYear, d.Donor_Circle
    FROM Donor_T d, Person_T p
    GROUP BY p.Person_GradYear, d.Donor_Circle;

BEGIN
  SELECT SUM(Donation_Amount) INTO v_Total_Raised FROM Donation_T;

  OPEN Category_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Donor Name       Donor Catagory');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  LOOP
      FETCH Category_cur INTO Donor_Name, Person_Category;
      EXIT WHEN Category_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '     ' ||
        Person_Category
      );
  END LOOP;
  CLOSE Category_cur;

  OPEN GradYear_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Donor Name       Donor Grad Year');
  DBMS_OUTPUT.PUT_LINE('--------------------------------');
  LOOP
      FETCH GradYear_cur INTO Donor_Name, Person_GradYear;
      EXIT WHEN GradYear_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '     ' ||
        Person_GradYear
      );
  END LOOP;
  CLOSE GradYear_cur;

  OPEN DonorCircle_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Donor Name       Donor Circle');
  DBMS_OUTPUT.PUT_LINE('-----------------------------');
  LOOP
      FETCH DonorCircle_cur INTO Donor_Name, Donor_Circle;
      EXIT WHEN DonorCircle_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donor_Name || '     ' ||
        Donor_Circle
      );
  END LOOP;
  CLOSE DonorCircle_cur;

  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Total Amount Raised: $' || v_Total_Raised);

  OPEN byYear_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Raised         Percentage       Year');
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
  LOOP
      FETCH byYear_cur INTO Donor_TotalDonations, Person_GradYear;
      EXIT WHEN byYear_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('$' ||
        Donor_TotalDonations || '            ' ||
        (Donor_TotalDonations * 100) / v_Total_Raised || '              ' ||
        Person_GradYear
      );
  END LOOP;
  CLOSE byYear_cur;

  OPEN byCategory_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Raised         Category');
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
  LOOP
      FETCH byCategory_cur INTO Donor_TotalDonations, Person_Category;
      EXIT WHEN byCategory_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('$' ||
        Donor_TotalDonations || '            ' ||
        Person_Category
      );
  END LOOP;
  CLOSE byCategory_cur;

  OPEN byDonorCircle_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Raised         Donor Circle');
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
  LOOP
      FETCH byDonorCircle_cur INTO Donor_TotalDonations, Donor_Circle;
      EXIT WHEN byDonorCircle_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('$' ||
        Donor_TotalDonations || '            ' ||
        Donor_Circle
      );
  END LOOP;
  CLOSE byDonorCircle_cur;

  OPEN byClassDonorCircle_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Raised         Year       Donor Circle');
  DBMS_OUTPUT.PUT_LINE('-----------------------------------------');
  LOOP
      FETCH byClassDonorCircle_cur INTO Donor_TotalDonations, Person_GradYear, Donor_Circle;
      EXIT WHEN byClassDonorCircle_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('$' ||
        Donor_TotalDonations || '            ' ||
        Person_GradYear || '              ' ||
        Donor_Circle
      );
  END LOOP;
  CLOSE byClassDonorCircle_cur;
END;