CREATE TABLE IF NOT EXISTS alternate_registration_student
(
    id         BIGSERIAL NOT NULL,
    code       VARCHAR(255) NOT NULL,
    email      VARCHAR(255) NOT NULL,
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    PRIMARY KEY (id),
    CONSTRAINT alternate_registration_student_code_unique UNIQUE (code),
    CONSTRAINT alternate_registration_student_email_unique UNIQUE (email)
);

CREATE TABLE IF NOT EXISTS student_statistics
(
    id            BIGSERIAL NOT NULL,
    count         INTEGER,
    time_interval VARCHAR(255),
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS update_dates
(
    id            BIGSERIAL,
    last_update_date  DATE,
    last_update_month BYTEA,
    last_update_week  DATE,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS resumes
(
    id         BIGSERIAL,
    data       BYTEA,
    name      VARCHAR(255),
    student_id BIGINT,
    PRIMARY KEY (id),
    CONSTRAINT FK_RESUMES_STUDENT_ID
        FOREIGN KEY (student_id) REFERENCES students
);

CREATE TABLE IF NOT EXISTS certificates
(
    id         BIGSERIAL,
    data       BYTEA,
    name       VARCHAR(255),
    student_id BIGINT,
    PRIMARY KEY (id),
    CONSTRAINT FK_CERTIFICATES_STUDENT_ID
        FOREIGN KEY (student_id) REFERENCES students
);

CREATE TABLE IF NOT EXISTS event_counter
(
    id            BIGSERIAL,
    event_counter INTEGER DEFAULT 0 NOT NULL,
    primary key (id)
);


DROP TABLE IF EXISTS student_certificates;

DROP TABLE IF EXISTS student_certificates_filenames;

DROP TABLE IF EXISTS student_resume_filenames;

DROP TABLE IF EXISTS student_resumes;

ALTER TABLE students
    DROP COLUMN IF EXISTS city;

ALTER TABLE IF EXISTS events
    ALTER COLUMN date_of_event SET NOT NULL;

ALTER TABLE IF EXISTS events
    ADD end_date_of_event TIMESTAMP WITHOUT TIME ZONE;

ALTER TABLE universities
    ADD registration_date TIMESTAMP WITHOUT TIME ZONE;