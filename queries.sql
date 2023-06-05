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

-- create table containing only stations within the dataset geo range

SELECT *
FROM `bigquery-public-data.noaa_gsod.stations`
WHERE
  lat <= (
    SELECT max_lat
    FROM `db.cyclistic.lat_long`
  ) AND
  lat >= (
    SELECT min_lat
    FROM `db.cyclistic.lat_long`
  ) AND
  lon <= (
    SELECT max_lng
    FROM `db.cyclistic.lat_long`
  ) AND
  lon >= (
    SELECT min_lng
    FROM `db.cyclistic.lat_long`
  )

-- create aggregate weather table for date and geo range

SELECT *
FROM (
  SELECT *
  FROM `bigquery-public-data.noaa_gsod.gsod2022` AS gs22
  WHERE gs22.date > '2022-04-30'
  UNION ALL
  SELECT *
  FROM `bigquery-public-data.noaa_gsod.gsod2023` AS gs23
  WHERE gs23.date < '2023-05-01'
  ) AS gs
  JOIN (
    SELECT
      stn.usaf,
      stn.wban AS wbn,
      stn.name,
      stn.country,
      stn.state,
      stn.call,
      stn.begin,
      stn.end,
      stn.lat,
      stn.lon,
    FROM `db.cyclistic.chi_stns` AS stn)as stns
    ON gs.stn = stns.usaf

-- queried above result into area weather averages by date for final weather table

SELECT
  date,
  AVG(temp) AS avg_temp,
  AVG(CAST(wdsp AS float64)) AS avg_wind_knots,
  AVG(prcp) AS avg_precip_inches,
  AVG(sndp) AS avg_snow_depth_inches,
  SUM(CAST(fog AS int64)) AS fog,
  SUM(CAST(rain_drizzle AS int64)) AS rain_drizzle,
  SUM(CAST(snow_ice_pellets AS int64)) AS snow_ice_pellets,
  SUM(CAST(hail AS int64)) AS hail,
  SUM(CAST(thunder AS int64)) AS thunder,
  SUM(CAST(tornado_funnel_cloud AS int64)) AS tornado_funnel_cloud
FROM `capstone-387220.cyclistic.agg_stn_weather`
GROUP BY date
ORDER BY date ASC