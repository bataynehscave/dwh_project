/* 
=======================
Create Database and Schemas
=======================

This script creates a new database called 'DataWarehouse'
 and three schemas: bronze, silver, and gold. following the
 madellion architecture.

If the data base already exists it will be dropped and recreated.

WARNING: 
This script will drop the 'DataWarehouse' database if it exists.
All data in the database will be lost.
=======================

 */

-- Connect to the 'postgres' database 
\c postgres;

-- Stop connections with database
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'DataWarehouse';

-- Drop the DataWarehouse database if it exists
DROP DATABASE IF EXISTS "DataWarehouse";

-- Create the DataWarehouse database
CREATE DATABASE "DataWarehouse";

-- Connect to the new database
\c "DataWarehouse";

-- Create schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
