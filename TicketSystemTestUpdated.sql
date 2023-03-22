create proc createAllTables as
    create table systemUser(
    username varchar(20) not null primary key,
    password varchar(20) not null
    );

    create table systemAdmin(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    username varchar(20) not null foreign key references systemUser(username) on delete cascade on update cascade,
    password varchar(20) not null
    );

    create table sportsAssosiactionManager(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    username varchar(20) not null foreign key references systemUser(username) on delete cascade on update cascade,
    password varchar(20) not null
    );

    create table fan(
    birthDate date not null,
    status bit not null,
    address varchar(20) not null,
    name varchar(20) not null,
    phoneNumber int not null,
    nationalID int not null primary key,
    username varchar(20) not null foreign key references systemUser(username) on delete cascade on update cascade,
    password varchar(20) not null
    );

    create table club(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    location varchar(20) not null
    );

    create table clubRepresentative(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    username varchar(20) not null foreign key references systemUser(username) on delete cascade on update cascade,
    password varchar(20) not null,
    clubID int not null foreign key references club(id) on delete cascade on update cascade
    );

    create table stadium(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    status bit not null,
    capacity int not null,
    location varchar(20) not null
    );

    create table stadiumManager(
    id int not null primary key identity(1,1),
    name varchar(20) not null,
    username varchar(20) not null foreign key references systemUser(username) on delete cascade on update cascade,
    password varchar(20) not null,
    stadiumID int not null foreign key references stadium(id) on delete cascade on update cascade
    );

    create table match(
    id int not null primary key identity(1,1),
    startTime datetime not null,
    endTime datetime not null,
    hostClubID int not null foreign key references club(id) on delete cascade on update cascade,
    guestClubID int not null foreign key references club(id),
    stadiumID int foreign key references stadium(id)
    );
    
    create table hostRequest(
    id int not null primary key identity(1,1),
    status varchar(20) not null,
    matchID int not null foreign key references match(id) on delete cascade on update cascade,
    managerID int not null foreign key references stadiumManager(id) on delete cascade on update cascade,
    representativeID int not null foreign key references clubRepresentative(id) on delete no action on update no action,
    constraint checkstatus check (status = 'unhandled' or status = 'accepted' or status = 'rejected')
    );

    create table ticket(
    id int not null primary key identity(1,1),
    status bit not null,
    matchID int not null foreign key references match(id) on delete cascade on update cascade
    );

    create table ticketBuyingTransactions(
    fanNationalID int not null foreign key references fan(nationalID) on delete cascade on update cascade,
    ticketID int not null foreign key references ticket(id) on delete cascade on update cascade
    );
go

create proc dropAllTables as
    drop table ticketBuyingTransactions;
    drop table ticket;
    drop table hostRequest;
    drop table match;
    drop table stadiumManager;
    drop table stadium;
    drop table clubRepresentative;
    drop table club;
    drop table fan;
    drop table sportsAssosiactionManager;
    drop table systemAdmin;
    drop table systemUser;
go

create proc clearAllTables as
    delete from ticketBuyingTransactions;
    delete from ticket;
    delete from hostRequest;
    delete from match;
    delete from stadiumManager;
    delete from stadium;
    delete from clubRepresentative;
    delete from club;
    delete from fan;
    delete from sportsAssosiactionManager;
    delete from systemAdmin;
    delete from systemUser;
go

