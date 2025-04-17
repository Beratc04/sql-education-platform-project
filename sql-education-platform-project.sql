-- Members Tablosu
CREATE TABLE Members (
    member_id BIGSERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Categories Tablosu
CREATE TABLE Categories (
    category_id SMALLSERIAL PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);

-- Courses Tablosu
CREATE TABLE Courses (
    course_id BIGSERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    instructor VARCHAR(100) NOT NULL,
    category_id SMALLINT REFERENCES Categories(category_id) ON DELETE CASCADE
);

-- Enrollments Tablosu
CREATE TABLE Enrollments (
    enrollment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT REFERENCES Members(member_id) ON DELETE CASCADE,
    course_id BIGINT REFERENCES Courses(course_id) ON DELETE CASCADE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(member_id, course_id) -- Aynı kullanıcı aynı kursa tekrar kaydolamasın
);

-- Certificates Tablosu
CREATE TABLE Certificates (
    certificate_id BIGSERIAL PRIMARY KEY,
    certificate_code VARCHAR(100) UNIQUE NOT NULL,
    issue_date DATE DEFAULT CURRENT_DATE
);

-- CertificateAssignments Tablosu
CREATE TABLE CertificateAssignments (
    assignment_id BIGSERIAL PRIMARY KEY,
    member_id BIGINT REFERENCES Members(member_id) ON DELETE CASCADE,
    certificate_id BIGINT REFERENCES Certificates(certificate_id) ON DELETE CASCADE,
    assignment_date DATE DEFAULT CURRENT_DATE,
    UNIQUE(member_id, certificate_id) -- Aynı sertifika tekrar atanamamalı
);

-- BlogPosts Tablosu
CREATE TABLE BlogPosts (
    post_id BIGSERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    post_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    author_id BIGINT REFERENCES Members(member_id) ON DELETE CASCADE
);