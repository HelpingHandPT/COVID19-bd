-- notes
create table note ( -- abstract
	noteId varchar(20) not null,
	authorId varchar(20) not null,
    creationDate date,
    lastUpdate datetime,
    title varchar(30),
    content varchar(400),
    noteType enum('healthLog','log','user') not null,
    -- constraints
    primary key (noteId),
    foreign key (authorId) references user_entity(userId)
);
drop table note;

create table note_log (
	logNoteId varchar(20) not null,
    noteType enum('log') not null,
    logId varchar(20) not null,
    -- constraints
    primary key (logNoteId),
    foreign key (logNoteId, noteType) references note (noteId, noteType),
    foreign key (logId) references user_log (logId)
);
drop table note_log;

create table note_health_log (
	healthLogNoteId varchar(20) not null,
    noteType enum('healthLog') not null,
    healthLogId varchar(20) not null,
    -- constraints
    primary key (healthLogNoteId),
    foreign key (healthLogNoteId, noteType) references note (noteId, noteType),
    foreign key (healthLogId) references health_log (patientId)
);
drop table note_health_log;

create table note_user (
	userNoteId varchar(20) not null,
    noteType enum('user') not null,
    userId varchar(20) not null,
    -- constraints
    primary key (userNoteId),
    foreign key (userNoteId, noteType) references note (noteId, noteType),
    foreign key (userId) references user_entity (userId)
);
drop table note_user;

-- classes associated with notes

create table user_log (
	logId varchar(20) not null,
    ip varchar(15), -- xxx.xxx.xxx.xxx format, 12+3 separators
    hostName varchar(20),
    isp varchar(20),
    district varchar(30),
    city varchar(50),
    zipCode mediumint unsigned, 
    lat dec(7,6),
    lng dec(9,6),
    logDate datetime,
    -- constraints
    primary key (logId),
    constraint valid_lat check (lat >= -90 and lat <= 90),
    constraint valid_lng check (lng >= -180 and lng <=180),
    constraint valid_zip check (zipCode < 10000000)
);
drop table user_log;

create table health_log (
	patientId varchar(20) not null,
    monitorId varchar(20) not null,
    -- constraints
    primary key (patientId),
    foreign key (patientId) references user_entity (userId)
);