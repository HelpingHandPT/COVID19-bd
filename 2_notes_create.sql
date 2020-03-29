-- classes associated with notes
create table user_log (
	logId varchar(36) not null,
    ip varchar(15), -- xxx.xxx.xxx.xxx format, 12+3 separators
    hostName varchar(20),
    isp varchar(20),
    district varchar(30),
    city varchar(50),
    zipCode mediumint unsigned, 
    lat dec(7,6),
    lng dec(9,6),
    logDate datetime,
    userId varchar(36) not null,
    -- constraints
    primary key (logId),
    foreign key (userId) references user_entity (userId),
    constraint valid_lat check (lat >= -90 and lat <= 90),
    constraint valid_lng check (lng >= -180 and lng <=180),
    constraint valid_zip check (zipCode < 10000000)
);

create table health_log (
	patientId varchar(36) not null,
    monitorId varchar(36) not null,
    -- constraints
    primary key (patientId),
    foreign key (patientId) references user_entity (userId),
    foreign key (monitorId) references monitor (userId)
);

-- type entities -----------------------------------   run the inserts
create table note_type(
	noteTypeId tinyint not null,
    noteType varchar(9) not null,
    -- constraints
    primary key (noteTypeId)
);
insert into note_type
select 1, 'healthLog' union all
select 2, 'log' union all
select 3, 'user';

-- note abstract
create table note (
	noteId varchar(36) not null,
	authorId varchar(36) not null,
    creationDate date not null,
    lastUpdate datetime not null,
    title varchar(30) not null,
    content varchar(400),
    noteType tinyint not null,
    -- constraints
    primary key (noteId),
    foreign key (authorId) references user_entity (userId),
    foreign key (noteType) references note_type (noteTypeId)
);

-- note entities specialization
create table health_log_note (
	healthLogNoteId varchar(36) not null,
    noteType tinyint as (1) stored,
    healthLogId varchar(36) not null,
    -- constraints
    primary key (healthLogNoteId),
    foreign key (healthLogNoteId) references note (noteId),
    foreign key (noteType) references note (noteType),
    foreign key (healthLogId) references health_log (patientId)
);

create table log_note (
	logNoteId varchar(36) not null,
    noteType tinyint as (2) stored,
    logId varchar(36) not null,
    -- constraints
    primary key (logNoteId),
    foreign key (logNoteId) references note (noteId),
    foreign key (noteType) references note (noteType),
    foreign key (logId) references user_log (logId)
);

create table user_note (
	userNoteId varchar(36) not null,
    noteType tinyint as (3) stored,
    userId varchar(36) not null,
    -- constraints
    primary key (userNoteId),
    foreign key (userNoteId) references note (noteId),
    foreign key (noteType) references note (noteType),
    foreign key (userId) references user_entity (userId)
);


