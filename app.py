from pyspark.sql import SparkSession
spark = SparkSession.builder.appName("Sales Pipeline").getOrCreate()

##