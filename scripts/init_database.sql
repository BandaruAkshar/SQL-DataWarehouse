/*
======================================
Create Database and Schemas
======================================

Purpose:
This script creates a new database (DataWarehouse) after checking for its presence
If the database exists then it will be dropped and recreated. Along with this the three different schemas
are set up which are bronze,silver,gold

WARNING:
If the script is run the database DataWarehouse will be deleted soo please ensure that proper backup is present.
*/

-- Create Database 'DataWarehouse'
USE master;
GO

-- Check if the required database is already present 
IF EXISTS(SELECT 1 FROM sys.databases WHERE name='DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END
GO
-- Create database DataWarehouse
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
