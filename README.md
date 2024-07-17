Netflix Dataset Analysis

This repository contains an analysis of a Netflix dataset, focusing on cleaning, transforming, and consolidating genre information for better insights.

Dataset Description
The dataset used for this analysis is a collection of Netflix show and movie listings, including various attributes such as title, director, actors, country, date added, release year, rating, duration, listed genres, and descriptions.

SQL Code
The SQL code provided performs the following steps to clean and transform the data:

Cleaned Data (CTE): Renames the columns for better readability and use in subsequent queries.
Genres Data (CTE): Splits the genre information by commas, trims whitespace, and fills in null values for director, actors, and country.
Genre Mapping (CTE): Creates a mapping table to consolidate similar genres into a unified set of genres.
Consolidated Genres (CTE): Replaces original genres with consolidated genres based on the mapping table.
Enriched Genre Count (CTE): Counts and sorts the consolidated genres, excluding null values.


How to Use

Clone the repository.

Connect to your SQL database.

Execute the SQL code to clean and transform the Netflix dataset.

Analyze the output to gain insights into the genre distribution and other attributes.

Contributions

Feel free to open issues or submit pull requests if you have suggestions for improving the analysis or code.


Contact

For any questions or feedback, please contact Jenna Torrisi
