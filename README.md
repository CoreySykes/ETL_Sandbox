# ETL_Sandbox
Basic repository for sampling/playing around with new data sets and testing new techniques for ETL.

# Projects

* **Auto Generating Server Logs**
    * This project is a real-time streaming sample of Apache logs. There is a data generation script using Faker() that will auto-generate Apache logs and a second listener script that reads each line as it's streaming, parses it, and then stores it in a MySQL instance.
    * Future sandbox playing around may be involving some real-time SQL queries and building real-time visualizations.

* **Mobile Strategy Games***
    * This project just simply uses a data set from Kaggle and reads it in, parses it, and stores it in a database by auto-generating DDL statements to build the table and queries to write the data into the database.