from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Sales Pipeline") \
    .getOrCreate()

df = spark.read.csv("data\raw\sales_data.csv", header=True, inferSchema=True)

df.printSchema()
df.show()