# Covid19_Data_Analytics
Welcome to the Covid19_Data_Analytics project! This repository houses a comprehensive analysis of COVID-19 data recorded from January 2019 to December 2020. Leveraging PostgreSQL for data storage and Python for data download and loading, this project aims to provide valuable insights into the global impact of the pandemic.

# Project Structure
1. SQL File (covid_analysis_queries.sql):
- Contains all SQL queries for data analysis.
- Defines the database schema, creates tables, and performs analysis queries.
2. Python Script (download_and_load_data.py):
- Downloads the COVID-19 data CSV file from a provided link.
- Loads the data into the PostgreSQL database.
3. Outputs Folder:
- Contains screenshots of the outputs from running the SQL queries.
4. Environment Variables (.env file):
- Create an .env file in the root directory.
DB_USER=your_postgres_username
DB_PASSWORD=your_postgres_username
DB_HOST=your_hostname
DB_PORT=your_port
DB_NAME=your_database_name


Add the following variables and replace placeholders with your actual credentials:

# Instructions for Use
1. Database Setup:
- Execute the SQL file (covid_analysis_queries.sql) in PostgreSQL to create the database and tables.
2. Data Loading:
- Run the Python script (download_and_load_data.py) to download and load the COVID-19 data into the database.
3. SQL Queries:
- Execute the queries in the SQL file to perform various analyses on the COVID-19 data.

# Additional Notes
- Replace placeholders such as 'your_postgres_username' and 'your_postgres_password' in the Python script with your actual PostgreSQL credentials.
- Ensure that the required Python libraries (pandas and sqlalchemy) are installed before running the script.
- Screenshots of query outputs can be found in the 'outputs' folder.

Feel free to explore the SQL queries and adapt the project structure as needed for your analysis.