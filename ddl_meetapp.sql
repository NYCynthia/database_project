CREATE TABLE Users (
 id BIGSERIAL NOT NULL,
 username VARCHAR(30) NOT NULL UNIQUE,
 password VARCHAR(128) NOT NULL,
 email VARCHAR(254) NOT NULL,
 first_name VARCHAR(30) NOT NULL,
 last_name VARCHAR(30) NOT NULL,
 phone VARCHAR(20),
 is_private BOOLEAN NOT NULL,
 is_active BOOLEAN NOT NULL
);


ALTER TABLE Users ADD CONSTRAINT Users_pkey PRIMARY KEY (id);

CREATE TABLE Clubs (
 id BIGSERIAL,
 name VARCHAR(100) NOT NULL UNIQUE,
 location VARCHAR(50) NOT NULL,
 description TEXT NOT NULL
);


ALTER TABLE Clubs ADD CONSTRAINT Clubs_pkey PRIMARY KEY (id);

CREATE TABLE ClubMembers (
 id BIGSERIAL,
 club_id INTEGER NOT NULL,
 user_id INTEGER NOT NULL,
 is_admin BOOLEAN NOT NULL
);


ALTER TABLE ClubMembers ADD CONSTRAINT ClubMembers_pkey PRIMARY KEY (id);

CREATE TABLE Events (
 id BIGSERIAL,
 name VARCHAR(30) NOT NULL,
 location VARCHAR(50) NOT NULL,
 description TEXT NOT NULL,
 start_datetime TIMESTAMP WITH TIME ZONE NOT NULL,
 end_datetime TIMESTAMP WITH TIME ZONE NOT NULL
);


ALTER TABLE Events ADD CONSTRAINT Events_pkey PRIMARY KEY (id);

CREATE TABLE InvitedClubs (
 id BIGSERIAL,
 event_id INTEGER NOT NULL,
 club_id INTEGER NOT NULL
);


ALTER TABLE InvitedClubs ADD CONSTRAINT InvitedClubs_pkey PRIMARY KEY (id);

CREATE TABLE Attendance (
 id BIGSERIAL,
 user_id INTEGER NOT NULL,
 event_id INTEGER NOT NULL,
 status INTEGER NOT NULL
);


ALTER TABLE Attendance ADD CONSTRAINT Attendance_pkey PRIMARY KEY (id);

CREATE TABLE Messages (
 id BIGSERIAL,
 sender_user_id INTEGER NOT NULL,
 receiver_event_id INTEGER,
 receiver_club_id INTEGER,
 receiver_user_id INTEGER,
 msg TEXT NOT NULL,
 timestamp TIMESTAMP WITH TIME ZONE NOT NULL
);


ALTER TABLE Messages ADD CONSTRAINT Messages_pkey PRIMARY KEY (id);

ALTER TABLE ClubMembers ADD CONSTRAINT ClubMembers_club_id_fkey FOREIGN KEY (club_id) REFERENCES Clubs(id);
ALTER TABLE ClubMembers ADD CONSTRAINT ClubMembers_user_id_fkey FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE InvitedClubs ADD CONSTRAINT InvitedClubs_event_id_fkey FOREIGN KEY (event_id) REFERENCES Events(id);
ALTER TABLE InvitedClubs ADD CONSTRAINT InvitedClubs_club_id_fkey FOREIGN KEY (club_id) REFERENCES Clubs(id);
ALTER TABLE Attendance ADD CONSTRAINT Attendance_user_id_fkey FOREIGN KEY (user_id) REFERENCES Users(id);
ALTER TABLE Attendance ADD CONSTRAINT Attendance_event_id_fkey FOREIGN KEY (event_id) REFERENCES Events(id);
ALTER TABLE Messages ADD CONSTRAINT Messages_sender_user_id_fkey FOREIGN KEY (sender_user_id) REFERENCES Users(id);
ALTER TABLE Messages ADD CONSTRAINT Messages_receiver_event_id_fkey FOREIGN KEY (receiver_event_id) REFERENCES Events(id);
ALTER TABLE Messages ADD CONSTRAINT Messages_receiver_club_id_fkey FOREIGN KEY (receiver_club_id) REFERENCES Clubs(id);
ALTER TABLE Messages ADD CONSTRAINT Messages_receiver_user_id_fkey FOREIGN KEY (receiver_user_id) REFERENCES Users(id);


CREATE VIEW ClubAndMemberView AS 
  SELECT 
    club_id,
    name AS club_name,
    user_id,
    username,
    first_name,
    last_name,
    email,
    phone,
    is_private,
    is_active,
    is_admin
  FROM 
    Clubs 
  JOIN 
    ClubMembers ON Clubs.id=club_id 
  JOIN 
    Users ON user_id=Users.id; 

CREATE VIEW ClubAndEventView AS 
  SELECT
    club_id,
    Clubs.name AS club_name,
    Events.id AS event_id,
    Events.name AS event_name,
    Events.location AS event_location,
    Events.description AS event_description,
    start_datetime,
    end_datetime
  FROM
    Clubs
  JOIN
    InvitedClubs ON Clubs.id=club_id
  JOIN
    Events ON event_id=Events.id;

CREATE OR REPLACE PROCEDURE CreateClub (
  IN session_user_id INTEGER, 
  IN new_name VARCHAR(100), 
  IN new_location VARCHAR(50), 
  IN new_description TEXT
)
AS $$
DECLARE
  is_admin boolean:=True;
  new_id INTEGER;
BEGIN
  INSERT INTO Clubs (name, location, description) VALUES (new_name, new_location, new_description);
  new_id:= (SELECT id FROM Clubs WHERE name=new_name);
  INSERT INTO Clubmembers (club_id, user_id, is_admin) VALUES (new_id, session_user_id, True);
END;
$$ LANGUAGE plpgsql; 


CREATE OR REPLACE FUNCTION enrollment (IN _club_id INTEGER) RETURNS INTEGER
AS $$
DECLARE
  n_members INTEGER;
BEGIN
  n_members:= (SELECT count(*) FROM ClubMembers WHERE club_id = _club_id);
  RETURN n_members;
END;
$$ LANGUAGE plpgsql;
