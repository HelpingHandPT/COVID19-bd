-- type entities -----------------------------------   run the inserts
create table pdf_type(
	pdfTypeId tinyint not null,
    pdfType varchar(15) not null,
    -- constraints
    primary key (pdfTypeId)
);
insert into pdf_type
select 1, 'addressProof' union all
select 2, 'credentialProof' union all
select 3, 'paymentProof';


-- abstract pdf
create table pdf (
	pdfId varchar(36) not null,
    uploadTime datetime not null,
    title varchar(30) not null,
    pdfFile varchar(256), -- TODO choose if we want path or actual file
    pdfType tinyint not null,
    -- constraints
    primary key (pdfId),
	foreign key (pdfType) references pdf_type (pdfTypeId)
);

-- pdf entities specialization
create table address_proof (
	pdfId varchar(36) not null,
    pdfType tinyint as (1) stored,
    addressId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
	foreign key (pdfId) references pdf (pdfId),
	foreign key (pdfType) references pdf (pdfType),
    foreign key (addressId) references address (addressId)
);

create table credential_proof ( -- abstract
	pdfId varchar(36) not null,
    pdfType tinyint as (2) stored,
    credentialId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
    foreign key (pdfId) references pdf (pdfId),
	foreign key (pdfType) references pdf (pdfType),
    foreign key (credentialId) references credential (credentialId)
);

create table payment_proof ( -- abstract
	pdfId varchar(36) not null,
    pdfType tinyint as (3) stored,
    paymentId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
	foreign key (pdfId) references pdf (pdfId),
	foreign key (pdfType) references pdf (pdfType),
    foreign key (paymentId) references payment (paymentID)
);
