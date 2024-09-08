CREATE DATABASE BOOTCAMP_EXERCISE2;

USE BOOTCAMP_EXERCISE2;

CREATE TABLE WORKER(
	WORKER_ID INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(25),
    LAST_NAME CHAR(25),
    SALARY NUMERIC(15),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(25)
);
SELECT * FROM WORKER;

INSERT INTO WORKER
(FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
('Monika', 'Arora', 100000, '21-02-20 09:00:00','HR'),
('Niharika', 'Verma', 80000, '21-06-11 09:00:00','Admin'),
('Vishal', 'Singhal', 300000, '21-02-20 09:00:00','HR'),
('Mohan', 'Sarah', 300000, '21-03-19 09:00:00','Admin'),
('Amitabh', 'Singh', 500000, '21-02-20 09:00:00','Admin'),
('Vivek', 'Bhati', 490000, '21-06-11 09:00:00','Admin'),
('Vipul', 'Diwan', 200000, '21-06-11 09:00:00','Account'),
('Satish', 'Kumar', 75000, '21-01-20 09:00:00','Account'),
('Geetika', 'Chauhan', 90000, '21-04-11 09:00:00','Admin');

CREATE TABLE BONUS(
	WORKER_REF_ID INTEGER,
    BONUS_AMOUNT NUMERIC(10),
    BONUS_DATE DATETIME,
    FOREIGN KEY (WORKER_REF_ID) REFERENCES WORKER(WORKER_ID)
);
-- TASK 1: INSERT DATA INTO TABLE BONUS
INSERT INTO BONUS (WORKER_REF_ID,BONUS_AMOUNT, BONUS_DATE) VALUES
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME = 'VIVEK'),32000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME = 'VIVEK'),20000,'2022-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME = 'AMITABH'),21000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME = 'GEETIKA'),30000,'2021-11-02'),
((SELECT WORKER_ID FROM WORKER WHERE FIRST_NAME = 'SATISH'),4500,'2022-11-02');

SELECT * FROM BONUS;

-- TASK2: SHOW THE SECOND HIGHEST SALARY AMONG ALL WORKERS
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME)AS WORKER_NAME, 
SALARY
FROM WORKER 
ORDER BY SALARY DESC
LIMIT 1 OFFSET 1;

-- TASK 3: PRINT THE NAME OF EMPLOYEES HAVING THE HIGHEST SALARY IN EACH DEPARTMENT
SELECT CONCAT(FIRST_NAME,' ', LAST_NAME) AS FULL_NAME, SALARY, DEPARTMENT
FROM WORKER
WHERE (DEPARTMENT, SALARY) IN (
	SELECT DEPARTMENT, MAX(SALARY)
    FROM WORKER
    GROUP BY DEPARTMENT);
    
-- TASK 4: FETCH THE LIST OF EMPLOYEES WITH THE SAME SALARY
SELECT W.FIRST_NAME, W1.FIRST_NAME , W.SALARY
FROM WORKER W
JOIN WORKER W1 ON W.SALARY = W1.SALARY
WHERE W.FIRST_NAME != W1.FIRST_NAME;

-- TASK5 FIND THE WORKER NAMES WITH SALARIES + BONUS IN 2021
SELECT W.FIRST_NAME,  SUM(W.SALARY + IFNULL(B.BONUS_AMOUNT,0)) AS TOTAL_AMOUNT_2021
FROM WORKER W
LEFT JOIN BONUS B ON W.WORKER_ID = B.WORKER_REF_ID
AND YEAR(B.BONUS_DATE) = 2021
GROUP BY W.FIRST_NAME;

-- TASK 6
-- TRY TO DELETE ALL THE RECORDS IN TABLE WORKER
-- STUDY THE REASON WHY THE DATA CANNOT BE DELETED 
DELETE FROM WORKER;
-- ANS: CANNOT DELETE BECASUE OF  FOREIGN KEY  IN BONUS

SELECT CONSTRAINT_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME = 'BONUS' AND TABLE_SCHEMA = 'bootcamp_exercise2';

ALTER TABLE BONUS DROP FOREIGN KEY BONUS_IBFK_1;
DELETE FROM WORKER;

-- TASK 7
-- TRY TO DROP TABLE WORKER
-- STUDY THE REASON WHY THE TABLE CANNOT BE DELETED

DROP TABLE  WORKER;
-- AFTER TASK 6 TABLE 'BONUS' REMOVE THE FORRIGN KEY WITH 'WORKER', SO CAN DELETE TABLE 'WORKER' 

