--SELECT SUBSTR(SYS_CONNECT_BY_PATH(ENAME,'-'),2)
--FROM EMP
--START WITH MGR IS NULL
--CONNECT BY PRIOR EMPNO = MGR;

SELECT LISTAGG(LV || ', ') WITHIN GROUP(ORDER BY LV)
FROM(
SELECT LEVEL LV 
FROM DUAL
CONNECT BY LEVEL < 12
)