-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Delete All Gold tables
-- MAGIC ---
-- MAGIC This notebook deletes all the tables in Gold database
-- MAGIC
-- MAGIC Parameters needed:
-- MAGIC * catalog (default catadbdev)
-- MAGIC * dbname (default golddb)

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.widgets.text('catalogname', 'catadb360dev')
-- MAGIC dbutils.widgets.text('dbname', 'golddb')

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalogname = dbutils.widgets.get('catalogname')
-- MAGIC dbname = dbutils.widgets.get('dbname')
-- MAGIC

-- COMMAND ----------

use catalog ${catalogname}

-- COMMAND ----------

drop schema if exists ${dbname} cascade
