CREATE SCHEMA Workshop_4;
Use workshop_4;
Create table if not exists video (
	id_videos INT auto_increment primary key,
    name VARCHAR(100) NOT NULL,
    description varchar(200), 
    date_upload INT DEFAULT 0,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    user_fk binary(16) DEFAULT (UUID_TO_BIN(UUID())), 
    genre_fk INT,
    channel_fk INT,
    foreign key (user_fk) references users (id_number),
    foreign key (genre_fk) references musicalGenre (id_genre),
    foreign key (channel_fk) references channels (id_channel)    
);

Create table if not exists comments (
	id_comment INT auto_increment primary key,
    content VARCHAR(300) NOT NULL,
    date_creation INT NOT NULL,
    likes INT DEFAULT 0,
    dislikes INT DEFAULT 0,
    user_fk binary(16) DEFAULT (UUID_TO_BIN(UUID())),
    video_fk INT,
    foreign key (user_fk) references users (id_number),
    foreign key (video_fk) references video (id_videos)
);

Create table if not exists playlist (
	id_playlist INT auto_increment primary key,
    name VARCHAR(30) NOT NULL,
    likes INT DEFAULT 0,
    user_fk BINARY(16) DEFAULT (UUID_TO_BIN(UUID())),
    foreign key (user_fk) references users (id_number)
);

Create table if not exists users (
	id_number BINARY(16) primary key DEFAULT (UUID_TO_BIN(UUID())),
	name VARCHAR(50) NOT NULL,
    email VARCHAR(30) UNIQUE,
    phone VARCHAR(50),
    nickname VARCHAR(20) UNIQUE NOT NULL,
    password VARCHAR(30) NOT NULL,
    musical_genre_fk INT NOT NULL,
    country_fk INT NOT NULL,
    foreign key (musical_genre_fk) references musicalGenre (id_genre),
	foreign key (country_fk) references country (id_code)
);

Create table if not exists community (
	id_community INT auto_increment primary key,
    name VARCHAR(25) UNIQUE NOT NULL,
    description VARCHAR(200)
);

Create table if not exists channels (
	id_channel INT auto_increment primary key,
    name VARCHAR(30) NOT NULL,
    description VARCHAR(200),
    user_fk BINARY(16) DEFAULT (UUID_TO_BIN(UUID())),
    foreign key (user_fk) references users (id_number)
);

Create table if not exists musicalGenre (
	id_genre INT auto_increment primary key,
    name VARCHAR(15) NOT NULL,
    description VARCHAR(100)
);

Create table if not exists bankAccount (
	id_bank BINARY(16) primary key DEFAULT (UUID_TO_BIN(UUID())),
    bank_name VARCHAR(30),
    account_number INT UNIQUE,
    country_fk int,
    user_fk binary(16) DEFAULT (UUID_TO_BIN(UUID())),
    foreign key (user_fk) references users (id_number),
    foreign key (country_fk) references country (id_code)
);

Create table if not exists country (
	id_code INT auto_increment primary key,
    name VARCHAR(25) UNIQUE NOT NULL
);

Create table if not exists playlist_video_rel (
	id_playlist_video SERIAL primary key, 
	playlist_fk INT, 
    video_fk INT ,    
	foreign key (playlist_fk) references playlist (id_playlist),
	foreign key (video_fk) references video (id_videos),
    UNIQUE (playlist_fk, video_fk)
);

Create table if not exists subscriber_rel (
	user_fk  BINARY(16) primary key DEFAULT (UUID_TO_BIN(UUID())),
    channel_fk INT PRIMARY KEY, 
    pay BOOL DEFAULT false,
    pay_cost FLOAT,
    date_subscriptions INT NOT NULL,
	foreign key (user_fk) references users (id_number),
	foreign key (channel_fk) references channels (id_channel)
);

Create table if not exists community_user_rel (
	community_fk INT PRIMARY KEY, 
	user_fk BINARY(16) primary key DEFAULT (UUID_TO_BIN(UUID())),    
    foreign key (user_fk) references users (id_number),
	foreign key (community_fk) references community (id_community)
);


