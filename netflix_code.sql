-- Wrapped data in a CTE to update column names
WITH cleaned_data AS (
  SELECT string_field_0 AS show_id, 
         string_field_1 AS type, 
         string_field_2 AS title, 
         string_field_3 AS director, 
         string_field_4 AS actors, 
         string_field_5 AS country,
         string_field_6 AS date_added,
         string_field_7 AS release_year,
         string_field_8 AS rating,
         string_field_9 AS duration,
         string_field_10 AS listed_in,
         string_field_11 AS description
  FROM netflix_capstone_project.netflix_data_original
),
-- Split genres by ',' delimiter and remove whitespace
genres_data AS (
  SELECT type, 
         title,
         rating,
         release_year,
         -- filled in null values
         IFNULL(director, 'Unknown') AS director, 
         IFNULL(actors, 'Unknown') AS actors,
         IFNULL(country, 'Unknown') AS country,
         TRIM(genre) AS genre
  FROM cleaned_data,
  UNNEST(SPLIT(cleaned_data.listed_in, ',')) AS genre
  -- Removed outlier data of genre listed as 'listed_in'
  WHERE LOWER(TRIM(genre)) != 'listed_in'
),
-- Mapping table to consolidate genres
genre_mapping AS (
  SELECT 'International Movies' AS original_genre, 'International' AS consolidated_genre UNION ALL
  SELECT 'Dramas', 'Drama' UNION ALL
  SELECT 'TV Dramas', 'Drama' UNION ALL
  SELECT 'Comedies', 'Comedy' UNION ALL
  SELECT 'TV Comedies', 'Comedy' UNION ALL
  SELECT 'International TV Shows', 'International' UNION ALL
  SELECT 'Documentaries', 'Documentary' UNION ALL
  SELECT 'Docuseries', 'Documentary' UNION ALL
  SELECT 'Action', 'Action & Adventure' UNION ALL
  SELECT 'Action & Adventure', 'Action & Adventure' UNION ALL
  SELECT 'TV Action & Adventure', 'Action & Adventure' UNION ALL
  SELECT 'Independent Movies', 'Independent' UNION ALL
  SELECT 'Children & Family Movies', 'Family' UNION ALL
  SELECT 'Kids TV', 'Family' UNION ALL
  SELECT 'Romantic Movies', 'Romance' UNION ALL
  SELECT 'Romantic TV Shows', 'Romance' UNION ALL
  SELECT 'Thrillers', 'Thriller' UNION ALL
  SELECT 'Crime TV Shows', 'Crime' UNION ALL
  SELECT 'Music & Musicals', 'Music' UNION ALL
  SELECT 'TV Mysteries', 'TV' UNION ALL
  SELECT 'Science & Nature TV', 'TV' UNION ALL
  SELECT 'TV Sci-Fi & Fantasy', 'TV' UNION ALL
  SELECT 'TV Horror', 'TV' UNION ALL
  SELECT 'Anime Features', 'Anime' UNION ALL
  SELECT 'Cult Movies', 'Cult' UNION ALL
  SELECT 'Teen TV Shows', 'Teen' UNION ALL
  SELECT 'Faith & Spirituality', 'Faith & Spirituality' UNION ALL
  SELECT 'TV Thrillers', 'TV' UNION ALL
  SELECT 'Movies', 'Movies' UNION ALL
  SELECT 'Stand-Up Comedy & Talk Shows', 'Comedy' UNION ALL
  SELECT 'Classic & Cult TV', 'Cult' UNION ALL
  SELECT 'TV Shows', 'TV' UNION ALL
  SELECT 'listed_in', NULL UNION ALL -- Exclude this genre
  SELECT 'Sci-fi', 'Sci-Fi' UNION ALL
  SELECT 'Sci-Fi & Fantasy', 'Sci-Fi' UNION ALL
  SELECT 'Horror', 'Horror' UNION ALL
  SELECT 'Horror Movies', 'Horror' UNION ALL
  SELECT 'Action & Adventure', 'Action'
),
-- Replace and consolidate genres based on the mapping. Joining consolidated genres and genres_data table.
consolidated_genres AS (
  SELECT type, 
        rating,
         title, 
         release_year,
         director, 
         actors,
         country,
         COALESCE(m.consolidated_genre, g.genre) AS genre
  FROM genres_data g
  LEFT JOIN genre_mapping m
  ON g.genre = m.original_genre
)
-- Count and sort the consolidated genres, excluding null genres
, enriched_genre_count AS (
  SELECT genre,
        type, 
        rating,
         title, 
         release_year,
         director, 
         actors,
       COUNT(*) AS genre_count
FROM consolidated_genres
WHERE genre IS NOT NULL
GROUP BY 1, 2, 3, 4, 5, 6, 7
ORDER BY genre_count DESC)
SELECT *
FROM enriched_genre_count;
