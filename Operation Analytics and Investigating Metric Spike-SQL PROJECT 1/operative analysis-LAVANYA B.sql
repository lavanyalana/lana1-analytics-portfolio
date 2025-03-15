create database operation_analytics;
use operation_analytics;

# table 1 users

create table users (
user_id int,
created_at varchar(100),
company_id int,
language varchar (50),
activated_at varchar(100),
state varchar(50)
);

select * from  users;

alter table users 
add column temp_created_at datetime;

update users set temp_created_at = str_to_date(created_at, '%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

alter table users 
add column temp_activated_at datetime;

update users set temp_activated_at = str_to_date(activated_at, '%d-%m-%Y %H:%i');

SELECT * FROM USERS;

alter table users drop column created_at;

alter table users drop column activated_at;

alter table users
change column temp_created_at created_at datetime;

alter table users
change column temp_activated_at activated_at datetime;

#table 2 
create table events (
user_id int,
occured_at varchar(100),
event_type varchar(50),
event_name varchar(100),
location varchar(50),
device varchar(50),
user_type int
);

select * from events;

show variables like 'secure_file_priv' ;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/uploads/events.csv"
into table events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

alter table events
add column temp_occured_at datetime;

update events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES=0;
SET SQL_SAFE_UPDATES=1;

ALTER TABLE EVENTS DROP OCCURED_AT;

ALTER TABLE EVENTS 
change column temp_occured_at occured_at datetime;


#table 3 email_events

create table email_events(
user_id int,
occured_at varchar(100),
action varchar(100),
user_type int);

select * from email_events;

load data infile "C:/ProgramData/MySQL/MySQL Server 8.0/uploads/email_events.csv"
into table email_events
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

select * from email_events;

alter table email_events 
add column temp_occured_at datetime;

update email_events set temp_occured_at = str_to_date(occured_at, '%d-%m-%Y %H:%i');

SET SQL_SAFE_UPDATES = 0;
SET SQL_SAFE_UPDATES = 1;

ALTER TABLE EMAIL_EVENTS
DROP COLUMN OCCURED_AT;

alter table email_events
change column temp_occured_at occured_at datetime;

# case study 1

select * from job_data;

#TASK A

select ds,count(job_id),sum(time_spent)/3600
from job_data
group by ds;

# TASK B RESULT 1

SELECT ds,
       COUNT(job_id) / SUM(time_spent) AS throughput_per_second,
       AVG(COUNT(job_id) / SUM(time_spent)) 
       OVER (ORDER BY ds ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_7_day_avg_throughput
FROM job_data
GROUP BY ds
ORDER BY ds;

# TASK B RESULT 2

SELECT ds,
       COUNT(job_id) / SUM(time_spent) AS throughput_per_second  -- Events per second for each day
FROM job_data
GROUP BY ds
ORDER BY ds;

#TASK C
# NOT USING
SELECT * FROM JOB_DATA;

SELECT language,COUNT(*) FROM job_data 
WHERE ds >= CURRENT_DATE - INTERVAL 30 DAY
group by language;

# TASK C FINAL RESULT 1

SELECT 
    language, 
    COUNT(*) AS language_count,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_data)), 2) 
    AS percentage_share
FROM job_data
GROUP BY language
ORDER BY percentage_share DESC;


# TASK C FINAL RESULT 2

SELECT LANGUAGE,
       COUNT(*) * 100.0 / (SELECT COUNT(*) 
                           FROM job_data 
                           WHERE ds >= CURRENT_DATE - INTERVAL 30 DAY) AS percentage_share
FROM job_data
WHERE ds >= CURRENT_DATE - INTERVAL 30 DAY
GROUP BY LANGUAGE
ORDER BY percentage_share DESC;

# TASK D
# NOT USING
SELECT 
    LANGUAGE, 
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM job_data WHERE DATE(ds) BETWEEN '2020-11-25' AND '2020-11-30') AS percentage_share
FROM 
    job_data
WHERE 
    DATE(ds) BETWEEN '2020-11-25' AND '2020-11-30'
GROUP BY 
    LANGUAGE
