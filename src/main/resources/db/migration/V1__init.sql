CREATE TABLE IF NOT EXISTS complaints
(
    id             BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    student_id     BIGINT,
    comment_id     BIGINT,
    event_id       BIGINT,
    vacancy_id     BIGINT,
    status         VARCHAR(255),
    complaint_text VARCHAR,
    type           VARCHAR(255),
    CONSTRAINT pk_complaints PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS event_comments
(
    id           BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    comment_text VARCHAR(255)                            NOT NULL,
    event_id     BIGINT                                  NOT NULL,
    student_id   BIGINT,
    CONSTRAINT pk_event_comments PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS events
(
    event_id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    date_of_event    TIMESTAMP WITHOUT TIME ZONE                            NOT NULL,
    venue            VARCHAR                            NOT NULL,
    description      VARCHAR                            NOT NULL,
    name_of_event    VARCHAR                            NOT NULL,
    event_type       VARCHAR(255),
    event_photo      BYTEA                                   NOT NULL,
    favorite_count   INTEGER,
    date_of_creation TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT pk_events PRIMARY KEY (event_id)
);

CREATE TABLE IF NOT EXISTS favourite_events
(
    id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    student_id BIGINT                                  NOT NULL,
    event_id   BIGINT,
    CONSTRAINT pk_favourite_events PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS messages
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    message_content VARCHAR(255),
    time_sent       TIMESTAMP WITHOUT TIME ZONE,
    student_id      BIGINT,
    CONSTRAINT pk_messages PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS replies
(
    id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    reply_text VARCHAR(255)                            NOT NULL,
    comment_id BIGINT,
    student_id BIGINT,
    CONSTRAINT pk_replies PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS saved_vacancies
(
    id         BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    student_id BIGINT                                  NOT NULL,
    vacancy_id BIGINT,
    CONSTRAINT pk_saved_vacancies PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS student_certificates
(
    student_id           BIGINT NOT NULL,
    student_certificates BYTEA
);

CREATE TABLE IF NOT EXISTS student_certificates_filenames
(
    student_id                     BIGINT NOT NULL,
    student_certificates_filenames VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS student_resume_filenames
(
    student_id               BIGINT NOT NULL,
    student_resume_filenames VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS student_resumes
(
    student_id      BIGINT NOT NULL,
    student_resumes BYTEA
);

CREATE TABLE IF NOT EXISTS students
(
    id               BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    last_name        VARCHAR(255),
    first_name       VARCHAR(255),
    birth_date       VARCHAR(255),
    major            VARCHAR(255),
    course           VARCHAR(255),
    student_photo    BYTEA,
    email            VARCHAR(255),
    password         VARCHAR(255),
    enabled          BOOLEAN                                 NOT NULL,
    has_new_messages BOOLEAN,
    university_id    BIGINT,
    role             VARCHAR(255)                            NOT NULL,
    CONSTRAINT pk_students PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS universities
(
    id     BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    name   VARCHAR(255)                            NOT NULL,
    domain VARCHAR(255)                            NOT NULL,
    CONSTRAINT pk_universities PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS vacancies
(
    vacancy_id      BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    description     VARCHAR(255)                            NOT NULL,
    name_of_vacancy VARCHAR(255)                            NOT NULL,
    CONSTRAINT pk_vacancies PRIMARY KEY (vacancy_id)
);

CREATE TABLE IF NOT EXISTS verification_codes
(
    id              BIGINT GENERATED BY DEFAULT AS IDENTITY NOT NULL,
    code            INTEGER                                 NOT NULL,
    student_id      BIGINT,
    student_email   VARCHAR(255),
    expiration_date TIMESTAMP WITHOUT TIME ZONE,
    last_sent_time  TIMESTAMP WITHOUT TIME ZONE,
    CONSTRAINT pk_verification_codes PRIMARY KEY (id)
);

ALTER TABLE students
    ADD CONSTRAINT uc_students_email UNIQUE (email);

ALTER TABLE event_comments
    ADD CONSTRAINT FK_EVENT_COMMENTS_ON_STUDENT FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE favourite_events
    ADD CONSTRAINT FK_FAVOURITE_EVENTS_ON_EVENT FOREIGN KEY (event_id) REFERENCES events (event_id);

ALTER TABLE messages
    ADD CONSTRAINT FK_MESSAGES_ON_STUDENT FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE replies
    ADD CONSTRAINT FK_REPLIES_ON_COMMENT FOREIGN KEY (comment_id) REFERENCES event_comments (id);

ALTER TABLE replies
    ADD CONSTRAINT FK_REPLIES_ON_STUDENT FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE saved_vacancies
    ADD CONSTRAINT FK_SAVED_VACANCIES_ON_VACANCY FOREIGN KEY (vacancy_id) REFERENCES vacancies (vacancy_id);

ALTER TABLE students
    ADD CONSTRAINT FK_STUDENTS_ON_UNIVERSITY FOREIGN KEY (university_id) REFERENCES universities (id);

ALTER TABLE student_certificates
    ADD CONSTRAINT fk_student_certificates_on_student FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE student_certificates_filenames
    ADD CONSTRAINT fk_student_certificatesfilenames_on_student FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE student_resume_filenames
    ADD CONSTRAINT fk_student_resumefilenames_on_student FOREIGN KEY (student_id) REFERENCES students (id);

ALTER TABLE student_resumes
    ADD CONSTRAINT fk_student_resumes_on_student FOREIGN KEY (student_id) REFERENCES students (id);