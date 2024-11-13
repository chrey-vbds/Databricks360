-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Delete All Silver
-- MAGIC ---
-- MAGIC This notebook deletes the silverdb.
-- MAGIC it needs two parameters:
-- MAGIC * the catalog (default catadb360dev)
-- MAGIC * the databasename (default silverdb)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.widgets.text('catalogname', 'catadb360dev')
-- MAGIC dbutils.widgets.text('dbname', 'silverdb')

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalogname = dbutils.widgets.get('catalog')
-- MAGIC dbname = dbutils.widgets.get('dbname')

-- COMMAND ----------

use catalog ${catalogname}

-- COMMAND ----------

drop schema if exists ${dbname} cascade