ORDER BY 
    percentage_share DESC;
    
    # TASK D FINAL RESULT

SELECT * FROM JOB_DATA;

SELECT DS, JOB_ID,ACTOR_ID, EVENT, LANGUAGE, TIME_SPENT, ORG,
    COUNT(*) AS duplicate_count
FROM 
    job_data
GROUP BY DS, JOB_ID, ACTOR_ID, EVENT, LANGUAGE, TIME_SPENT, ORG
HAVING 
    COUNT(*) > 1
ORDER BY 
    duplicate_count DESC;

# CASE STUDY 2

select * from users;
select * from events;
select * from email_events;
  
  # TASK A TYPE - 1 RESULT
  
  SELECT 
    count(user_id) as no_of_users,
    WEEK(occured_at) AS week_no,
    COUNT(event_name) over(partition by WEEK(occured_at))  AS total_events,
    event_name
FROM 
    events
    where event_type = "engagement"
GROUP BY 
    WEEK(occured_at),event_name
ORDER BY 
  total_events DESC;
  
  # task A TYPE - 2 RESULT
  
SELECT 
    WEEK(occured_at) AS week_no,
    COUNT(*) AS total_events,  -- Count all events
    COUNT(user_id) AS no_of_users  -- Count users performing events
FROM 
    events
    where event_
GROUP BY 
    WEEK(occured_at)
ORDER BY 
    week_no DESC;
    
    # TASK B
    # analysed and practised below are not as final result

select * from users;
select * from events;
select * from email_events;

# 1
select user_type,count(user_id) as no_of_users,device,month(occured_at) as month
from events
group by user_type,device,month
order by no_of_users desc;

#2
with users_each_month as (
select count(user_id) as no_of_users,device,month(occured_at) as month
from events
group by device,month
order by no_of_users desc
) 
select subquery.avg_users,count(events.user_id) as no_of_users,events.device,
month(events.occured_at) as month
from events 
inner join ( select device,
    sum(no_of_users) / 4 AS avg_users from users_each_month
    group by device) as subquery 
    on events.device = subquery.device
    group by  events.device,month(events.occured_at)
    order by no_of_users desc;
    
select month(occured_at),device
from events
group by device,month(occured_at);

SELECT 
    occured_at,device,
    TIMESTAMPDIFF(MONTH, (SELECT MIN(occured_at) FROM events), occured_at) AS months_difference
FROM 
    events
    group by device;


SELECT 
    device,
    YEAR(occured_at) AS year,
    MONTH(occured_at) AS month,
    COUNT(DISTINCT user_id) AS total_users,
    COUNT(DISTINCT user_id) - 
        COALESCE(
            (SELECT COUNT(DISTINCT user_id) 
             FROM events 
             WHERE device = events.device 
               AND YEAR(occured_at) = YEAR(events.occured_at) 
               AND MONTH(occured_at) = MONTH(events.occured_at) - 1), 
        0) AS growth_in_users,
    (COUNT(DISTINCT user_id) - 
        COALESCE(
            (SELECT COUNT(DISTINCT user_id) 
             FROM events 
             WHERE device = events.device 
               AND YEAR(occured_at) = YEAR(events.occured_at) 
               AND MONTH(occured_at) = MONTH(events.occured_at) - 1), 
        0)) / 
        COALESCE(
            (SELECT COUNT(DISTINCT user_id) 
             FROM events 
             WHERE device = events.device 
               AND YEAR(occured_at) = YEAR(events.occured_at) 
               AND MONTH(occured_at) = MONTH(events.occured_at) - 1), 
        1) * 100 AS growth_percentage
FROM 
    events
GROUP BY 
    device, year, month
ORDER BY 
    device, year DESC, month DESC;


# CASE STUDY 2 
# TASK B TYPE- 1 RESULT

select count(user_id) as no_of_users,device,month(occured_at) as month
from events
group by device,month
order by no_of_users desc;

# TASK B TYPE- 2 RESULT