create proc dropAllProceduresFunctionsViews as
    drop proc createAllTables;
    drop proc dropAllTables;
    drop proc clearAllTables;

    drop procedure addAssociationManager;
    drop procedure addNewMatch;
    drop procedure deleteMatch;
    drop procedure deleteMatchesOnStadium;
    drop procedure addClub;
    drop procedure addTicket;
    drop procedure deleteClub;
    drop procedure addStadium;
    drop procedure deleteStadium;
    drop procedure blockFan;
    drop procedure unblockFan;
    drop procedure addRepresentative;
    drop procedure addHostRequest;
    drop procedure addStadiumManager;
    drop procedure allPendingRequests;
    drop procedure acceptRequest;
    drop procedure rejectRequest;
    drop procedure addFan;
    drop procedure purchaseTicket;
    drop procedure updateMatchHost;

    drop view allAssocManagers;
    drop view allClubRepresentatives;
    drop view allStadiumManagers;
    drop view allFans;
    drop view AllMatches;
    drop view allTickets;
    drop view allClubs;
    drop view allStadiums;
    drop view allRequests;
    drop view clubsWithNoMatches;
    drop view matchesPerTeam;
    drop view clubsNeverMatched;

    drop function viewAvailableStadiumsOn;
    drop function allUnassignedMatches;
    drop function upcomingMatchesOfClub;
    drop function availableMatchesToAttend;
    drop function clubsNeverPlayed;
    drop function matchWithHighestAttendance;
    drop function matchesRankedByAttendance;
    drop function requestsFromClub;
go



create view allAssocManagers as
    select username, password, name from sportsAssosiactionManager;
go

create view allClubRepresentatives as
    select username, password, clubRepresentative.name as ClubRepName, club.name as ClubName from clubRepresentative inner join club on clubRepresentative.clubID = club.id;
go

create view allStadiumManagers as
    select username, password, stadiumManager.name as StadiumManagerName, stadium.name as StadiumName from stadiumManager inner join stadium on stadiumManager.stadiumID = stadium.id;
go

create view allFans as
    select username, password, name, nationalID, birthDate, status from fan;
go

create view allMatches as
    select hostClub.name as HostClubName, guestClub.name as GuestClubName, match.startTime from match inner join club as hostClub on match.hostClubID = hostClub.id inner join club as guestClub on match.guestClubID = guestClub.id;
go

create view allTickets as
    select hostClub.name as HostClubName, guestClub.name as GuestClubName, stadium.name as StadiumName, match.startTime from ticket inner join match on ticket.matchID = match.id inner join stadium on match.stadiumID = stadium.id inner join club as hostClub on match.hostClubID = hostClub.id inner join club as guestClub on match.guestClubID = guestClub.id;
go

create view allCLubs as
    select name, location from club;
go

create view allStadiums as
    select name, location, capacity, status from stadium;
go

create view allRequests as 
    select clubRepresentative.username as ClubRepUsername, stadiumManager.username as StadiumManagerUsername, hostRequest.status from hostRequest inner join stadiumManager on hostRequest.managerID = stadiumManager.id inner join clubRepresentative on hostRequest.representativeID = clubRepresentative.id;
go



go
create procedure addAssociationManager(@name varchar(20), @username varchar(20), @password varchar(20)) as begin
    insert into systemUser (username, password) values (@username, @password);
    insert into sportsAssosiactionManager (name, username, password) values (@name, @username, @password);
end
go

go
create procedure addNewMatch( @hostClubName varchar(20), @guestClubName varchar(20), @startTime datetime, @endTime datetime ) as begin
    declare @hostClubID int, @guestClubID int

    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName

    insert into match (startTime, endTime, hostClubID, guestClubID, stadiumID) values (@startTime, @endTime, @hostClubID, @guestClubID, NULL)
end
go

create view clubsWithNoMatches as
    select club.name from club where club.id not in (select hostClubID from match) and club.id not in (select guestClubID from match)
go

go
create procedure deleteMatch( @hostClubName varchar(20), @guestClubName varchar(20) ) as begin
    declare @hostClubID int, @guestClubID int

    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName

    delete from hostRequest where matchID in (select id from match where hostClubID = @hostClubID and guestClubID = @guestClubID)
    delete from ticketBuyingTransactions where ticketID in (select id from ticket where matchID in (select id from match where hostClubID = @hostClubID and guestClubID = @guestClubID))
    delete from ticket where matchID in (select id from match where hostClubID = @hostClubID and guestClubID = @guestClubID)
    delete from match where hostClubID = @hostClubID and guestClubID = @guestClubID
