import pandas as pd
import os
import requests
from io import StringIO
from sqlalchemy import create_engine  

# READ CSV DATA
# Google Drive file ID
file_id = "1SzmRIwlpL5PrFuaUe_1TAcMV0HYHMD_b"
# Download link
download_link = f"https://drive.google.com/uc?id={file_id}"
# Make a request to download the file
response = requests.get(download_link)

# Check if the request was successful (status code 200)
if response.status_code == 200:
    # Read the CSV content from the response
    csv_content = StringIO(response.text)
    # Read the CSV into a Pandas DataFrame
    df = pd.read_csv(csv_content)
    # Extract relevant columns
    df_transformed = df[['ObservationDate', 'Province', 'Country', 'Confirmed', 'Deaths', 'Recovered']]
    print('CSV read successfully')
    # Rename columns for consistency
    df_transformed.columns = ['observationdate', 'province', 'country', 'confirmed', 'deaths', 'recovered']
    
    # LOAD DATA TO POSTGRES
    # PostgreSQL connection string
    # Replace 'your_username', 'your_password', 'your_host', 'your_port', and 'your_database' with your actual credentials
    connection_string = f"postgresql://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"
    # Create a SQLAlchemy engine
    engine = create_engine(connection_string)
    # Replace 'your_table_name' with the desired table name
    table_name = 'covid_19_data'
    # Write the transformed DataFrame to PostgreSQL
    df_transformed.to_sql(table_name, engine, index=False, if_exists='replace')
    print(f"Data loaded into PostgreSQL table '{table_name}' successfully.")
else:
    print(f"Failed to download the file.")