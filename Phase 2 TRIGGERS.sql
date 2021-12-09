--- Trigger for totalling the donations and specifying Donor Circle
CREATE OR REPLACE TRIGGER TotalDonations_trig
AFTER INSERT ON Donation_T
FOR EACH ROW
BEGIN
  UPDATE Donor_T
  SET Donor_TotalDonations = Donor_TotalDonations + :NEW.Donation_Amount
  WHERE Donor_ID = :NEW.Donor_ID;
  
  UPDATE Donor_T
  SET Donor_Circle = CASE
  WHEN Donor_TotalDonations >= 50000 THEN 'President'
  WHEN Donor_TotalDonations >= 25000 THEN 'Platinum'
  WHEN Donor_TotalDonations >= 12500 THEN 'Diamond'
  WHEN Donor_TotalDonations >= 6250 THEN 'Gold'
  WHEN Donor_TotalDonations >= 3125 THEN 'Silver'
  WHEN Donor_TotalDonations >= 1562 THEN 'Copper'
  WHEN Donor_TotalDonations >= 781 THEN 'Aluminum'
  WHEN Donor_TotalDonations >= 390 THEN 'Lead'
  WHEN Donor_TotalDonations >= 195 THEN 'Mercury'
  WHEN Donor_TotalDonations >= 100 THEN 'Graphite'
  END
  WHERE Donor_ID = :NEW.Donor_ID;
END;
/

--- Trigger for donation log
CREATE OR REPLACE TRIGGER DonationLog_trig
AFTER INSERT ON Donation_T
FOR EACH ROW
BEGIN
  INSERT INTO DonationLog_T
  VALUES(
    SEQ_DONATIONLOG.nextval,
    SYSDATE
  );
END;
/