with users_each_month as (
select count(user_id) as no_of_users,device,month(occured_at) as month
from events
group by device,month
order by no_of_users desc
) 
select distinct subquery.avg_users,events.device
from events 
inner join ( select device,
    sum(no_of_users) / 4 AS avg_users from users_each_month
    group by device) as subquery 
    on events.device = subquery.device
    group by  events.device,month(events.occured_at)
    order by subquery.avg_users desc;
    
    
    # CASE STUDY 2 TASK C
    
select * from users;
select * from events;
select * from email_events;

# TASK C FINAL RESULT

WITH cohort_users AS (
    SELECT user_id,WEEK(MIN(occured_at)) AS activated_week
    FROM events
    WHERE event_type = 'signup_flow'
    GROUP BY user_id
),
active_users AS (
    SELECT events.user_id,WEEK(MAX(events.occured_at)) AS active_week
    FROM events 
    JOIN cohort_users
    ON events.user_id = cohort_users.user_id
    WHERE events.event_type = 'engagement'
    GROUP BY events.user_id
)
SELECT 
    cohort_users.activated_week,active_users.active_week,
    COUNT(DISTINCT cohort_users.user_id) AS signup_users,
    COUNT(DISTINCT active_users.user_id) AS retained_users,
    concat(round(COUNT(DISTINCT active_users.user_id) * 100.0) / 
    COUNT(DISTINCT cohort_users.user_id),'%') AS retention_percentage
FROM cohort_users
LEFT JOIN active_users ON 
    cohort_users.user_id = active_users.user_id 
    or active_users.active_week = cohort_users.activated_week + 1 
    -- Check next week activity
GROUP BY cohort_users.activated_week, active_users.active_week
ORDER BY cohort_users.activated_week;

# TASK C QUERIES WHICH I USED TO ANALYSED
# NOT AS PART OF FINAL RESULT
    
select * from events
where event_type = "signup_flow";
    
select count( user_id) as no_of_users,event_type,week(occured_at) as week_no,device
from events
where event_type = "signup_flow"
group by week_no,device;

SELECT count(events.user_id) as total_users, subquery.activated_week,
        derived.active_week
    FROM events 
    inner join ( select user_id,week(min(occured_at)) AS activated_week 
    from events where event_type = "signup_flow"
    group by user_id) as subquery
    on events.user_id = subquery.user_id
    inner join ( select user_id,week(max(occured_at)) as active_week
    from events 
    group by user_id) as derived 
    on events.user_id = derived.user_id
    group by subquery.activated_week, derived.active_week;
    
    # cohort users activated
    select count(user_id) as cohort_user, week(min(occured_at)) AS activated_week 
    from events
    where event_type = "signup_flow"
    group by week(occured_at);

    # number of users at last week - active users
    
    select count(user_id) as active_users, week(max(occured_at)) as active_week
    from events
    where event_type = "engagement"
    group by week(occured_at);
    
    with cohort_users as (
    select count(user_id) as signup_users, week(min(occured_at)) AS activated_week 
    from events
    where event_type = "signup_flow"
    group by week(occured_at)
    ),
    active_users as (
    select count(user_id) as active_users, week(max(occured_at)) as active_week
    from events
    where event_type = "engagement"
    group by week(occured_at)
    )
    select 
    cohort_users.activated_week,active_users.active_week,
    count(distinct active_users)  / count(signup_users) as user_retention,
    count(distinct active_users) * 100 / count(signup_users) as retention_percentage
    from cohort_users
    inner join active_users
    on cohort_users.signup_users = active_users.active_users
    group by activated_week,active_week;
    
    SELECT count(events.user_id), week(min(occured_at)) AS activated_week,
        week(max(occured_at)) AS active_week
    FROM events 
    group by week(min(occured_at));
    
# CASE STUDY 2 TASK D

select * from users;
select * from events;
select * from email_events;

select count(distinct user_id),week(occured_at) from events
   group by week(occured_at);

# TASK D final result 

