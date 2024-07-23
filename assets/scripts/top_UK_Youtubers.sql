/*
Data Cleaning steps:
1. remove unnecessary columns by selcting the ones we need
2. extract the youtube channel names from the first columns
3. rename the column names

*/

SELECT NOMBRE, total_subscribers, total_videos, total_views
FROM youtube_data_from_python;



-- CHARINDEX

--charindex('nice', 'i went to a nice park') as position_of_n_in_sentence
--returns 13 as the index of N in nice

-- substring (where we want to extract from, start position, end position.)
--substring (nombre, 1, charindex('@', NOMBRE))


SELECT cast(substring (nombre, 1, charindex('@', NOMBRE)-1)as varchar(100)) as ChannelNames, total_subscribers, total_videos, total_views
FROM youtube_data_from_python;

-- create view
CREATE VIEW view_uk_youtubers AS
SELECT cast(substring (nombre, 1, charindex('@', NOMBRE)-1)as varchar(100)) as ChannelNames, total_subscribers, total_videos, total_views
FROM youtube_data_from_python;


/*
Data Quality tests

1. The data needs to be 100 records of youtube channel (row count test)

2. The data needs 4 fields (column count test)

3. The channel name must be a string, total_subscriber must be a whole number,
   the total_ views and total_vidoes must also be a whole number (data type test)

4. Each record must be unique (duplicate count test).


row count - 100 (PASSED)
column count - 4 (PASSED)


data types:  (PASSED)
channel names - varchar
total subscribers  - int
total views - int
total videos - int

duplicates count - 0  (PASSED)

*/

-- 1. Row Count Check
Select Count(*) as total_rows
from view_uk_youtubers;

-- 2. Column Count Check
Select Count(*) as colummn_count from Information_schema.columns 
where TABLE_NAME = 'view_uk_youtubers'


-- 3. data type check
Select COLUMN_DEFAULT, DATA_TYPE from Information_schema.columns 
where TABLE_NAME = 'view_uk_youtubers'

-- 4. duplicate count check
select ChannelNames, count(*) as duplicates_count
from view_uk_youtubers
group by ChannelNames
having count(*) > 1
