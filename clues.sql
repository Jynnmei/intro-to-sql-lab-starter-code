-- Clue #1: 
-- We recently got word that someone fitting Carmen Sandiego's description has been traveling through Southern Europe. 
-- She's most likely traveling someplace where she won't be noticed, so find the least populated country in Southern Europe, 
-- and we'll start looking for her there.
 
-- Write SQL query here
SELECT name
FROM countries
WHERE region = 'Southern Europe'
ORDER BY population
LIMIT 1;


-- Clue #2: 
-- Now that we're here, we have insight that Carmen was seen attending language classes in this country's 
-- officially recognized language. Check our databases and find out what language is spoken in this country, 
-- so we can call in a translator to work with you.

-- Write SQL query here
SELECT countrylanguages.language
FROM countrylanguages
JOIN countries ON countries.code = countrylanguages.countrycode
WHERE countries.name = 'Holy See (Vatican City State)'
AND countrylanguages.isofficial = true;

-- Clue #3: 
-- We have new news on the classes Carmen attended – our gumshoes tell us she's moved on to a 
-- different country, a country where people speak only the language she was learning. Find out which nearby 
-- country speaks nothing but that language.

-- Write SQL query here
SELECT countries.name
FROM countries
JOIN countrylanguages ON countrylanguages.countrycode = countries.code
WHERE countrylanguages.language = 'Italian';

-- Clue #4: 
-- We're booking the first flight out – maybe we've actually got a chance to catch her this time. 
-- There are only two cities she could be flying to in the country. One is named the same as the country – that would be too obvious. 
-- We're following our gut on this one; find out what other city in that country she might be flying to.

-- Write SQL query here
SELECT countries.name AS country_name,
COUNT(cities.id) AS city_count
FROM countries
JOIN cities ON countries.code = cities.countrycode
WHERE countries.name IN ('Argentina', 'Australia', 'Belgium', 'Brazil', 'Canada', 'Switzerland', 'Germany', 'France', 'Italy', 'Liechtenstein', 'Luxembourg', 'Monaco', 'San Marino', 'United States', 'Holy See (Vatican City State)')
GROUP BY countries.name
HAVING COUNT(cities.id) = 2;

SELECT countries.name AS country_name, cities.name AS city_name
FROM countries
JOIN cities ON cities.countrycode = countries.code
WHERE countries.name IN ('Liechtenstein', 'Monaco', 'San Marino')
AND cities.name <> countries.name;

-- Clue #5: 
-- Oh no, she pulled a switch – there are two cities with very similar names, 
-- but in totally different parts of the globe! She's headed to South America as we speak; 
-- go find a city whose name is like the one we were headed to, but doesn't end the same. 
-- Find out the city, and do another search for what country it's in. Hurry!

-- Write SQL query here
SELECT cities.name AS city_name, countries.name AS country_name
FROM cities
JOIN countries ON cities.countrycode = countries.code
WHERE countries.continent = 'South America'
AND cities.name ILIKE 'Serra%'
AND cities.name <> 'Serravalle'

-- Clue #6: 
-- We're close! Our South American agent says she just got a taxi at the airport, and is headed towards
-- the capital! Look up the country's capital, and get there pronto! Send us the name of where you're headed and we'll
-- follow right behind you!

-- Write SQL query here
SELECT cities.name AS capital_city
FROM countries
JOIN cities ON countries.capital = cities.id
WHERE countries.name = 'Brazil';

-- Clue #7: 
-- She knows we're on to her – her taxi dropped her off at the international airport, and she beat us to 
-- the boarding gates. We have one chance to catch her, we just have to know where she's heading and 
-- beat her to the landing dock. Lucky for us, she's getting cocky. She left us a note (below), 
-- and I'm sure she thinks she's very clever, but if we can crack it, we can finally put her where she belongs – behind bars.


--               Our playdate of late has been unusually fun –
--               As an agent, I'll say, you've been a joy to outrun.
--               And while the food here is great, and the people – so nice!
--               I need a little more sunshine with my slice of life.
--               So I'm off to add one to the population I find
--               In a city of ninety-one thousand and now, eighty five.


-- We're counting on you, gumshoe. Find out where she's headed, send us the info, and we'll be sure to meet 
-- her at the gates with bells on.

-- Write SQL query here
SELECT cities.name AS city_name, countries.name AS country_name, cities.population
FROM cities
INNER JOIN countries ON cities.countrycode = countries.code
WHERE cities.population BETWEEN 91080 AND 91085
ORDER BY cities.population DESC;