with users_per_device as (
select count(distinct user_id) as no_of_users, 
(week(occured_at)) as week_no, device
from events
group by device,week(occured_at)
),
total_users_per_week as (
select count(distinct user_id) as total_users_per_week, 
(week(occured_at)) as week_no
from events
group by week(occured_at)
)
select users_per_device.week_no, users_per_device.device,
users_per_device.no_of_users,total_users_per_week.total_users_per_week,
concat(round(users_per_device.no_of_users * 100 / 
total_users_per_week.total_users_per_week ), '%') as user_engagement
from total_users_per_week
inner join users_per_device on 
total_users_per_week.week_no = users_per_device.week_no
group by users_per_device.device, users_per_device.week_no
order by users_per_device.no_of_users desc;

# TASK D QUERIES WHICH I ANALYSED AND EXAMINED TO GET FINAL RESULT
# NOT USED AS FINAL RESULT

select count(user_id) as no_of_users, 
(week(occured_at)) as week_no, device
from events
group by device,week(occured_at)
order by no_of_users desc;


select count(user_id) as no_of_users, 
(week(occured_at)) as week_no, device,
count(user_id) * 100 / count(distinct user_id) as user_engagement
from events
group by device,week(occured_at)
order by no_of_users desc;

# TASK E

select * from email_events;

select count(distinct user_id) as no_of_users, action from email_events
group by action;

select count(distinct user_id) as total_users from email_events
where action in ('email_clickthrough', 'email_open', 'sent_reengagement_email', 'sent_weekly_digest');

# TASK E FINAL RESULT

WITH total_users AS (
SELECT action, COUNT(DISTINCT user_id) AS total_users
FROM email_events
WHERE action IN ('email_clickthrough', 'email_open', 'sent_reengagement_email', 
'sent_weekly_digest')
GROUP BY action
),
email_opened AS (
SELECT COUNT(DISTINCT user_id) AS users_opened_email
FROM email_events
WHERE action = 'email_open'
),
email_clicked AS (
SELECT COUNT(DISTINCT user_id) AS users_clicked_email
FROM email_events
WHERE action = 'email_clickthrough'
),
reengagement_sent AS (
SELECT COUNT(DISTINCT user_id) AS users_sent_reengagement
FROM email_events
WHERE action = 'sent_reengagement_email'
)
SELECT  
    total_users.action, 
    total_users.total_users, 
    email_opened.users_opened_email, 
    email_clicked.users_clicked_email, 
    reengagement_sent.users_sent_reengagement, 
    CONCAT(ROUND(email_opened.users_opened_email * 100 / total_users.total_users), '%') AS email_open_rate,
    CONCAT(ROUND(email_clicked.users_clicked_email * 100 / total_users.total_users), '%') AS email_clicked_rate,
    CONCAT(ROUND(reengagement_sent.users_sent_reengagement * 100 / total_users.total_users), '%') AS reengagement_rate
FROM  total_users
LEFT JOIN email_opened ON 1=1
LEFT JOIN email_clicked ON 1=1
LEFT JOIN reengagement_sent ON 1=1;

# TASK E FOLLOWING QUERIES WHICH I PRACTICED AND ANALYSED TO GET RESULT

with total_users as (
select count(distinct user_id) as total_users,action
from email_events
group by action
),
email_opened as (
select count(distinct user_id) as users_opened_email
from email_events
where action = "email_open" 
),
email_clicked as (
select count(distinct user_id) as users_clicked_email
from email_events
where action = "email_clickthrough" 
),
reengagement_sent as (
select count(distinct user_id) as users_sent_reengagement
from email_events
where action = "sent_reengagement_email" 
)
select 
total_users.total_users,
email_opened.users_opened_email,
email_clicked.users_clicked_email,
reengagement_sent.users_sent_reengagement,
concat(round(email_opened.users_opened_email * 100 / total_users.total_users),'%') as email_open_rate,
concat(round(email_clicked.users_clicked_email * 100 / total_users.total_users),'%') as email_clicked_rate,
concat(round(reengagement_sent.users_sent_reengagement * 100 / total_users.total_users),'%') as reengagement_rate
from 
total_users
join 
email_opened
join
email_clicked
join
reengagement_sent;


-- -- -- -- -- -- -- -- -- -- 



   