create table request (
	requestId varchar(36) not null,
    dateCreated date not null,
    periodicity tinyint unsigned, -- default null, indicates request should be repeated every x days 
    title varchar(30) not null,
    requestDescription varchar(280),
    expirationDate date,
    done bool,
    atRiskId varchar(36) not null,
    helperId varchar(36), -- null until a helper accepts it
    -- constraints
    primary key (requestId),
    constraint validPeriodicity check (periodicity > 0 and periodicity <=7),
    foreign key (atRiskId) references at_risk (userId),
    foreign key (helperId) references helper (userId)
);

create table review ( -- TODO constraint to check reviewerId and reviewedId are valid
	reviewId varchar(36) not null,
    reviewingId varchar(36) not null, -- user writting the review
    reviewedId varchar(36) not null, -- user being reviewed
    reviewDescription varchar(280),
    rating tinyint unsigned, 
    lastUpdate datetime,
    requestId varchar(36) not null,
    -- constraints
    primary key (reviewId),
    foreign key (requestId) references request (requestId),
    constraint validRating check (rating <= 10)
);

create table payment (
	paymentId varchar(36) not null,
    paymentValue decimal(6,2) unsigned not null, -- safe to assume value wont excede 9999 euros?
    paymentDateTime datetime not null,
    method enum('PayPal','Card') not null, 
    originIBAN varchar(25) not null,
    destinationIBAN varchar(25) not null,
    approved bool not null,
    subsidised bool not null,
    requestId varchar(36) not null,
    -- constraints
    primary key (paymentId),
    foreign key (requestId) references request (requestId)
);