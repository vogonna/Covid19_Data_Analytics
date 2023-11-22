-- Create a database
CREATE DATABASE covid19;

-- Connect to the created database
\c covid19

-- Create a table called covid_19_data
CREATE TABLE covid_19_data (
    ObservationDate DATE,
    Province VARCHAR(255),
    Country VARCHAR(255),
    Confirmed INT,
    Deaths INT,
    Recovered INT
);

-- Defining ObservationDate as DATE type
ALTER TABLE covid_19_data
ALTER COLUMN observationdate TYPE DATE
USING TO_DATE(observationdate, 'MM/DD/YYYY');

 
-- 1. Retrieve the total confirmed, death, and recovered cases.
SELECT
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM
    covid_19_data;

-- 2. Retrieve the total confirmed, deaths and recovered cases for the first quarter of each year of observation. 
SELECT
    EXTRACT(YEAR FROM ObservationDate) AS ObservationYear,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM
    covid_19_data
WHERE
    EXTRACT(MONTH FROM ObservationDate) BETWEEN 1 AND 3
GROUP BY
    ObservationYear
ORDER BY
    ObservationYear;

-- 3. Retrieve a summary of all the records. 
SELECT
    Country,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM
    covid_19_data
GROUP BY
    Country
ORDER BY
    TotalConfirmed DESC;

-- 4. Retrieve the percentage increase in the number of death cases from 2019 to 2020.
WITH DeathCases AS (
    SELECT
        EXTRACT(YEAR FROM ObservationDate) AS ObservationYear,
        SUM(Deaths) AS TotalDeaths
    FROM
        covid_19_data
    GROUP BY
        ObservationYear
)
SELECT
    (d2020.TotalDeaths - d2019.TotalDeaths) * 100.0 / d2019.TotalDeaths AS DeathIncreasePercentage
FROM
    DeathCases d2019
JOIN
    DeathCases d2020 ON d2019.ObservationYear = 2019 AND d2020.ObservationYear = 2020;


-- 5. Retrieve information for the top 5 countries with the highest confirmed cases.
SELECT
    Country,
    SUM(Confirmed) AS TotalConfirmed,
    SUM(Deaths) AS TotalDeaths,
    SUM(Recovered) AS TotalRecovered
FROM
    covid_19_data
GROUP BY
    Country
ORDER BY
    TotalConfirmed DESC
LIMIT 5;

-- 6. Compute the total number of drop (decrease) or increase in the confirmed cases from month to month in the 2 years of observation.
SELECT
    EXTRACT(MONTH FROM CAST(ObservationDate AS DATE)) AS ObservationMonth,
    EXTRACT(YEAR FROM CAST(ObservationDate AS DATE)) AS ObservationYear,
    SUM(Confirmed) - COALESCE(LAG(SUM(Confirmed)) OVER (ORDER BY EXTRACT(YEAR FROM CAST(ObservationDate AS DATE)), EXTRACT(MONTH FROM CAST(ObservationDate AS DATE))), 0) AS MonthlyConfirmedChange
FROM
    covid_19_data
GROUP BY
    ObservationYear, ObservationMonth
ORDER BY
    ObservationYear, ObservationMonth;
