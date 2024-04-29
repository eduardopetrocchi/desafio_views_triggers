use company;

CREATE USER 'gerente'@'localhost' IDENTIFIED BY 'senha';

GRANT SELECT ON company.qnt_employee TO 'gerente'@'localhost';
GRANT SELECT ON company.department_mgr TO 'gerente'@'localhost';
GRANT SELECT ON company.project_department_mgr TO 'gerente'@'localhost';


