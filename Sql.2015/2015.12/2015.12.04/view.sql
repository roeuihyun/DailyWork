DROP VIEW V_INSA;

/* Formatted on 2013/12/06 오전 9:46:58 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW V_INSA
(
   SABUN,
   NAME,
   ENG_NAME,
   CMP_REG_NO,
   JOIN_GBN_CODE
)
AS
   SELECT SABUN,
          NAME,
          ENG_NAME,
          CMP_REG_NO,
          JOIN_GBN_CODE
     FROM INSA
    WHERE JOIN_GBN_CODE = 'RGL';



DROP VIEW CP_INSA;

/* Formatted on 2013/12/05 오후 4:50:58 (QP5 v5.215.12089.38647) */
CREATE OR REPLACE FORCE VIEW CP_INSA
(
   SABUN,
   ENG_NAME,
   ZIPCODE,
   ADDR
)
AS
   SELECT I.SABUN,
          I.ENG_NAME,
          C.CMP_ZIP ZIPCODE,
          C.CMP_ADDR1 ADDR
     FROM INSA I, INSA_COMPANY C
    WHERE I.CMP_REG_NO = C.CMP_REG_NO(+);