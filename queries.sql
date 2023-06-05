-- find min and max lat and lng for each bike-share table

SELECT
MIN(ROUND(t.start_lat, 3)) AS min_lat_start,
MIN(ROUND(t.end_lat, 3)) AS min_lat_end,
MIN(ROUND(t.start_lng, 3)) AS min_lng_start,
MIN(ROUND(t.end_lng, 3)) AS min_lng_end,
MAX(ROUND(t.start_lat, 3)) AS max_lat_start,
MAX(ROUND(t.end_lat, 3)) AS max_lat_end,
MAX(ROUND(t.start_lng, 3)) AS max_lng_start,
MAX(ROUND(t.end_lng, 3)) AS max_lng_end
FROM `db.cyclistic.202304` AS t         -- replace date for each table
WHERE t.end_lat != 0.0 AND t.end_lng != 0

-- saved above as view
-- did UNION ALL to combine start and end lats and lngs to get aggregate min and max
    -- forgot to save this query, but saved results into tables for each month
-- create total aggregate of min and max lat and lng for dataset
SELECT
  MIN(m.min_lat) as min_lat,
  MIN(m.min_lng) AS min_lng,
  MAX(m.max_lat) AS max_lat,
  MAX(m.max_lng) AS max_lng
FROM
(SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
UNION ALL
SELECT * FROM `db.cyclistic.22_05`
) AS m

-- create aggregate table of weather data for specified date range
SELECT *
FROM `bigquery-public-data.noaa_gsod.gsod2022` AS gsod22
WHERE date > '2022-04-30'
UNION ALL
SELECT *
FROM `bigquery-public-data.noaa_gsod.gsod2023` AS gsod23
WHERE date < '2023-05-01'