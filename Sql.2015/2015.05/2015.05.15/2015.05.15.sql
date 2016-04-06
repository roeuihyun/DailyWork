/*4.SQL 작성 응용*/

/*4.1 조인*/

/*4.1.1 조인 개념 : ANSI SQL 특징, 벤더 독립 SQL 특징의 예제*/

/* ORACLE SQL*/

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       E.LAST_NAME,
       D.DEPARTMENT_ID,
       D.LOCATION_ID
  FROM EMPLOYEES E, DEPARTMENTS D
 WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID;

/*ANSI SQL*/

SELECT EMPLOYEES.EMPLOYEE_ID,
       EMPLOYEES.FIRST_NAME,
       EMPLOYEES.LAST_NAME,
       DEPARTMENTS.DEPARTMENT_ID,
       DEPARTMENTS.LOCATION_ID
  FROM    EMPLOYEES
       JOIN
          DEPARTMENTS
       ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID;

/*4.1 조인 PAGE 25/92 실습*/

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       D.DEPARTMENT_NAME,
       L.CITY
  FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
 WHERE     E.JOB_ID = 'FI_ACCOUNT'
       AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
       AND D.LOCATION_ID = L.LOCATION_ID;

SELECT EMPLOYEES.EMPLOYEE_ID,
       EMPLOYEES.FIRST_NAME,
       DEPARTMENTS.DEPARTMENT_NAME,
       LOCATIONS.CITY
  FROM EMPLOYEES
       JOIN DEPARTMENTS
          ON EMPLOYEES.JOB_ID = 'FI_ACCOUNT'
             AND EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
       JOIN LOCATIONS
          ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID;


/*4.1 조인 PAGE 26/92 실습*/

  SELECT E.EMPLOYEE_ID,
         E.FIRST_NAME,
         D.DEPARTMENT_NAME,
         L.CITY
    FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
   WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
         AND D.LOCATION_ID = L.LOCATION_ID(+)
ORDER BY D.DEPARTMENT_ID ASC;


  SELECT EMPLOYEES.EMPLOYEE_ID,
         EMPLOYEES.FIRST_NAME,
         DEPARTMENTS.DEPARTMENT_NAME,
         LOCATIONS.CITY
    FROM EMPLOYEES
         LEFT JOIN DEPARTMENTS
            ON EMPLOYEES.DEPARTMENT_ID = DEPARTMENTS.DEPARTMENT_ID
         LEFT JOIN LOCATIONS
            ON DEPARTMENTS.LOCATION_ID = LOCATIONS.LOCATION_ID
ORDER BY DEPARTMENTS.DEPARTMENT_ID ASC;

/*4.1 조인 PAGE 27/92 실습*/

SELECT E.EMPLOYEE_ID "사번",
       E.LAST_NAME "이름",
       J.MIN_SALARY "최소연봉"
  FROM EMPLOYEES E, JOBS J
 WHERE     E.DEPARTMENT_ID = 30
       AND E.JOB_ID = J.JOB_ID(+)
       AND NVL (J.MIN_SALARY, 5000) > 3000;

SELECT E.EMPLOYEE_ID "사번",
       E.LAST_NAME "이름",
       J.MIN_SALARY "최소연봉"
  FROM EMPLOYEES E, JOBS J
 WHERE     E.DEPARTMENT_ID = 30
       AND E.JOB_ID = J.JOB_ID(+)
       AND NVL (J.MIN_SALARY(+), 5000) > 3000;

--최소급여가 null인 회원도 존재하게끔 보여준다.


SELECT EMPLOYEES.EMPLOYEE_ID "사번",
       EMPLOYEES.LAST_NAME "이름",
       JOBS.MIN_SALARY "최소연봉"
  FROM    EMPLOYEES
       LEFT JOIN
          JOBS
       ON EMPLOYEES.JOB_ID = JOBS.JOB_ID
          AND NVL (JOBS.MIN_SALARY, 5000) > 3000
 WHERE EMPLOYEES.DEPARTMENT_ID = 30;



/*4.1 조인 PAGE 37/92 연습문제*/

  SELECT E1.FIRST_NAME "사원이름",
         E1.EMPLOYEE_ID "사원ID",
         E2.FIRST_NAME "관리자이름",
         E2.EMPLOYEE_ID "관리자번호"
    FROM EMPLOYEES E1, EMPLOYEES E2
   WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID(+)
ORDER BY E1.EMPLOYEE_ID ASC;

  SELECT E1.FIRST_NAME "사원이름",
         E1.EMPLOYEE_ID "사원ID",
         E2.FIRST_NAME "관리자이름",
         E2.EMPLOYEE_ID "관리자번호"
    FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
ORDER BY E1.EMPLOYEE_ID ASC;