end
go

go
create procedure deleteMatchesOnStadium(@stadiumName varchar(20)) as begin
    declare @stadiumID int

    select @stadiumID = id from stadium where name = @stadiumName

    delete from hostRequest where matchID in (select id from match where stadiumID = @stadiumID)
    delete from ticketBuyingTransactions where ticketID in (select id from ticket where matchID in (select id from match where stadiumID = @stadiumID))
    delete from ticket where matchID in (select id from match where stadiumID = @stadiumID)
    delete from match where stadiumID = @stadiumID
end
go

go
create procedure addClub(@name varchar(20), @location varchar(20)) as begin
    insert into club (name, location) values (@name, @location)
end
go

go
create procedure addTicket(@hostClubName varchar(20), @guestClubName varchar(20), @time datetime) as begin
    declare @matchID int
    declare @hostClubID varchar(20)
    declare @guestClubID varchar(20)

    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName
    select @matchID = id from match where hostClubID = @hostClubID and guestClubID = @guestClubID and startTime = @time

    insert into ticket (status, matchID) values (1, @matchID)
end
go

go
create procedure deleteClub( @clubName varchar(20) ) as begin
    declare @clubID int

    select @clubID = id from club where name = @clubName

    delete from hostRequest where matchID in (select id from match where hostClubID = @clubID or guestClubID = @clubID)
    delete from ticketBuyingTransactions where ticketID in (select id from ticket where matchID in (select id from match where hostClubID = @clubID or guestClubID = @clubID))
    delete from ticket where matchID in (select id from match where hostClubID = @clubID or guestClubID = @clubID)
    delete from match where hostClubID = @clubID or guestClubID = @clubID
    delete from club where id = @clubID
end
go

go
create procedure addStadium(@name varchar(20), @location varchar(20), @capacity int) as begin
    insert into stadium (name, location, capacity, status) values (@name, @location, @capacity, 1)
end
go

go
create procedure deleteStadium(@stadiumName varchar(20)) as begin
    declare @stadiumID int

    select @stadiumID = id from stadium where name = @stadiumName

    delete from hostRequest where matchID in (select id from match where stadiumID = @stadiumID)
    delete from ticketBuyingTransactions where ticketID in (select id from ticket where matchID in (select id from match where stadiumID = @stadiumID))
    delete from ticket where matchID in (select id from match where stadiumID = @stadiumID)
    delete from match where stadiumID = @stadiumID
    delete from stadium where id = @stadiumID
end
go

go
create procedure blockFan(@fanNationalID int) as begin
    update fan set status = 0 where nationalID = @fanNationalID
end
go

go
create procedure unblockFan(@fanNationalID int) as begin
    update fan set status = 1 where nationalID = @fanNationalID
end
go

go
create procedure addRepresentative(@name varchar(20), @clubName varchar (20), @username varchar(20), @password varchar(20)) as begin
    declare @clubID int
    select @clubID = id from club where name = @clubName
    insert into systemUser (username, password) values (@username, @password)
    insert into clubRepresentative (name, username, password, clubId) values (@name, @username, @password, @clubID)
end
go

create function viewAvailableStadiumsOn(@date datetime) returns table as return (
    select name, location, capacity from stadium where status = 1 and id not in (select stadiumID from match where startTime between @date and dateadd(day, 1, @date))
)

go
create procedure addHostRequest(@clubName varchar(20), @stadiumName varchar(20), @date datetime) as begin
    declare @clubID int
    declare @stadiumID int
    declare @guestClubID int
    declare @stadiumManagerID int
    declare @representativeID int
    declare @matchID int

    select @clubID = id from club where name = @clubName
    select @stadiumID = id from stadium where name = @stadiumName
    select @guestClubID = guestClubID from match where startTime = @date and hostClubID = @clubID
    select @stadiumManagerID = id from stadiumManager where stadiumID = @stadiumID
    select @representativeID = id from clubRepresentative where clubID = @clubID

    select @matchID = id from match where startTime = @date and hostClubID = @clubID and guestClubID = @guestClubID

    insert into hostRequest (status, matchID, managerID, representativeID) values ('unhandled', @matchID, @stadiumManagerID, @representativeID)
