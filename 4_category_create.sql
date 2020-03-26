create table category (
	categoryId varchar(36) not null,
    title varchar(30) not null,
    categoryDescription varchar(280),
    -- constraints
    primary key (categoryId)
);
drop table category;

create table sub_category (
	subCategoryId varchar(36) not null,
    title varchar(30) not null,
    subCategoryDescription varchar(280),
    categoryId varchar(36) not null,
    -- constraints
    primary key (subCategoryId),
    foreign key (categoryId) references category (categoryId)
);
drop table sub_category;

-- junction tables
create table at_risk_category (
	userId varchar(36) not null,
    subCategoryId varchar(36) not null,
    -- constraints
    primary key (userId, subCategoryId),
    foreign key (userId) references at_risk (userId),
    foreign key (subCategoryId) references sub_category (subCategoryId)
);
drop table at_risk_category;

create table helper_category (
	userId varchar(36) not null,
    subCategoryId varchar(36) not null,
    -- constraints
    primary key (userId, subCategoryId),
    foreign key (userId) references helper (userId),
    foreign key (subCategoryId) references sub_category (subCategoryId)
);
drop table helper_category;

create table request_category (
	requestId varchar(36) not null,
    subCategoryId varchar(36) not null,
    -- constraints
    primary key (requestId, subCategoryId),
    foreign key (requestId) references request (requestId),
    foreign key (subCategoryId) references sub_category (subCategoryId)
);
drop table request_category;

create table ad_category (
	adId varchar(36) not null,
    subCategoryId varchar(36) not null,
    -- constraints
    primary key (adId, subCategoryId),
    foreign key (adId) references ad (adId),
    foreign key (subCategoryId) references sub_category (subCategoryId)
);
drop table ad_category;