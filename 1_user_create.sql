-- type entities -----------------------------------   run the inserts
create table user_type (
	userTypeId tinyint not null,
    userType varchar(9) not null,
    -- constraints
    primary key (userTypeId)
);
insert into user_type
select 1, 'executive' union
select 2, 'normal';

create table executive_type (
	executiveTypeId tinyint not null,
	executiveType varchar(7) not null,
    -- constraints
    primary key (executiveTypeId)
);
insert into executive_type
select 1, 'admin' union all
select 2, 'monitor';

create table normal_type (
	normalTypeId tinyint not null,
	normalType varchar(7) not null,
    -- constraints
    primary key (normalTypeId)
);
insert into normal_type
select 1, 'atRisk' union all
select 2, 'helper';

-- user entities abstract
create table user_entity (
	userId varchar(36) not null, -- type for uuid
    username varchar(20) not null,
    userPassword varchar(256) not null, -- encrypted : <algorithm>$<iterations>$<salt>$<hash>
    fullName varchar(50) not null,
    email varchar(320) not null,
    activeStatus bool not null,
    lastAccess date not null,
    creationDate date not null,
    lastUpdate datetime not null,
    userType tinyint not null,
    -- constraints
    primary key (userId),
    foreign key (userType) references user_type (userTypeId),
    unique(username),
    unique(email)
);

create table executive_user (
	userId varchar(36) not null,
    userType tinyint as (1) stored,
    executiveType tinyint not null,
    -- constraints
    primary key (userId),
    foreign key (userType) references user_entity (userType),
	foreign key (userId) references user_entity (userId),
    foreign key (executiveType) references executive_type (executiveTypeId)
);

create table normal_user (
	userId varchar(36) not null,
    userType tinyint as (2) stored,
    normalType tinyint not null,
    userDescription varchar(280),
    -- constraints
    primary key (userId),
	foreign key (userType) references user_entity (userType),
	foreign key (userId) references user_entity (userId),
    foreign key (normalType) references normal_type (normalTypeId)
);

-- user entities specialization
create table user_admin (
	userId varchar(36) not null,
    executiveType tinyint as (1) stored,
    -- constraints
    primary key (userId),
    foreign key (userId) references executive_user (userId),
    foreign key (executiveType) references executive_type (executiveTypeId)
);

create table monitor (
	userId varchar(36) not null,
	executiveType tinyint as (2) stored,
    -- constraints
    primary key (userId),
    foreign key (userId) references executive_user (userId),
    foreign key (executiveType) references executive_type (executiveTypeId)
);

create table at_risk (
	userId varchar(36) not null,
    normalType tinyint as (1) stored,
    -- constraints
    primary key (userId),
	foreign key (userId) references normal_user (userId),
    foreign key (normalType) references normal_type (normalTypeId)
);

create table helper (
	userId varchar(36) not null,
    normalType tinyint as (2) stored,
    -- constraints
    primary key (userId),
	foreign key (userId) references normal_user (userId),
    foreign key (normalType) references normal_type (normalTypeId)
);

-- associated to users

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

create table image(
	userId varchar(36) not null,
    title varchar(40),
    pic longblob not null,
    -- constraints
    primary key (userId),
    foreign key (userId) references user_entity (userId)
    
);

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

create table at_risks_favourite( -- at risk is choosing favourite
	atRiskId varchar(36) not null,
    helperId varchar(36) not null,
    dateSelected date,
    -- constraints
    primary key (atRiskId, helperId),
    foreign key (atRiskId) references at_risk (userId),
    foreign key (helperId) references helper (userId)
);

create table helpers_favourite( -- helper is choosing favourite
	helperId varchar(36) not null,
    atRiskId varchar(36) not null,
    dateSelected date,
    -- constraints
    primary key (helperId, atRiskId),
     foreign key (helperId) references helper (userId),
    foreign key (atRiskId) references at_risk (userId)   
);