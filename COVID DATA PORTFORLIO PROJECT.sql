DELETE FROM MySQLPortfolioProject..CovidDeaths
WHERE continent = '0';

-- TOTAL COVID CASES BY COUNTRIES:
SELECT location, SUM(new_cases) AS total_cases
FROM MySQLPortfolioProject..CovidDeaths
GROUP BY location
ORDER BY total_cases DESC

--PERCENT OF COVID CASES BY COUNTRIES IN DESCENDING ORDER:
SELECT location, SUM(new_cases) AS total_cases
,ROUND(SUM(new_cases)*100/(SELECT SUM(new_cases) FROM MySQLPortfolioProject..CovidDeaths),2) AS percent_of_total_cases
FROM MySQLPortfolioProject..CovidDeaths
GROUP BY location
ORDER BY percent_of_total_cases DESC

--PERCENT OF TOTAL COVID CASES BETWEEN NIGERIA AND UNITED KINGDOM:
SELECT location, ROUND(SUM(new_cases)*100/(SELECT SUM(new_cases)FROM MySQLPortfolioProject..CovidDeaths),4) AS percent_of_total_cases
FROM MySQLPortfolioProject..CovidDeaths
WHERE location IN ('nigeria','united kingdom')
GROUP BY location
ORDER BY percent_of_total_cases

--PERCENT OF TOTAL COVID CASES BETWEEN AUSTRALIA, CANADA, FRANCE, GERMANY, UNITED KINGDOM AND UNITED STATES:
SELECT location, ROUND(SUM(new_cases)*100/(SELECT SUM(new_cases)FROM MySQLPortfolioProject..CovidDeaths),3) AS percent_of_total_cases
FROM MySQLPortfolioProject..CovidDeaths
WHERE location IN ('australia','canada','france','germany','united kingdom','united states')
GROUP BY location
ORDER BY percent_of_total_cases DESC




--TOTAL COVID DEATHS BY COUNTRIES:
SELECT location, SUM(new_deaths)AS total_covid_deaths
FROM MySQLPortfolioProject..CovidDeaths
GROUP BY location
ORDER BY total_covid_deaths DESC


--PERCENT OF COVID DEATHS BY COUNTRIES IN DESCENDING ORDER:
SELECT location, 
ROUND(SUM(new_deaths)*100/(SELECT SUM(new_deaths) FROM MySQLPortfolioProject..CovidDeaths),3)  AS percent_of_total_deaths
FROM MySQLPortfolioProject..CovidDeaths
GROUP BY location
ORDER BY percent_of_total_deaths DESC

--PERCENT OF TOTAL COVID DEATHS BETWEEN NIGERIA AND UNITED KINGDOM:
SELECT location, 
ROUND(SUM(new_deaths)*100/(SELECT SUM(new_deaths) FROM MySQLPortfolioProject..CovidDeaths),3) AS percent_of_total_deaths
FROM MySQLPortfolioProject..CovidDeaths
WHERE location IN ('nigeria','united kingdom')
GROUP BY location
ORDER BY percent_of_total_deaths DESC

--PERCENT OF TOTAL COVID DEATHS BETWEEN AUSTRALIA, CANADA, FRANCE, GERMANY, UNITED KINGDOM AND UNITED STATES:
SELECT location, 
ROUND(SUM(new_deaths)*100/(SELECT SUM(new_deaths) FROM MySQLPortfolioProject..CovidDeaths), 4) AS percent_of_total_deaths
FROM MySQLPortfolioProject..CovidDeaths
WHERE location IN ('australia','canada','france','germany','united kingdom','united states')
GROUP BY location
ORDER BY percent_of_total_deaths DESC


--TOTAL COVID TESTS BY COUNTRIES:
SELECT location, SUM(new_tests) AS total_tests
FROM MySQLPortfolioProject..CovidVaccinations
GROUP BY location
ORDER BY total_tests DESC

--TOTAL COVID TESTS BY COUNTRIES VS TOTAL CASES BY COUNTRIES VS TOTAL DEATHS BY COUNTRIES
SELECT dea.location, MAX(vac.total_tests) AS total_tests,
MAX(dea.total_cases) AS total_cases,
MAX(dea.total_deaths)
FROM MySQLPortfolioProject..CovidDeaths dea
JOIN MySQLPortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
GROUP BY dea.location
ORDER BY total_cases DESC



--PERCENT OF TOTAL COVID TESTS BY COUNTRIES VS PERCENT OF TOTAL COVID CASES BY COUNTRIES VS PERCENT OF TOTAL COVID DEATHS BY COUNTRIES ORDER BY THE HIGHEST DEATHS PERCENT
SELECT dea.location,
ROUND(MAX(vac.total_tests)*100/(SELECT SUM(vac.new_tests) FROM MySQLPortfolioProject..CovidVaccinations vac),4) AS percent_total_tests, 
ROUND(MAX(dea.total_cases)*100/(SELECT SUM(dea.new_cases) FROM MySQLPortfolioProject..CovidDeaths dea),4) AS percent_total_cases,
ROUND(MAX(dea.total_deaths)*100/(SELECT SUM(dea.new_deaths) FROM MySQLPortfolioProject..CovidDeaths dea),4) AS percent_total_deaths
FROM MySQLPortfolioProject..CovidDeaths dea
JOIN MySQLPortfolioProject..CovidVaccinations vac
ON dea.location = vac.location
GROUP BY dea.location
ORDER BY percent_total_deaths DESC


