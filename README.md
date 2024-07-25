# Data Project : Excel, SQL, Power BI

# Table of Contents

1. [Objective](#objective)
2. [Data Source](#data-source)
3. [Stages](#stages)
   - [Design](#design)
     - [Tools](#tools)
   - [Development](#development)
     - [Pseudocode](#pseudocode)
     - [Data Exploration](#data-exploration)
   - [Data Cleaning](#data-cleaning)
     - [Transform the Data](#transform-the-data)
     - [Create the SQL View](#create-the-sql-view)
   - [Testing](#testing)
     - [Data Quality Tests](#data-quality-tests)
4. [Visualization](#visualization)
   - [Results](#results)
   - [DAX Measures](#dax-measures)
5. [Analysis](#analysis)
   - [Findings](#findings)
   - [Validation](#validation)
   - [Discovery](#discovery)
6. [Recommendations](#recommendations)
   - [Potential ROI](#potential-roi)
   - [Potential Courses of Actions](#action-plan)
7. [Conclusion](#conclusion)


## Objective
### What is the key pain point?
The Head of Marketing wants to find out who the top YouTubers are in 2024 to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.

### What is the ideal solution?
To create a dashboard that provides insights into the top UK YouTubers in 2024 that includes their:
- subscriber count
- total views
- total videos, and
- engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

### User story
As the Head of Marketing, I want to use a dashboard that analyses YouTube channel data in the UK.

This dashboard should allow me to identify the top-performing channels based on metrics like subscriber base and average views.

With this information, I can make more informed decisions about which YouTubers are right to collaborate with, and therefore maximize how effective each marketing campaign is.

## Data Source
### What data is needed to achieve our objective?
We need data on the top UK YouTubers in 2024 that includes their:
- channel names
- total subscribers
- total views
- total videos uploaded

### Where is the data coming from?
The data is sourced from Kaggle (an Excel extract), see [here](https://www.kaggle.com) to find it.

## Stages
- Design
- Development
- Testing
- Analysis

## Design
### Dashboard components required
What should the dashboard contain based on the requirements provided?
To understand what it should contain, we need to figure out what questions we need the dashboard to answer:
- Who are the top 10 YouTubers with the most subscribers?
- Which 3 channels have uploaded the most videos?
- Which 3 channels have the most views?
- Which 3 channels have the highest average views per video?
- Which 3 channels have the highest views per subscriber ratio?
- Which 3 channels have the highest subscriber engagement rate per video uploaded?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis.

### Dashboard mockup
What should it look like?
Some of the data visuals that may be appropriate in answering our questions include:
- Table
- Treemap
- Scorecards
- Horizontal bar chart


## Tools
| Tool         | Purpose                                                   |
|--------------|-----------------------------------------------------------|
| Excel        | Exploring the data                                        |
| SQL Server   | Cleaning, testing, and analyzing the data                 |
| Power BI     | Visualizing the data via interactive dashboards           |
| GitHub       | Hosting the project documentation and version control     |

## Development
### Pseudocode
What's the general approach in creating this solution from start to finish?
1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

### Data exploration
This is the stage where you have a scan of what's in the data, errors, inconsistencies, bugs, weird and corrupted characters, etc.

#### What are your initial observations with this dataset? What's caught your attention so far?
- There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data.
- The first column contains the channel ID with what appears to be channel IDs, which are separated by a @ symbol - we need to extract the channel names from this.
- Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.
- We have more data than we need, so some of these columns would need to be removed.

## Data cleaning
### What do we expect the clean data to look like? (What should it contain? What constraints should we apply to it?)
The aim is to refine our dataset to ensure it is structured and ready for analysis.

The cleaned data should meet the following criteria and constraints:
- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

Below is a table outlining the constraints on our cleaned dataset:

| Property           | Description                |
|--------------------|----------------------------|
| Number of Rows     | 100                        |
| Number of Columns  | 4                          |

And here is a tabular representation of the expected schema for the clean data:

| Column Name       | Data Type  | Nullable  |
|-------------------|------------|-----------|
| channel_name      | VARCHAR    | NO        |
| total_subscribers | INTEGER    | NO        |
| total_views       | INTEGER    | NO        |
| total_videos      | INTEGER    | NO        |

### What steps are needed to clean and shape the data into the desired format?
1. Remove unnecessary columns by only selecting the ones you need.
2. Extract YouTube channel names from the first column.
3. Rename columns using aliases.

### Transform the Data
```sql
Data Cleaning steps:
1. remove unnecessary columns by selcting the ones we need
2. extract the youtube channel names from the first columns
3. rename the column names

*/


SELECT NOMBRE, total_subscribers, total_videos, total_views
FROM youtube_db..youtube_data_from_python;



-- CHARINDEX

--charindex('nice', 'i went to a nice park') as position_of_n_in_sentence
--returns 13 as the index of N in nice

-- substring (where we want to extract from, start position, end position.)
--substring (nombre, 1, charindex('@', NOMBRE))


SELECT cast(substring (nombre, 1, charindex('@', NOMBRE)-1)as varchar(100)) as ChannelNames, total_subscribers, total_videos, total_views
FROM youtube_data_from_python;

    top_uk_youtubers_2024
```
### Create the SQL View
```sql
-- create view
CREATE VIEW view_uk_youtubers AS
SELECT cast(substring (nombre, 1, charindex('@', NOMBRE)-1)as varchar(100)) as ChannelNames, total_subscribers, total_videos, total_views
FROM youtube_data_from_python;

Select *
from youtube_db..view_uk_youtubers;
```

## Testing 
### Data Quality Tests
- Here are the data quality tests conducted:
### Row Count Check
```sql
-- 1. Row Count Check
Select Count(*) as total_rows
from youtube_db..view_uk_youtubers;
```
![image](https://github.com/user-attachments/assets/0484adf0-1383-4418-aa67-64c45a84eed8)

### Column Count Check
```sql
-- 2. Column Count Check
Select Count(*) as colummn_count from Information_schema.columns 
where TABLE_NAME = 'view_uk_youtubers'
```
![image](https://github.com/user-attachments/assets/b38809c6-d23d-462d-a841-0b4c78bf9ed9)

### Data Type Check
```sql
-- 3. data type check
Select COLUMN_DEFAULT, DATA_TYPE from Information_schema.columns 
where TABLE_NAME = 'view_uk_youtubers'
```
![image](https://github.com/user-attachments/assets/ff55ca30-53c6-46bb-9fd8-6d7be1e1cd5c)

### Duplicate Count Check
```sql
-- 4. duplicate count check
select ChannelNames, count(*) as duplicates_count
from youtube_db..view_uk_youtubers
group by ChannelNames
having count(*) > 1
```
![image](https://github.com/user-attachments/assets/0ec9aeca-6f9f-4cfc-8b16-38ff3beb5313)

# Visualization
## Results
![UK_top_Youtubers](https://github.com/user-attachments/assets/fdafd94d-b0c0-4b4e-b51f-d79fd5c7bafd)

# DAX Measures
1. Total Subscribers(M)
```dax
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers[total_subscribers])
VAR sumOfTotalVideos = SUM(view_uk_youtubers[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngRate 

```
2. Total Views (B)
```dax
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers[total_views])
VAR totalViews = ROUND(sumOfTotalViews / billion, 2)

RETURN totalViews

```
3. Total Videos
```dax
Total Videos = 
VAR totalVideos = SUM(view_uk_youtubers[total_videos])

RETURN totalVideos

```
4. Average Views Per Video(M)
```dax
Average Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers[total_videos])
VAR  avgViewsPerVideo = DIVIDE(sumOfTotalViews,sumOfTotalVideos, BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo 

```
5. Subscribber Engagement Rate
```dax
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers[total_subscribers])
VAR sumOfTotalVideos = SUM(view_uk_youtubers[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngRate 

```
6. Views Per Subscriber
```dax
Views Per Subscriber = 
VAR sumOfTotalViews = SUM(view_uk_youtubers[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers[total_subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews, sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber 

```

## Analysis
### Findings
What did we find?
For this analysis, we're going to focus on the questions below to get the information we need for our marketing client
Here are the key questions we need to answer for our marketing client:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?


##1. Who are the top 10 YouTubers with the most subscribers?
# YouTube Channels Ranking

| Rank | Channel Name    | Subscribers (M) |
|------|-----------------|-----------------|
| 1    | NoCopyrightSounds | 33.60           |
| 2    | DanTDM          | 28.60           |
| 3    | Dan Rhodes      | 26.50           |
| 4    | Miss Katy       | 24.50           |
| 5    | Mister Max      | 24.40           |
| 6    | KSI             | 24.10           |
| 7    | Jelly           | 23.50           |
| 8    | Dua Lipa        | 23.30           |
| 9    | Sidemen         | 21.00           |
| 10   | Ali-A           | 18.90           |

##2. Which 3 channels have uploaded the most videos?
# YouTube Channels Videos Uploaded

| Rank | Channel Name      | Videos Uploaded |
|------|-------------------|-----------------|
| 1    | GRM Daily         | 14,696          |
| 2    | Manchester City   | 8,248           |
| 3    | Yogscast          | 6,435           |

##3. Which 3 channels have the most views?
# YouTube Channels Total Views

| Rank | Channel Name | Total Views (B) |
|------|--------------|------------------|
| 1    | DanTDM       | 19.78            |
| 2    | Dan Rhodes   | 18.56            |
| 3    | Mister Max   | 15.97            |

##4. Which 3 channels have the highest average views per video?
# YouTube Channels Average Views per Video

| Channel Name | Average Views per Video (M) |
|--------------|------------------------------|
| Mark Ronson  | 32.27                        |
| Jessie J     | 5.97                         |
| Dua Lipa     | 5.76                         |

##5. Which 3 channels have the highest views per subscriber ratio?
# YouTube Channels Views per Subscriber

| Rank | Channel Name         | Views per Subscriber |
|------|----------------------|-----------------------|
| 1    | GRM Daily            | 1185.79               |
| 2    | Nickelodeon          | 1061.04               |
| 3    | Disney Junior UK     | 1031.97               |

##6. Which 3 channels have the highest subscriber engagement rate per video uploaded?
# YouTube Channels Subscriber Engagement Rate

| Rank | Channel Name | Subscriber Engagement Rate |
|------|--------------|----------------------------|
| 1    | Mark Ronson  | 343,000                    |
| 2    | Jessie J     | 110,416.67                 |
| 3    | Dua Lipa     | 104,954.95                 |

### Notes

For this analysis, we'll prioritize analysing the metrics that are important in generating the expected ROI for our marketing client, which are the YouTube channels wuth the most

..*subscribers
..*total views
..*videos uploaded

## Validation
# Youtubers with the Most Subscribers

## Calculation Breakdown

### Campaign Idea: Product Placement

#### a. NoCopyrightSounds
- **Average Views per Video:** 6.92 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 6.92 million x 2% conversion rate = 138,400 units sold
- **Potential Revenue per Video:** 138,400 x $5 = $692,000
- **Campaign Cost (One-Time Fee):** $50,000
- **Net Profit:** $692,000 - $50,000 = $642,000

#### b. DanTDM
- **Average Views per Video:** 5.34 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 5.34 million x 2% conversion rate = 106,800 units sold
- **Potential Revenue per Video:** 106,800 x $5 = $534,000
- **Campaign Cost (One-Time Fee):** $50,000
- **Net Profit:** $534,000 - $50,000 = $484,000

#### c. Dan Rhodes
- **Average Views per Video:** 11.15 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 11.15 million x 2% conversion rate = 223,000 units sold
- **Potential Revenue per Video:** 223,000 x $5 = $1,115,000
- **Campaign Cost (One-Time Fee):** $50,000
- **Net Profit:** $1,115,000 - $50,000 = $1,065,000

**Best option from category:** Dan Rhodes

### SQL Query
```sql
/*

1. Define the variables.
2. Create a CTE that rounds the average views per video
3. Select the column you need and create calculated columns from the existing ones
4. Filter results by Youtube channels
5. Sort results by net profit (from high to low)


*/

select * 
from youtube_db..view_uk_youtubers

--1
DECLARE @conversionRate FLOAT = 0.02;		-- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5.0;			-- The product cost @ $5
DECLARE @campaignCost FLOAT = 50000.0;		-- The campaign cost @ $50,000	

-- 2.  
WITH ChannelData AS (
SELECT ChannelNames, total_views, total_videos, ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
FROM youtube_db..view_uk_youtubers
)


-- 3. 
SELECT 
    ChannelNames,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost) AS net_profit
FROM 
    ChannelData


-- 4. 
WHERE 
    ChannelNames in ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')    


-- 5.  
ORDER BY
	net_profit DESC
```
#### Output
![image](https://github.com/user-attachments/assets/4aa366e6-8ebe-4e60-8334-b44e2c5c067f)

# Youtubers with the Most Videos Uploaded

## Calculation Breakdown

### Campaign Idea: Sponsored Video Series

#### a. GRM Daily
- **Average Views per Video:** 510,000
- **Product Cost:** $5
- **Potential Units Sold per Video:** 510,000 x 2% conversion rate = 10,200 units sold
- **Potential Revenue per Video:** 10,200 x $5 = $51,000
- **Campaign Cost (11 Videos @ $5,000 Each):** $55,000
- **Net Profit:** $51,000 - $55,000 = -$4,000 (Potential Loss)

#### b. Manchester City
- **Average Views per Video:** 240,000
- **Product Cost:** $5
- **Potential Units Sold per Video:** 240,000 x 2% conversion rate = 4,800 units sold
- **Potential Revenue per Video:** 4,800 x $5 = $24,000
- **Campaign Cost (11 Videos @ $5,000 Each):** $55,000
- **Net Profit:** $24,000 - $55,000 = -$31,000 (Potential Loss)

#### c. Yogscast
- **Average Views per Video:** 710,000
- **Product Cost:** $5
- **Potential Units Sold per Video:** 710,000 x 2% conversion rate = 14,200 units sold
- **Potential Revenue per Video:** 14,200 x $5 = $71,000
- **Campaign Cost (11 Videos @ $5,000 Each):** $55,000
- **Net Profit:** $71,000 - $55,000 = $16,000 (Profit)

**Best Option from Category:** Yogscast

### SQL Query
```sql
/* 
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/


-- 1.
DECLARE @conversionRate FLOAT = 0.02;           -- The conversion rate @ 2%
DECLARE @productCost FLOAT = 5.0;               -- The product cost @ $5
DECLARE @campaignCostPerVideo FLOAT = 5000.0;   -- The campaign cost per video @ $5,000
DECLARE @numberOfVideos INT = 11;               -- The number of videos (11)


-- 2.
WITH ChannelData AS (
    SELECT
       ChannelNames,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM
        youtube_db..view_uk_youtubers
)


-- 3.
SELECT
    ChannelNames,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    ((rounded_avg_views_per_video * @conversionRate * @productCost) - (@campaignCostPerVideo * @numberOfVideos)) AS net_profit
FROM
    ChannelData


-- 4.
WHERE
    ChannelNames IN ('GRM Daily', 'Man City', 'YOGSCAST Lewis & Simon ')


-- 5.
ORDER BY
    net_profit DESC;
```
#### Output
![image](https://github.com/user-attachments/assets/381a98ce-f821-4dff-a698-205fb294be8c)

# Youtubers with the Most Views

## Calculation Breakdown

### Campaign Idea: Influencer Marketing

#### a. DanTDM
- **Average Views per Video:** 5.34 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 5.34 million x 2% conversion rate = 106,800 units sold
- **Potential Revenue per Video:** 106,800 x $5 = $534,000
- **Campaign Cost (3-Month Contract):** $130,000
- **Net Profit:** $534,000 - $130,000 = $404,000

#### b. Dan Rhodes
- **Average Views per Video:** 11.15 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 11.15 million x 2% conversion rate = 223,000 units sold
- **Potential Revenue per Video:** 223,000 x $5 = $1,115,000
- **Campaign Cost (3-Month Contract):** $130,000
- **Net Profit:** $1,115,000 - $130,000 = $985,000

#### c. Mister Max
- **Average Views per Video:** 14.06 million
- **Product Cost:** $5
- **Potential Units Sold per Video:** 14.06 million x 2% conversion rate = 281,200 units sold
- **Potential Revenue per Video:** 281,200 x $5 = $1,406,000
- **Campaign Cost (3-Month Contract):** $130,000
- **Net Profit:** $1,406,000 - $130,000 = $1,276,000

**Best Option from Category:** Mister Max

### SQL Query
```sql
/*
# 1. Define variables
# 2. Create a CTE that rounds the average views per video
# 3. Select the columns you need and create calculated columns from existing ones
# 4. Filter results by YouTube channels
# 5. Sort results by net profits (from highest to lowest)
*/



-- 1.
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.0;            -- The product cost @ $5
DECLARE @campaignCost MONEY = 130000.0;      -- The campaign cost @ $130,000



-- 2.
WITH ChannelData AS (
    SELECT
        ChannelNames,
        total_views,
        total_videos,
        ROUND(CAST(total_views AS FLOAT) / total_videos, -4) AS avg_views_per_video
    FROM
       youtube_db..view_uk_youtubers
)


-- 3.
SELECT
    ChannelNames,
    avg_views_per_video,
    (avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM
    ChannelData


-- 4.
WHERE
   ChannelNames IN ('Mister Max', 'DanTDM', 'Dan Rhodes')


-- 5.
ORDER BY
    net_profit DESC;

```
#### Output
![image](https://github.com/user-attachments/assets/2557f5b3-db59-41bf-9540-1eee82750958)

# Discovery

## What Did We Learn?

- **NoCopyrightSounds, Dan Rhodes, and DanTDM** are the channels with the most subscribers in the UK.
- **GRM Daily, Manchester City, and Yogscast** are the channels with the most videos uploaded.
- **DanTDM, Dan Rhodes, and Mister Max** are the channels with the most views.
- Entertainment channels are effective for broader reach, as channels that post consistently and generate high engagement often focus on entertainment and music.

# Recommendations

## What Do You Recommend Based on the Insights Gathered?

- **Dan Rhodes** is the best YouTube channel to collaborate with to maximize visibility due to having the most subscribers in the UK.
- Although **GRM Daily, Manchester City, and Yogscast** are frequent publishers, collaborating with them under current budget constraints might yield lower returns compared to other channels.
- **Mister Max** is the best for maximizing reach, but **DanTDM** and **Dan Rhodes** could be better long-term options due to their large subscriber bases and high view counts.
- The top three channels to consider for collaboration are **NoCopyrightSounds, DanTDM, and Dan Rhodes**, as they consistently attract high engagement.

## Potential ROI

- **Dan Rhodes**: Collaborating with Dan Rhodes could result in a net profit of **$1,065,000 per video**.
- **Mister Max**: An influencer marketing contract with Mister Max could generate a net profit of **$1,276,000**.
- **DanTDM**: A product placement campaign with DanTDM could bring in approximately **$484,000 per video**. An influencer marketing deal with DanTDM could provide a one-off net profit of **$404,000**.
- **NoCopyrightSounds**: Could potentially profit the client **$642,000 per video**.

# Action Plan

## What Course of Action Should We Take and Why?

- Based on our analysis, **Dan Rhodes** is the best channel for a long-term partnership to promote the client's products.
- We will discuss with the marketing client to understand their expectations from this collaboration. Once milestones are met, we can consider future partnerships with **DanTDM, Mister Max, and NoCopyrightSounds**.

## What Steps Do We Take to Implement the Recommended Decisions Effectively?

1. **Reach Out**: Contact the teams behind each channel, starting with Dan Rhodes.
2. **Negotiate Contracts**: Ensure contracts are within the allocated budgets for each marketing campaign.
3. **Kick Off Campaigns**: Launch the campaigns and monitor their performance against KPIs.
4. **Review and Optimize**: Evaluate campaign outcomes, gather insights, and optimize based on feedback from converted customers and channel audiences.

# Conclusion
Based on the analysis of the top UK YouTubers in 2024, Dan Rhodes stands out as the best candidate for collaboration due to his leading subscriber count and high engagement, offering significant potential ROI of $1,065,000 per video. Mister Max also presents a strong opportunity with a potential profit of $1,276,000, making him ideal for maximizing reach. For consistent and broad engagement, DanTDM is recommended, with a projected net profit of $484,000 per video through product placement. These channels are strategically positioned to enhance visibility and drive impactful marketing results.

  
