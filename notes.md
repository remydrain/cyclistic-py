# Description
These are notes of my process as things come up. Normally I'd add this document to my gitignore file, but I'm putting it here as an insight to my analysis (and learning) process.

## To Do
- [ ] Calculate ride length for all bike tables
- [ ] Create day_of_week column for all bike tables
- [ ] Drop unnecessary columns
- [ ] Add SQL queries to directory

## BigQuery
* Some of the tables are missing station names and ids
    * Decide later whether to join in SQL or Py
    * Not necessary for this analysis
* Aggregating min and max latitude and longitude to get a sense of the overall coverage area and to filter down weather table
* Created a view called "minmax" that I can swap out the table name for each month to create a view that I can then query get the overall min and max lat and long
* 202211 has 0.0 as the min_lat_end and min_lng_end after first query to find minmax
    * Added a WHERE clause to exclude 0.0
    * Returned expected range of values - saving WHERE clause to view
* Used aggregated min and max long and lat to filter weather stations to Chicago area
* Combined relevant date ranges from gsod22 and gsod23 tables and joined with Chicago stations table to get an aggregate weather table for the area from May 2022 - Apr 2023
    * Still too large to download as .csv from BQ
    * Eliminate duplicate/unnecessary columns
* Aggregated average weather conditions by date and read resulting csv into notebook