create table pdf ( -- abstract
	pdfId varchar(36) not null,
    uploadTime datetime not null,
    title varchar(30) not null,
    pdfFile varchar(400), -- TODO choose if we want path or actual file
    pdfType enum('addressProof','credentialProof','paymentProof') not null,
    -- constraints
    primary key (pdfId)
);
drop table pdf;

create table credential_proof ( -- abstract
	pdfId varchar(36) not null,
    pdfType enum('credentialProof') not null,
    credentialId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
    foreign key (pdfId, pdfType) references pdf (pdfId, pdfType),
    foreign key (credentialId) references credential (credentialId)
);
drop table credential_proof;

create table address_proof ( -- abstract
	pdfId varchar(36) not null,
    pdfType enum('addressProof') not null,
    addressId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
    foreign key (pdfId, pdfType) references pdf (pdfId, pdfType),
    foreign key (addressId) references address (addressId)
);
drop table address_proof;

create table payment_proof ( -- abstract
	pdfId varchar(36) not null,
    pdfType enum('addressProof') not null,
    paymentId  varchar(36) not null,
    -- constraints
    primary key (pdfId),
    foreign key (pdfId, pdfType) references pdf (pdfId, pdfType),
    foreign key (paymentId) references payment (paymentID)
);
drop table payment_proof;
