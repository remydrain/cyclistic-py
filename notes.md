# Description
These are notes of my process as things come up. Normally I'd add this document to my gitignore file, but I'm putting it here as an insight to my analysis (and learning) process.

## To Do
- [ ] Station names and IDs

## BigQuery
* Some of the tables are missing station names and ids
    * Decide later whether to join in SQL or Py
* Aggregating min and max latitude and longitude to get a sense of the overall coverage area and to filter down weather table
* Created a view called "minmax" that I can swap out the table name for each month to create a view that I can then query get the overall min and max lat and long
* 202211 has 0.0 as the min_lat_end and min_lng_end after first query to find minmax
    * Added a WHERE clause to exclude 0.0
    * Returned expected range of values - saving WHERE clause to view