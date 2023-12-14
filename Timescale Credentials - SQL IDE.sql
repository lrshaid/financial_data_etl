 /****  GET STARTED WITH YOUR TIMESCALE SERVICE  ****/


/*
SERVICE INFORMATION:

Service name:  ts-41865
Database name: tsdb
Username:      tsdbadmin
Password:      d88yw2l8yymw962c
Service URL:   postgres://tsdbadmin:d88yw2l8yymw962c@huyo5i1err.xa55mciuki.tsdb.cloud.timescale.com:32446/tsdb?sslmode=require
Port:          32446


~/.pg_service.conf
echo "
[ts-41865]
host=huyo5i1err.xa55mciuki.tsdb.cloud.timescale.com
port=32446
user=tsdbadmin
password=d88yw2l8yymw962c
dbname=tsdb
" >> ~/.pg_service.conf
psql -d "service=ts-41865"
*/

----------------------------------------------------------------------------

/*
 ╔╗
╔╝║
╚╗║
 ║║         CONNECT TO YOUR SERVICE
╔╝╚╦╗
╚══╩╝

 ​
1. Install psql:
    https://blog.timescale.com/blog/how-to-install-psql-on-mac-ubuntu-debian-windows/

2. From your command line, run:
    psql "postgres://tsdbadmin:d88yw2l8yymw962c@huyo5i1err.xa55mciuki.tsdb.cloud.timescale.com:32446/tsdb?sslmode=require"
*/

----------------------------------------------------------------------------

/*
╔═══╗
║╔═╗║
╚╝╔╝║
╔═╝╔╝	    CREATE A HYPERTABLE
║ ╚═╦╗
╚═══╩╝
*/

CREATE TABLE conditions (	-- create a regular table
    time        TIMESTAMPTZ       NOT NULL,
    location    TEXT              NOT NULL,
    temperature DOUBLE PRECISION  NULL
);

SELECT create_hypertable('conditions', 'time');	-- turn it into a hypertable

----------------------------------------------------------------------------

/*
╔═══╗
║╔═╗║
╚╝╔╝║
╔╗╚╗║      INSERT DATA
║╚═╝╠╗
╚═══╩╝
*/

INSERT INTO conditions
  VALUES
    (NOW(), 'office', 70.0),
    (NOW(), 'basement', 66.5),
    (NOW(), 'garage', 77.0);
​
----------------------------------------------------------------------------

/*
FOR MORE DOCUMENTATION AND GUIDES, VISIT	>>>--->	HTTPS://DOCS.TIMESCALE.COM/
*/