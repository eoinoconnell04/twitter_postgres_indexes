-- Calculates the languages that use the hashtag #coronavirus

SELECT
    lang,
    count(DISTINCT id_tweets) as count
FROM (
-- case 1
SELECT distinct data->>'id' AS id_tweets, data->>'lang' AS lang
    FROM tweets_jsonb
    WHERE data ->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
UNION
-- case 2
SELECT distinct data->>'id' AS id_tweets, data->>'lang' AS lang
    FROM tweets_jsonb
    WHERE data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus"'
) as t 
GROUP BY lang
ORDER BY count DESC,lang;
