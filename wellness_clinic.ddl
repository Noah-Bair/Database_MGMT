-- Wellness Clinic: Create Tables
set echo on;

CREATE TABLE dlv_room (
    deliveryid  INTEGER NOT NULL,
    baby_cnt    INTEGER
);

ALTER TABLE dlv_room ADD CONSTRAINT dlv_room_pk PRIMARY KEY ( deliveryid );

CREATE TABLE doctor (
    docid                 INTEGER NOT NULL,
    doc_name              VARCHAR2(15),
    master_sched_schedid  INTEGER NOT NULL
);

ALTER TABLE doctor ADD CONSTRAINT doctor_pk PRIMARY KEY ( docid );

CREATE TABLE er_staff (
    staffid               INTEGER NOT NULL,
    er_phone              INTEGER,
    er_name               VARCHAR2(15),
    master_sched_schedid  INTEGER NOT NULL
);

ALTER TABLE er_staff ADD CONSTRAINT er_staff_pk PRIMARY KEY ( staffid );

CREATE TABLE insurance (
    insid              INTEGER NOT NULL,
    clinic             VARCHAR2(15),
    address            CLOB,
    phone              INTEGER,
    s_name             VARCHAR2(15),
    patient_patientid  INTEGER NOT NULL
);

ALTER TABLE insurance ADD CONSTRAINT insurance_pk PRIMARY KEY ( insid );

CREATE TABLE lab_report (
    labid              INTEGER NOT NULL,
    test_type          CLOB,
    testid             INTEGER,
    patient_patientid  INTEGER NOT NULL,
    np_staff_staffid   INTEGER NOT NULL
);

ALTER TABLE lab_report ADD CONSTRAINT lab_report_pk PRIMARY KEY ( labid );

CREATE TABLE m_report (
    reportid             INTEGER NOT NULL,
    p_visit              INTEGER,
    surg_count           INTEGER,
    baby_cnt             INTEGER,
    lab_test             INTEGER,
    lab_type             CLOB,
    script_cnt           INTEGER,
    apt_length           VARCHAR2(5),
    m_statement_stateid  INTEGER NOT NULL,
    m_statement_patid    INTEGER NOT NULL
);

ALTER TABLE m_report ADD CONSTRAINT m_report_pk PRIMARY KEY ( reportid );

CREATE TABLE m_statement (
    stateid            INTEGER NOT NULL,
    patid              INTEGER NOT NULL,
    services           CLOB,
    pmnt_rec           INTEGER,
    unpaid_bal         INTEGER,
    patient_patientid  INTEGER NOT NULL
);

ALTER TABLE m_statement ADD CONSTRAINT m_statement_pk PRIMARY KEY ( stateid,
                                                                    patid );

CREATE TABLE master_sched (
    schedid    INTEGER NOT NULL,
    practid    INTEGER,
    apt        CLOB,
    apt_start  CHAR(5),
    apt_end    CHAR(5),
    walk_in    CLOB,
    p_name     VARCHAR2(15),
    week_day   CLOB
);

ALTER TABLE master_sched ADD CONSTRAINT master_sched_pk PRIMARY KEY ( schedid );

CREATE TABLE np_staff (
    staffid               INTEGER NOT NULL,
    staff_name            VARCHAR2(15),
    master_sched_schedid  INTEGER NOT NULL
);

ALTER TABLE np_staff ADD CONSTRAINT np_staff_pk PRIMARY KEY ( staffid );

CREATE TABLE or_sched (
    orid                 INTEGER NOT NULL,
    surg_date            VARCHAR2(8),
    surg_time            VARCHAR2(5),
    dlv_room_deliveryid  INTEGER NOT NULL,
    doctor_docid         INTEGER NOT NULL
);

ALTER TABLE or_sched ADD CONSTRAINT or_sched_pk PRIMARY KEY ( orid );

CREATE TABLE patient (
    patientid     INTEGER NOT NULL,
    patient_name  VARCHAR2(30)
);

ALTER TABLE patient ADD CONSTRAINT patient_pk PRIMARY KEY ( patientid );

CREATE TABLE pract_schedule (
    practid       INTEGER NOT NULL,
    visit_reason  CLOB,
    p_name        VARCHAR2(15),
    doctor_docid  INTEGER NOT NULL
);

ALTER TABLE pract_schedule ADD CONSTRAINT pract_schedule_pk PRIMARY KEY ( practid );

