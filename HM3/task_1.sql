DROP DICTIONARY IF EXISTS lkovacevic.player_dictionary;
DROP DICTIONARY IF EXISTS lkovacevic.sport_dictionary;
DROP DICTIONARY IF EXISTS lkovacevic.team_dictionary;
DROP DICTIONARY IF EXISTS lkovacevic.tournament_dictionary;
DROP DICTIONARY IF EXISTS lkovacevic.uniquetournament_dictionary;
DROP DICTIONARY IF EXISTS lkovacevic.event_dictionary;

CREATE DICTIONARY
lkovacevic.event_dictionary
(
    id Int32,
    sport_id Int32,
    tournament_id Int32,
    season_id Nullable(Int32),
    venue_id Nullable(Int32),
    referee_id Nullable(Int32),
    usercount Int32,
    attendance Nullable(Int32),
    startdate DateTime64(6),
    hometeam_id Int32
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'event' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);

CREATE DICTIONARY
lkovacevic.sport_dictionary
(
id String,
name String,
slug String,
external_id Nullable(Int32)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'sport' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);

CREATE DICTIONARY
lkovacevic.tournament_dictionary
(
id Int32,
category_id Int32,
name String,
slug String,
priority Int32,
order Int32,
visible UInt8,
startdate Nullable(DateTime64(6)),
enddate Nullable(DateTime64(6)),
externalid Nullable(Int32),
externaltype Int16,
uniquetournament_id Nullable(Int32),
seasons Array(Int32),
extra Nullable(String),
logo_id Nullable(Int32),
isgroup Nullable(UInt8),
groupname Nullable(String),
roundprefix Nullable(String),
disabled UInt8,
competitiontype Nullable(Int16),
primarycolorhex Nullable(String),
secondarycolorhex Nullable(String),
firstcupround Nullable(Int32),
coveredbyeditorstatistics Nullable(UInt8),
periodlength_normaltime Nullable(Int16),
periodlength_overtime Nullable(Int16),
darklogo_id Nullable(Int32)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'tournament' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);

CREATE DICTIONARY
lkovacevic.uniquetournament_dictionary
(
id Int32,
name String,
slug String,
priority Int32,
order Int32,
externalid Nullable(Int32),
externaltype Int16,
extra Nullable(String),
logo_id Nullable(Int32),
category_id Int32,
usercount Int32,
visible UInt8,
title_holder_id Nullable(Int32),
startdate Nullable(DateTime64(6)),
enddate Nullable(DateTime64(6)),
tier Nullable(Int32),
titleholdertitles Nullable(Int32),
mosttitles Nullable(Int32),
groundtype Nullable(String),
numberofsets Nullable(Int32),
tennispoints Nullable(Int32),
hasstandingsgroups Nullable(UInt8),
hasrounds Nullable(UInt8),
hasgroups Nullable(UInt8),
hasplayoffseries Nullable(UInt8),
hasdisabledhomeawaystandings Nullable(UInt8),
manuallychecked Nullable(UInt8),
primarycolorhex Nullable(String),
secondarycolorhex Nullable(String),
shortname Nullable(String),
yearoffoundation Nullable(Int32),
chairman Nullable(String),
owner Nullable(String),
numberofcompetitors Nullable(Int32),
numberofdivisions Nullable(Int32),
country_alpha2 Nullable(String),
hasperformancegraphfeature UInt8,
hasperformancegraph UInt8,
featuredeventtier Nullable(Int16),
darklogo_id Nullable(Int32),
crowdsourcingenabled UInt8,
periodlength_normaltime Nullable(Int32),
periodlength_overtime Nullable(Int32),
gender Nullable(String),
haswinprobability Nullable(UInt8),
standingssettings_id Nullable(Int32),
lineupsmanualcreationrequired Nullable(UInt8)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'uniquetournament' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);

CREATE DICTIONARY
lkovacevic.team_dictionary
(
id Int32,
sport_id Int32,
category_id Int32,
tournament_id Nullable(Int32),
name String,
slug String,
shortname Nullable(String),
gender Nullable(String),
usercount Int32,
externalid Nullable(Int32)
)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'team' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);

DROP DICTIONARY IF EXISTS lkovacevic.player_dictionary;

CREATE DICTIONARY
lkovacevic.player_dictionary
(
id Int32,
team_id Int32,
name String,
position Nullable(String),
weight Nullable(Int32),
height Nullable(Int32),
preferredfoot Nullable(String),
externalid Nullable(Int32),
externaltype Int16,
image_id Nullable(Int32)

)
PRIMARY KEY id
SOURCE(CLICKHOUSE(DB 'sports' TABLE 'player' USER 'lkovacevic' PASSWORD 'b9Ea8XzdFr0w6Zo32i4Z'))
LAYOUT(FLAT(INITIAL_ARRAY_SIZE 50000 MAX_ARRAY_SIZE 50000000))
LIFETIME(MIN 0 MAX 1000);




