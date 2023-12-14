--Average daily volume per quarter

WITH volume_by_day as (
    SELECT timestamp::date date,
           SUM(volume) volume
    FROM etl.stock_prices
    GROUP BY date
)
SELECT extract(year from date)*100+extract(quarter from date) quarter,
       AVG(volume)::decimal(20,2) avg_daily_volume
FROM volume_by_day
WHERE extract(year from date) = 2020
GROUP BY quarter

;

--Monthly volume and the weight in the year (check seasonality)

SELECT symbol,
       extract(month from timestamp)::int as month,
       extract(year from timestamp)::int as year,
       SUM(volume) volume,
       SUM(volume)::numeric/
       SUM(SUM(volume)) OVER(PARTITION BY extract(year from timestamp),symbol) volume_percentage,
       SUM(SUM(volume)) OVER(PARTITION BY extract(year from timestamp),symbol) year_volume
FROM etl.stock_prices
GROUP BY month,
         symbol,
         year,
         extract(year from timestamp)
ORDER BY year,symbol
;
-----------------------------------------------------------

--Creating  continuous aggregate tables

-----------------------------------------------------------

DROP MATERIALIZED VIEW IF EXISTS  daily_stocks_data;
CREATE MATERIALIZED VIEW daily_stocks_data
WITH (timescaledb.continuous) AS
    SELECT
        time_bucket('1 day', timestamp) AS date,
        symbol,
        FIRST(close, timestamp) AS "open",
        MAX(close) AS high,
        MIN(close) AS low,
        LAST(close, timestamp) AS "close",
        LAST(close, timestamp) AS day_volume
    FROM etl.stock_prices
    GROUP BY date, symbol;

--Querying the materialized view with the continuous aggregate
SELECT * FROM daily_stocks_data