CREATE TABLE prescription (
    rx_id          INTEGER NOT NULL,
    doc_name       VARCHAR2(15),
    p_name         VARCHAR2(15),
    p_address      CLOB,
    rx_directions  CLOB,
    rx_name        VARCHAR2(20),
    rx_form        VARCHAR2(10),
    rx_strength    CLOB,
    rx_quantity    INTEGER,
    pharm_name     VARCHAR2(15),
    date_filled    VARCHAR2(8),
    rx_refills     INTEGER,
    rx_price       INTEGER,
    rx_coverage    INTEGER,
    remain_bal     INTEGER
);

ALTER TABLE prescription ADD CONSTRAINT prescription_pk PRIMARY KEY ( rx_id );

CREATE TABLE rec_room (
    recoveryid         INTEGER NOT NULL,
    p_name             VARCHAR2(15),
    practid            INTEGER,
    bedid              INTEGER,
    date_in            VARCHAR2(8),
    date_out           VARCHAR2(8),
    time_in            VARCHAR2(5),
    time_out           VARCHAR2(5),
    signature          CLOB,
    patient_patientid  INTEGER NOT NULL,
    doctor_docid       INTEGER NOT NULL
);

ALTER TABLE rec_room ADD CONSTRAINT rec_room_pk PRIMARY KEY ( recoveryid );

CREATE TABLE relation_21 (
    prescription_rx_id  INTEGER NOT NULL,
    doctor_docid        INTEGER NOT NULL
);

ALTER TABLE relation_21 ADD CONSTRAINT relation_21_pk PRIMARY KEY ( prescription_rx_id,
                                                                    doctor_docid );

ALTER TABLE doctor
    ADD CONSTRAINT doctor_master_sched_fk FOREIGN KEY ( master_sched_schedid )
        REFERENCES master_sched ( schedid );

ALTER TABLE er_staff
    ADD CONSTRAINT er_staff_master_sched_fk FOREIGN KEY ( master_sched_schedid )
        REFERENCES master_sched ( schedid );

ALTER TABLE insurance
    ADD CONSTRAINT insurance_patient_fk FOREIGN KEY ( patient_patientid )
        REFERENCES patient ( patientid );

ALTER TABLE lab_report
    ADD CONSTRAINT lab_report_np_staff_fk FOREIGN KEY ( np_staff_staffid )
        REFERENCES np_staff ( staffid );

ALTER TABLE lab_report
    ADD CONSTRAINT lab_report_patient_fk FOREIGN KEY ( patient_patientid )
        REFERENCES patient ( patientid );

ALTER TABLE m_report
    ADD CONSTRAINT m_report_m_statement_fk FOREIGN KEY ( m_statement_stateid,
                                                         m_statement_patid )
        REFERENCES m_statement ( stateid,
                                 patid );

ALTER TABLE m_statement
    ADD CONSTRAINT m_statement_patient_fk FOREIGN KEY ( patient_patientid )
        REFERENCES patient ( patientid );

ALTER TABLE np_staff
    ADD CONSTRAINT np_staff_master_sched_fk FOREIGN KEY ( master_sched_schedid )
        REFERENCES master_sched ( schedid );

ALTER TABLE or_sched
    ADD CONSTRAINT or_sched_dlv_room_fk FOREIGN KEY ( dlv_room_deliveryid )
        REFERENCES dlv_room ( deliveryid );

ALTER TABLE or_sched
    ADD CONSTRAINT or_sched_doctor_fk FOREIGN KEY ( doctor_docid )
        REFERENCES doctor ( docid );

ALTER TABLE pract_schedule
    ADD CONSTRAINT pract_schedule_doctor_fk FOREIGN KEY ( doctor_docid )
        REFERENCES doctor ( docid );

ALTER TABLE rec_room
    ADD CONSTRAINT rec_room_doctor_fk FOREIGN KEY ( doctor_docid )
        REFERENCES doctor ( docid );

ALTER TABLE rec_room
    ADD CONSTRAINT rec_room_patient_fk FOREIGN KEY ( patient_patientid )
        REFERENCES patient ( patientid );

ALTER TABLE relation_21
    ADD CONSTRAINT relation_21_doctor_fk FOREIGN KEY ( doctor_docid )
        REFERENCES doctor ( docid );

ALTER TABLE relation_21
    ADD CONSTRAINT relation_21_prescription_fk FOREIGN KEY ( prescription_rx_id )
        REFERENCES prescription ( rx_id );



-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             30
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