end
go

go
create function allUnassignedMatches(@clubName varchar(20)) returns table as return (
    select guestClub.name, match.startTime from match join club on match.hostClubID = club.id join club as guestClub on match.guestClubID = guestClub.id where club.name = @clubName and match.stadiumID is null
)
go

go
create procedure addStadiumManager(@name varchar(20), @stadiumName varchar(20), @username varchar(20), @password varchar(20)) as begin
    declare @stadiumID int

    select @stadiumID = id from stadium where name = @stadiumName

    insert into systemUser (username, password) values (@username, @password)
    insert into stadiumManager (name, username, password, stadiumID) values (@name, @username, @password, @stadiumID)
end
go

go
create procedure allPendingRequests(@stadiumManagerUsername varchar(20)) as begin
    declare @stadiumID int

    select @stadiumID = stadiumID from stadiumManager where username = @stadiumManagerUsername

    select clubRepresentative.name, guestClub.name, match.startTime from hostRequest join match on hostRequest.matchID = match.id join clubRepresentative on hostRequest.representativeID = clubRepresentative.id join club on clubRepresentative.clubID = club.id join club as guestClub on match.guestClubID = guestClub.id where hostRequest.status = 'unhandled' and match.stadiumID = @stadiumID
end
go

go
create procedure acceptRequest(@stadiumManagerUsername varchar(20), @hostClubName varchar(20), @guestClubName varchar(20), @startTime datetime) as begin
    declare @stadiumManagerID int
    declare @hostClubID int
    declare @guestClubID int
    declare @matchID int

    select @stadiumManagerID = id from stadiumManager where username = @stadiumManagerUsername
    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName
    select @matchID = id from match where startTime = @startTime and hostClubID = @hostClubID and guestClubID = @guestClubID

    update hostRequest set status = 'accepted' where matchID = @matchID and managerID = @stadiumManagerID
end
go

go
create procedure rejectRequest(@stadiumManagerUsername varchar(20), @hostClubName varchar(20), @guestClubName varchar(20), @startTime datetime) as begin
    declare @stadiumManagerID int
    declare @hostClubID int
    declare @guestClubID int
    declare @matchID int

    select @stadiumManagerID = id from stadiumManager where username = @stadiumManagerUsername
    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName
    select @matchID = id from match where startTime = @startTime and hostClubID = @hostClubID and guestClubID = @guestClubID

    update hostRequest set status = 'rejected' where matchID = @matchID and managerID = @stadiumManagerID
end
go

go
create procedure addFan(@name varchar(20), @username varchar(20), @password varchar(20), @nationalID varchar(20), @birthDate datetime, @address varchar(20), @phone int) as begin
    insert into systemUser (username, password) values (@username, @password)
    insert into fan (name, username, password, nationalID, birthDate, address, phoneNumber, status) values (@name, @username, @password, @nationalID, @birthDate, @address, @phone, 1)
end
go

go
create function upcomingMatchesOfClub(@clubName varchar(20)) returns table as return (
    select guestClub.name, match.startTime from match join club on match.hostClubID = club.id join club as guestClub on match.guestClubID = guestClub.id where club.name = @clubName and match.startTime > getdate()
)
go

go
create function availableMatchesToAttend(@date datetime) returns table as return (
    select club.name as hostClubName, guestClub.name as guestClubName, match.startTime, stadium.name as stadiumName from match join club on match.hostClubID = club.id join club as guestClub on match.guestClubID = guestClub.id join stadium on match.stadiumID = stadium.id where match.startTime > @date and match.id not in (select matchID from ticket where status = 'sold')
)
go

