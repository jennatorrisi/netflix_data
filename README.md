# My Project - Netflix Data Set

## Tableau Visualization

[![Tableau Visualization](https://public.tableau.com/static/images/WJ/WJYTMDQTH/1.png)](https://public.tableau.com/views/NetflixDataVisualization/WJYTMDQTH?:display_count=n&:origin=viz_share_link)

Click the image above to view the interactive Tableau visualization.

## Netflix Dataset Analysis

This repository contains an analysis of a Netflix dataset, focusing on cleaning, transforming, and consolidating genre information for better insights.

## Dataset Description

The dataset used for this analysis is a collection of Netflix show and movie listings, including various attributes such as title, director, actors, country, date added, release year, rating, duration, listed genres, and descriptions.

## SQL Code

The SQL code provided performs the following steps to clean and transform the data:

1. **Cleaned Data (CTE)**: Renames the columns for better readability and use in subsequent queries.
2. **Genres Data (CTE)**: Splits the genre information by commas, trims whitespace, and fills in null values for director, actors, and country.
3. **Genre Mapping (CTE)**: Creates a mapping table to consolidate similar genres into a unified set of genres.
4. **Consolidated Genres (CTE)**: Replaces original genres with consolidated genres based on the mapping table.
5. **Enriched Genre Count (CTE)**: Counts and sorts the consolidated genres, excluding null values.

## How to Use

1. Clone the repository.
2. Connect to your SQL database.
3. Execute the SQL code to clean and transform the Netflix dataset.
4. Analyze the output to gain insights into the genre distribution and other attributes.

## Contributions

Feel free to open issues or submit pull requests if you have suggestions for improving the analysis or code.
