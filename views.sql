USE company;

CREATE OR REPLACE VIEW qnt_employee AS
SELECT
    d.dnumber AS numero_departamento,
    dl.dlocation AS localidade,
    COUNT(e.ssn) AS numero_funcionarios
FROM
    employee e
INNER JOIN department d ON e.dno = d.dnumber
INNER JOIN dept_locations dl ON d.dnumber = dl.dnumber
GROUP BY
    d.dnumber,
    dl.dlocation;

CREATE OR REPLACE VIEW department_mgr AS
SELECT
    ssn,
    mgr_ssn,
    dname
FROM
    employee e,
    department d
WHERE
    e.ssn = d.Mgr_ssn;

CREATE OR REPLACE VIEW project_department_mgr AS
SELECT
    p.pname,
    d.dname,
    CONCAT(e.Fname, ' ', e.Minit, ' ', e.Lname) AS nome_completo
FROM
    project p
JOIN department d ON p.dnum = d.dnumber
JOIN employee e ON d.mgr_ssn = e.ssn;

CREATE OR REPLACE VIEW dependent_view AS
SELECT
    Dependent_name AS Dependent_name,
    essn,
    ssn
FROM
    dependent d,
    employee e
WHERE
    d.Essn = e.ssn;
