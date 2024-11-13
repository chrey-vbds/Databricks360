-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Create Silverdb and Tables
-- MAGIC ---
-- MAGIC This notebook creates the silver db and the tables as they're going to be imported as delta to silver.
-- MAGIC It also sets the table properties of the tables to enable the Delta Change Data Feed feature, which
-- MAGIC is then used to load the gold tables.
-- MAGIC
-- MAGIC Parameters in use:
-- MAGIC * catalog (default catadb360dev)
-- MAGIC * dbname (default silverdb)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.widgets.text('catalogname', 'catadb360dev')
-- MAGIC dbutils.widgets.text('dbname', 'silverdb')

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalogname = dbutils.widgets.get('catalogname')
-- MAGIC dbname = dbutils.widgets.get('dbname')
-- MAGIC

-- COMMAND ----------

use catalog ${catalogname}

-- COMMAND ----------

create schema if not exists ${dbname}

-- COMMAND ----------

use schema ${dbname}

-- COMMAND ----------

create table if not exists ${dbname}.addresses (
    addressId int,
    state string,
    streetno int,
    street string,
    city string,
    zip int
)
using delta
TBLProperties (delta.enableChangeDataFeed = true)

-- COMMAND ----------

create table if not exists ${dbname}.customers (
    customerid int,
    firstName string,
    lastName string,
    customerType string,
    birthDate date,
    ssn string,
    email string,
    phone string,
    fkaddress int
)
using delta
TBLProperties (delta.enableChangeDataFeed = true)

-- COMMAND ----------

create table if not exists  ${dbname}.menuesconsumed (
    menueId int,
    foodName string,
    foodCategory string,
    cost double,
    dinnerDate date,
    fkcustomer int,
    fkrestaurant int,
    fkwaiter int,
    tableId int
)
using delta
TBLProperties (delta.enableChangeDataFeed = true)

-- COMMAND ----------

create table if not exists ${dbname}.restaurants (
    restaurantId int,
    restaurantName string,
    noOfTables int,
    staffCount int,
    phone string,
    email string,
    fkaddress int
)
using delta
TBLProperties (delta.enableChangeDataFeed = true)

-- COMMAND ----------

show tables
