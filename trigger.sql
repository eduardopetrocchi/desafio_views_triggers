use company;


DELIMITER //
CREATE TRIGGER delete_user
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    DELETE FROM users WHERE ssn = OLD.ssn;
END;
//
DELIMITER ;

DELIMITER //

CREATE TRIGGER insert_employee
AFTER INSERT ON employee
FOR EACH ROW
BEGIN
    INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn, Dno)
    VALUES (NEW.Fname, NEW.Minit, NEW.Lname, NEW.Ssn, NEW.Bdate, NEW.Address, NEW.Sex, NEW.Salary, NEW.Super_ssn, NEW.Dno);
END;

//

DELIMITER ;

