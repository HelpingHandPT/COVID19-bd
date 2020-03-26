create table user_entity (
	userId varchar(36) not null, -- type for uuid
    username varchar(20) not null,
    passwordHash varchar(30) not null, -- encrypted  TODO
    salt varchar(30) not null, -- TODO
    fullName varchar(50) not null,
    email varchar(320) not null,
    activeStatus bool not null,
    lastAccess date not null,
    creationDate date not null,
    lastUpdate datetime not null,
    userType enum('executive', 'normal') not null,
    -- constraints
    primary key (userId),
    unique(username),
    unique(email)
);
drop table user_entity;

create table social_media (
	userId varchar(36) not null,
    facebook varchar(50), 
    linkedIn varchar(61),
    instagram varchar (30),
    reddit varchar(20),
    skype varchar(32),
    twitter varchar(15),
    lastUpdate datetime,
	-- constraints
    primary key (userId),
    foreign key (userId) references user_entity (userId)
);
drop table social_media;

create table image(
	userId varchar(36) not null,
    title varchar(40),
    pic longblob not null,
    -- constraints
    primary key (userId),
    foreign key (userId) references user_entity (userId)
    
);
drop table iamge;

create table user_admin (
	userId varchar(36) not null,
    userType enum('executive') not null,
    -- constraints
    primary key (userId),
    foreign key (userId, userType) references user_entity (userId, userType)
);
drop table user_admin;

create table monitor (
	userId varchar(36) not null,
    userType enum('executive') not null,
    -- constraints
    primary key (userId),
    foreign key (userId, userType) references user_entity (userId, userType)
);
drop table monitor;

create table normal_user (
	userId varchar(36) not null,
    userType enum('normal') not null,
    normalType enum('atRisk','helper') not null,
    userDescription varchar(280),
    -- constraints
    primary key (userId),
    foreign key (userId, userType) references user_entity (userId, userType)
);
drop table normal_user;

create table at_risk (
	userId varchar(36) not null,
    normalType enum('atRisk') not null,
    -- constraints
    primary key (userId),
    foreign key (userId, normalType) references normal_user (userId, normalType)
);
drop table at_risk;

create table helper (
	userId varchar(36) not null,
    normalType enum('helper') not null,
    -- constraints
    primary key (userId),
    foreign key (userId, normalType) references normal_user (userId, normalType)
);
drop table helper;

-- associated to users

create table address(
	addressId varchar(36) not null,
    address varchar(100) not null,
	city varchar(50),
    district varchar(30),
    zipCode mediumint unsigned, 
    lastUpdate datetime not null,
    verified bool not null,
    userId varchar(36) not null,
    -- constraints
    primary key (addressId),
    foreign key (userId) references user_entity (userId)
);
drop table address;

create table ad(
	adId varchar(36) not null,
    title varchar(30) not null,
    content varchar(280),
    creationDate date not null,
    lastUpdate datetime not null,
    helperId varchar(36) not null,
    -- constraints
    primary key (adId),
    foreign key (helperId) references helper (userId)
);
drop table ad;

create table credential(
	credentialId varchar(36) not null,
    title varchar(30) not null,
    dateObtained date not null,
    expirationDate date,
    institution varchar(50) not null,
    verified bool not null,
    -- constraints
    primary key (credentialId)
);
drop table credential;

create table at_risks_favourite( -- at risk is choosing favourite
	atRiskId varchar(36) not null,
    helperId varchar(36) not null,
    dateSelected date,
    -- constraints
    primary key (atRiskId, helperId),
    foreign key (atRiskId) references at_risk (userId),
    foreign key (helperId) references helper (userId)
);
drop table at_risks_favourite;

create table helpers_favourite( -- helper is choosing favourite
	helperId varchar(36) not null,
    atRiskId varchar(36) not null,
    dateSelected date,
    -- constraints
    primary key (helperId, atRiskId),
     foreign key (helperId) references helper (userId),
    foreign key (atRiskId) references at_risk (userId)   
);
drop table helpers_favourite;