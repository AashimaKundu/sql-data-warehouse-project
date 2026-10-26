
-- 1. Switch to the master database.
USE master;
GO


-- 2. Create database 'DataWarehouse'
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO
CREATE DATABASE DataWarehouse;
GO


-- 3. Switch to the 'DataWarehouse'
USE DataWarehouse;
GO


-- 4. Whenever you create a Database, the next step is to create schemas.
-- Schemas will help us to keep the thing organized in the database.
-- We will create a schema for every layer : Bronze, Silver, Gold.

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
-- Now, we can go and create each layer separately.









