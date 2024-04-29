# Guia de Configuração do Banco de Dados Company

Este é um guia passo a passo para configurar o banco de dados Company. Ele inclui a criação de visualizações, a atribuição de permissões de acesso e a criação de gatilhos (triggers).

## Configuração Inicial

Para começar, certifique-se de que você está conectado ao seu servidor de banco de dados MySQL e que o banco de dados `company` está selecionado.

```sql
USE company;
```

## Criação de Visualizações



Esta visualização mostra a quantidade de funcionários por departamento e localidade.

```sql
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
```

### Visualização de Gerentes de Departamento


```sql
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
```

### Visualização de Gerentes de Projetos por Departamento

```sql
CREATE OR REPLACE VIEW project_department_mgr AS
SELECT
    p.pname,
    d.dname,
    CONCAT(e.Fname, ' ', e.Minit, ' ', e.Lname) AS nome_completo
FROM
    project p
JOIN department d ON p.dnum = d.dnumber
JOIN employee e ON d.mgr_ssn = e.ssn;
```

### Visualização de Dependentes


```sql
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
```

## Atribuição de Permissões de Acesso


```sql
GRANT SELECT ON company.qnt_employee TO 'gerente'@'localhost';
GRANT SELECT ON company.department_mgr TO 'gerente'@'localhost';
GRANT SELECT ON company.project_department_mgr TO 'gerente'@'localhost';
```

## Criação de Gatilhos (Triggers)

### Gatilho para Deletar Usuário


```sql
DELIMITER //
CREATE TRIGGER delete_user
AFTER DELETE ON employee
FOR EACH ROW
BEGIN
    DELETE FROM users WHERE ssn = OLD.ssn;
END;
//
DELIMITER ;
```

### Gatilho para Inserir Funcionário


```sql
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
```


## Autores

- [@eduardopetrocchi](https://www.github.com/eduardopetrocchi)