go
create procedure purchaseTicket(@fanNationalID varchar(20), @hostClubName varchar(20), @guestClubName varchar(20), @startTime datetime) as begin
    declare @hostClubID int
    declare @guestClubID int
    declare @matchID int

    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName
    select @matchID = id from match where startTime = @startTime and hostClubID = @hostClubID and guestClubID = @guestClubID

    insert into ticket (matchID, status) values (@matchID, 0)
end
go

go
create procedure updateMatchHost(@hostClubName varchar(20), @guestClubName varchar(20), @startTime datetime) as begin
    declare @hostClubID int
    declare @guestClubID int
    declare @matchID int

    select @hostClubID = id from club where name = @hostClubName
    select @guestClubID = id from club where name = @guestClubName
    select @matchID = id from match where startTime = @startTime and hostClubID = @hostClubID and guestClubID = @guestClubID

    update match set hostClubID = @guestClubID where id = @matchID
    update match set guestClubID = @hostClubID where id = @matchID
end
go

go
create view matchesPerTeam as
    select club.name, count(match.id) as matchesPlayed from match join club on match.hostClubID = club.id group by club.name
go

go
create view clubsNeverMatched as
    select club.name as firstClubName, guestClub.name as secondClubName from club join club as guestClub on club.id != guestClub.id where club.id not in (select hostClubID from match where guestClubID = guestClub.id) and guestClub.id not in (select guestClubID from match where hostClubID = club.id)
go

go
create function clubsNeverPlayed(@clubName varchar(20)) returns table as return (
    select guestClub.name from club join club as guestClub on club.id != guestClub.id where club.name = @clubName and club.id not in (select hostClubID from match where guestClubID = guestClub.id) and guestClub.id not in (select guestClubID from match where hostClubID = club.id)
)
go

go
create function matchWithHighestAttendance() returns table as return (
    select hostClubName, guestClubName from ( select club.name as hostClubName, guestClub.name as guestClubName, row_number() over (order by count(ticket.matchID) desc) as rn from match join club on match.hostClubID = club.id join club as guestClub ON match.guestClubID = guestClub.id join ticket on ticket.matchID = match.id and ticket.status = 0 group by match.id, club.name, guestClub.name ) t where rn = 1
)
go

go
create function matchesRankedByAttendance() returns table as return (
    select hostClubName, guestClubName from ( select club.name as hostClubName, guestClub.name as guestClubName, row_number() over (order by count(ticket.matchID) desc) as rn from match join club on match.hostClubID = club.id join club as guestClub ON match.guestClubID = guestClub.id join ticket on ticket.matchID = match.id and ticket.status = 0 group by match.id, club.name, guestClub.name ) t
)
go

go
create function requestsFromClub(@stadiumName varchar(20), @clubName varchar(20)) returns table as return (
    select club.name as hostClubName, guestClub.name as guestClubName from match join club on match.hostClubID = club.id join club as guestClub on match.guestClubID = guestClub.id join stadium on match.stadiumID = stadium.id where stadium.name = @stadiumName and match.id in (select matchID from hostRequest where representativeID = (select id from clubRepresentative where clubID = (select id from club where name = @clubName)))
)
go



create database TicketSystem;

use TicketSystem;

exec createAllTables;

exec dropAllTables;

exec clearAllTables;

exec dropAllProceduresFunctionsViews;



drop database TicketSystem;

drop proc dropAllProceduresFunctionsViews;



insert into systemUser values('Omar', '123');
insert into systemAdmin values('Omar', 'Omar', '123');



create proc userLogin
    @username varchar(20),
    @password varchar(20),
    @success bit output,
    @type int output
as
begin
if exists(
    select username,password
    from systemUser
    where username=@username and password=@password)
begin
    set @success =1
    set @type=0
    if exists(select username from systemAdmin where username=@username) set @type=1
    if exists(select username from sportsAssosiactionManager where username=@username) set @type=2
    if exists(select username from clubRepresentative where username=@username) set @type=3
    if exists(select username from stadiumManager where username=@username) set @type=4
    if exists(select username from fan where username=@username) set @type=5
end
else
    set @success=0
end
go