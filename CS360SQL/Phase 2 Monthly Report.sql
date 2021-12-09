--- Monthly Report
set serveroutput on;

CREATE OR REPLACE PROCEDURE Monthly_Report
IS
  Donation_Date NUMBER;
  Donation_Amount Donation_T.Donation_Amount%type;

  v_Total_Raised NUMBER;

  CURSOR byMonth_cur IS
    SELECT EXTRACT(MONTH FROM d.Donation_Date), SUM(d.Donation_Amount)
    FROM Donation_T d
    WHERE EXTRACT(MONTH FROM d.Donation_Date) = EXTRACT(MONTH FROM SYSDATE)
    GROUP BY EXTRACT(MONTH FROM d.Donation_Date);

BEGIN
  SELECT SUM(Donation_Amount) INTO v_Total_Raised FROM Donation_T;

  OPEN byMonth_cur;
  DBMS_OUTPUT.PUT_LINE(chr(10) || 'Donation Month       Percentage of Total       Amount');
  DBMS_OUTPUT.PUT_LINE('-------------------------------');
  LOOP
      FETCH byMonth_cur INTO Donation_Date, Donation_Amount;
      EXIT WHEN byMonth_cur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(
        Donation_Date || '                       ' ||
        (Donation_Amount * 100) / v_Total_Raised || '                       $' ||
        Donation_Amount
      );
  END LOOP;
  CLOSE byMonth_cur;
END;