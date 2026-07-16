# Query 1: Count the number of Pokémon by type in descending order.
SELECT
    t.name_type AS type,
    COUNT(DISTINCT pt.pokedex_number) AS count
FROM pokemontype pt
JOIN types t
    ON pt.type_id = t.type_id
GROUP BY t.name_type
ORDER BY count DESC;

# Query 2: List Pokémon with a base number of points greater than 600, sorted in descending order.
SELECT 
    p.name, p.base_total 
FROM pokemon p 
WHERE base_total>600 
ORDER BY base_total DESC;

# Query 3: Display Pokémon types with average points in ascending order
SELECT 
    t.name_type, AVG(p.base_total) as average_base_total 
FROM pokemon p 
JOIN pokemontype pt 
    ON p.pokedex_number=pt.pokedex_number 
JOIN types t 
    ON pt.type_id=t.type_id 
GROUP BY t.name_type 
ORDER BY average_base_total ASC;

# Query 4: Find Pokémon with the special ability 'Overgrow' and sort by the points base in descending order.
SELECT 
    p.name, base_total as average_base_total 
FROM pokemon p 
JOIN pokemonability pa 
    ON p.pokedex_number=pa.pokedex_number 
JOIN abilities a 
    ON pa.ability_id=a.ability_id 
WHERE a.name_ability='Overgrow' 
ORDER BY average_base_total DESC;

# Query 5: List the names of the Pokémon, their main type and their secondary type (if they have one). Sort by name.
SELECT
    p.name,
    (ARRAY_AGG(t.name_type ORDER BY pt.ctid))[1] AS primary_type,
    (ARRAY_AGG(t.name_type ORDER BY pt.ctid))[2] AS secondary_type
FROM pokemon p
JOIN pokemontype pt
    ON p.pokedex_number = pt.pokedex_number
JOIN types t
    ON pt.type_id = t.type_id
GROUP BY
    p.pokedex_number,
    p.name
ORDER BY
    p.name;

# Request 6: Display Pokémon with above-average total stats per generation.
SELECT
    p.name,
    p.generation,
    p.base_total AS total_stats
FROM pokemon p
JOIN (
    SELECT
        generation,
        AVG(base_total) AS avg_total
    FROM pokemon
    GROUP BY generation
) a
    ON p.generation = a.generation
WHERE p.base_total > a.avg_total
ORDER BY
    p.generation,
    p.name;
    
# Query 7: Find fire-type Pokémon with an attack greater than 100.
SELECT
    p.name, s.attack
FROM pokemon p
JOIN stats s
    ON p.pokedex_number=s.pokedex_number
JOIN pokemontype pt
    ON p.pokedex_number=pt.pokedex_number
JOIN types t
    ON pt.type_id=t.type_id
WHERE t.name_type='fire' AND s.attack>100;

# Query 8: Indicate whether a Pokémon's total stats are above or below the generation average.
# NOTE: this query is flawed: what aboutthe case that total state = the generation average? should not be shown?
SELECT
    p.name,
    p.generation,
    p.base_total AS total_stats,
    CASE
        WHEN p.base_total > a.avg_total THEN 'Above the generation average'
        WHEN p.base_total < a.avg_total THEN 'Below the generation average'
        ELSE 'Equal the generation average (not required)'
    END AS total_stats_comparison
FROM pokemon p
JOIN (
    SELECT
        generation,
        AVG(base_total) AS avg_total
    FROM pokemon
    GROUP BY generation
) a
    ON p.generation = a.generation

ORDER BY
    p.generation,
    p.name;
