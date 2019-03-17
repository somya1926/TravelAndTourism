DROP TABLE IF EXISTS paymentInfo;
DROP TABLE IF EXISTS bookingInfo;
DROP TABLE IF EXISTS tourInfo;
DROP TABLE IF EXISTS hotelInfo;
DROP TABLE IF EXISTS userAccount;

/*Table 1*/
CREATE TABLE userAccount(
  U_ID      INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  U_PASS    VARCHAR(50) NOT NULL ,
  U_NAME    VARCHAR(30) NOT NULL ,
  U_EMAIL   VARCHAR(30) NOT NULL UNIQUE ,
  U_MOB     INTEGER(10) NOT NULL UNIQUE ,
  /*Admin: 1 | Customer: 0*/
  U_ADMIN   INTEGER(1) CHECK ( U_ADMIN=0 OR U_ADMIN=1 ) DEFAULT 0
);

/*Table 2*/
CREATE TABLE hotelInfo(
  H_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  H_NAME VARCHAR(30) NOT NULL ,
  T_PLACE VARCHAR(20) UNIQUE NOT NULL
);

/*Table 3*/
CREATE TABLE tourInfo(
      T_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      T_NAME VARCHAR UNIQUE NOT NULL ,
      T_PLACE_1 VARCHAR(20),
      T_PLACE_2 VARCHAR(20),
      T_PLACE_3 VARCHAR(20),
      T_DAYS INTEGER(50) NOT NULL CHECK (T_DAYS<11),
      T_PRICE INTEGER NOT NULL,

      CONSTRAINT tInfo_hInfo_tp1 FOREIGN KEY (T_PLACE_1) REFERENCES hotelInfo(T_PLACE)
                     ON DELETE SET NULL ON UPDATE CASCADE,
      CONSTRAINT tInfo_hInfo_tp2 FOREIGN KEY (T_PLACE_2) REFERENCES hotelInfo(T_PLACE)
                     ON DELETE SET NULL ON UPDATE CASCADE,
      CONSTRAINT tInfo_hInfo_tp3 FOREIGN KEY (T_PLACE_3) REFERENCES hotelInfo(T_PLACE)
                     ON DELETE SET NULL ON UPDATE CASCADE
     );

/*Table 4*/
CREATE TABLE bookingInfo(
  B_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  B_DATE DATE NOT NULL ,
  T_ID INTEGER NOT NULL ,
  T_DATE DATE NOT NULL ,
  U_EMAIL VARCHAR(30) NOT NULL UNIQUE ,
  PERSONS INTEGER NOT NULL CHECK ( PERSONS>0 AND PERSONS<8 ),
  /* ST: Standard | SU: Superior | DE: Deluxe */
  R_TYPE VARCHAR(2) NOT NULL CHECK ( R_TYPE='ST' OR R_TYPE='SU' OR R_TYPE='DE' ),
  T_AMOUNT INTEGER NOT NULL CHECK ( T_AMOUNT>10000 ),

  CONSTRAINT bInfo_uAcc_umail FOREIGN KEY (U_EMAIL) REFERENCES userAccount(U_EMAIL)
                        ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT binfo_tInfo_tid FOREIGN KEY (T_ID) REFERENCES tourInfo(T_ID)
                        ON DELETE SET NULL ON UPDATE CASCADE
);

/*Table 5*/
CREATE TABLE paymentInfo(
  P_ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  P_DATE DATE NOT NULL ,
  B_ID INTEGER UNIQUE NOT NULL ,
  T_AMOUNT INTEGER NOT NULL CHECK ( T_AMOUNT>10000 ) ,
  /* Paid: 1 | Due: 0*/
  P_STATUS INTEGER(1) CHECK(P_STATUS=0 OR P_STATUS=1) DEFAULT 0,

  CONSTRAINT pInfo_bInfo_bid FOREIGN KEY (B_ID) REFERENCES bookingInfo(B_ID)
                        ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT pInfo_bInfo_tam FOREIGN KEY (T_AMOUNT) REFERENCES bookingInfo(T_AMOUNT)
                        ON DELETE CASCADE ON UPDATE CASCADE
);