/*4.1 조인 PAGE 38/92 연습문제*/

  SELECT E1.FIRST_NAME "사원이름",
         TO_CHAR (E1.HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') "사원채용일",
         E2.FIRST_NAME "관리자이름",
         TO_CHAR (E2.HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') "관리자채용일"
    FROM EMPLOYEES E1, EMPLOYEES E2
   WHERE E1.MANAGER_ID = E2.EMPLOYEE_ID(+) AND E1.HIRE_DATE < E2.HIRE_DATE
ORDER BY E1.EMPLOYEE_ID ASC;

  SELECT E1.FIRST_NAME "사원이름",
         TO_CHAR (E1.HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') "사원채용일",
         E2.FIRST_NAME "관리자이름",
         TO_CHAR (E2.HIRE_DATE, 'YYYY/MM/DD HH24:MI:SS') "관리자채용일"
    FROM EMPLOYEES E1 LEFT JOIN EMPLOYEES E2 ON E1.MANAGER_ID = E2.EMPLOYEE_ID
   WHERE E1.HIRE_DATE < E2.HIRE_DATE
ORDER BY E1.EMPLOYEE_ID ASC;

/*4.2 서브쿼리 PAGE 71/92 연습문제*/

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
          (SELECT DEPARTMENT_ID
             FROM EMPLOYEES
            WHERE SALARY > (SELECT AVG (SALARY) FROM EMPLOYEES)
                  AND LAST_NAME LIKE '%U%');

/*4.2 서브쿼리 PAGE 71/92 연습문제*/

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
  FROM EMPLOYEES
 WHERE DEPARTMENT_ID =
          (SELECT DEPARTMENT_ID
             FROM EMPLOYEES
            WHERE SALARY > (SELECT AVG (SALARY) FROM EMPLOYEES)
                  AND LAST_NAME LIKE '%U%');

/*4.2 서브쿼리 PAGE 72/92 연습문제*/

WITH SALARY
        AS (SELECT DEPARTMENT_ID, EMPLOYEE_ID || LAST_NAME EMP_NAME, SALARY
              FROM EMPLOYEES),
     MAX_SALARY AS (  SELECT DEPARTMENT_ID, MAX (SALARY) MAX_SALARY
                        FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID),
     MIN_SALARY AS (  SELECT DEPARTMENT_ID, MIN (SALARY) MIN_SALARY
                        FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID)
  SELECT SAL.DEPARTMENT_ID DID,
         MAX (DECODE (MAX_SALARY, SALARY, EMP_NAME)) 최대사원,
         MAX (DECODE (MAX_SALARY, SALARY, SALARY)) SALARY,
         SAL.DEPARTMENT_ID DID,
         MAX (DECODE (MIN_SALARY, SALARY, EMP_NAME)) 최소사원,
         MAX (DECODE (MIN_SALARY, SALARY, SALARY)) SALARY
    FROM SALARY SAL, MAX_SALARY MAX_SAL, MIN_SALARY MIN_SAL
   WHERE MAX_SAL.DEPARTMENT_ID = SAL.DEPARTMENT_ID
         AND MIN_SAL.DEPARTMENT_ID = SAL.DEPARTMENT_ID
GROUP BY SAL.DEPARTMENT_ID
  HAVING SAL.DEPARTMENT_ID IS NOT NULL
ORDER BY SAL.DEPARTMENT_ID;

WITH SALARY
        AS (SELECT DEPARTMENT_ID, EMPLOYEE_ID || LAST_NAME EMP_NAME, SALARY
              FROM EMPLOYEES),
     MAX_SALARY AS (  SELECT DEPARTMENT_ID, MAX (SALARY) MAX_SALARY
                        FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID),
     MIN_SALARY AS (  SELECT DEPARTMENT_ID, MIN (SALARY) MIN_SALARY
                        FROM EMPLOYEES
                    GROUP BY DEPARTMENT_ID)
  SELECT SAL.DEPARTMENT_ID DID,
         MAX (DECODE (MAX_SALARY, SALARY, EMP_NAME)) 최대사원,
         MAX (DECODE (MAX_SALARY, SALARY, SALARY)) SALARY,
         SAL.DEPARTMENT_ID DID,
         MAX (DECODE (MIN_SALARY, SALARY, EMP_NAME)) 최소사원,
         MAX (DECODE (MIN_SALARY, SALARY, SALARY)) SALARY
    FROM SALARY SAL
         LEFT JOIN MAX_SALARY MAX_SAL
            ON MAX_SAL.DEPARTMENT_ID = SAL.DEPARTMENT_ID
         LEFT JOIN MIN_SALARY MIN_SAL
            ON MIN_SAL.DEPARTMENT_ID = SAL.DEPARTMENT_ID
GROUP BY SAL.DEPARTMENT_ID
  HAVING SAL.DEPARTMENT_ID IS NOT NULL
ORDER BY SAL.DEPARTMENT_ID;

/*4.2 서브쿼리 PAGE 73/92 연습문제*/

  SELECT E.EMPLOYEE_ID,
         E.FIRST_NAME,
         NVL ( (SELECT J.MAX_SALARY
                  FROM JOBS J
                 WHERE E.JOB_ID = J.JOB_ID AND J.JOB_TITLE LIKE 'Shipping%'),
              0)
            최대급여
    FROM EMPLOYEES E
   WHERE E.DEPARTMENT_ID = 50
ORDER BY E.EMPLOYEE_ID DESC;


/*4.3.1 계층쿼리  PAGE 81/92 연습문제*/

    SELECT LPAD (' ', 2 * (LEVEL - 1)) || EMPLOYEE_ID "사원ID", FIRST_NAME
      FROM EMPLOYEES
START WITH MANAGER_ID IS NULL
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;

/*4.4.2 TOP N 쿼리 사용하기 PAGE 89/92*/

SELECT A.*
FROM (SELECT EMPLOYEE_ID, FIRST_NAME, HIRE_DATE
           FROM EMPLOYEES
           ORDER BY HIRE_DATE DESC) A
WHERE ROWNUM <= 5;

/*4.4.2 TOP N 쿼리 사용하기 PAGE 90/92*/

SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.START_DATE, J.END_DATE, J.JOB_ID
FROM EMPLOYEES E, JOB_HISTORY J
WHERE J.EMPLOYEE_ID = E.EMPLOYEE_ID
AND J.START_DATE = (SELECT JH.START_DATE
                                  FROM (SELECT START_DATE, EMPLOYEE_ID
                                             FROM JOB_HISTORY
                                             ORDER BY START_DATE DESC) JH
                                  WHERE JH.EMPLOYEE_ID = E.EMPLOYEE_ID
                                  AND ROWNUM = 1);


/*4.4.2 TOP N 쿼리 사용하기 PAGE 91/92*/

SELECT E.EMPLOYEE_ID,
       E.FIRST_NAME,
       J.START_DATE,
       J.END_DATE,
       J.JOB_ID
  FROM EMPLOYEES E, JOB_HISTORY J
 WHERE J.EMPLOYEE_ID = E.EMPLOYEE_ID
       AND J.START_DATE = (SELECT MAX (JH.START_DATE)
                             FROM JOB_HISTORY JH
                            WHERE JH.EMPLOYEE_ID = J.EMPLOYEE_ID);

/*4.4.2 TOP N 쿼리 사용하기 PAGE 92/92*/

SELECT A.EMPLOYEE_ID,
       A.FIRST_NAME,
       A.START_DATE,
       A.END_DATE,
       A.JOB_ID
  FROM (SELECT E.EMPLOYEE_ID,
               E.FIRST_NAME,
               J.START_DATE,
               J.END_DATE,
               J.JOB_ID,
               ROW_NUMBER ()
               OVER (PARTITION BY J.EMPLOYEE_ID ORDER BY J.START_DATE DESC)
                  RN
          FROM EMPLOYEES E, JOB_HISTORY J
         WHERE J.EMPLOYEE_ID = E.EMPLOYEE_ID) A
 WHERE A.RN = 1;


SELECT JOB_ID,
       FIRST_NAME,
       SALARY,
       RANK () OVER (ORDER BY SALARY DESC) ALL_RANK,
       RANK () OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC) JOB_RANK01,
       ROW_NUMBER () OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC)
          JOB_RANK02,
       DENSE_RANK () OVER (PARTITION BY JOB_ID ORDER BY SALARY DESC)
          JOB_RANK03
  FROM EMPLOYEES;



--분석용 함수
--RANK - 해당값에 대한 우선순위를 결정 (중복 우선순위 허용)
--DENSE_RANK - 해당값에 대한 우선순위를 결정 (중복 우선순위 허용 안함)
--ROW_NUMBER - 조건을 만족하는 모든 행의 번호를 제공
--CUME_DIST - 분산값
--PERCENT_RANK - 백분율
--NTILE(n) - 전체 데이터 분포를 n-Buckets으로 나누어 표시
--FIRST_VALUE - 정렬된 값중에서 첫번째 값을 반환.
--LAST_VALUE - 정렬된 값중에서 마지막 값을 반환.
--
-- OVER() 에 사용되는 OPTION
--1. PARTITION BY
--2. ORDER BY DESC
--3. NULLS FIRST : NULL 데이터를 먼저 출력.
--4. NULLS LAST : NULL 데이터를 나중에 출력.