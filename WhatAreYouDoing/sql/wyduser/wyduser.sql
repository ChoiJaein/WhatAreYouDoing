/**
 *  WYDUSER 스키마
 */

 CREATE TABLE WYDUSER (
              USERID		VARCHAR2(15) PRIMARY KEY
             ,USERPW		VARCHAR2(20) NOT NULL
             ,USERNAME      VARCHAR2(7) NOT NULL
             ,USEREMAIL		VARCHAR2(50) NOT NULL
 );
  
 
SELECT * FROM WYDUSER;

DROP TABLE WYDUSER;
