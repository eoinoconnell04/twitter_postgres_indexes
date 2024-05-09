 -- Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
-- top 1000 hastags used in tweets that have coronavirus

SELECT
'#' || hashtag as tag,
count(*) 
FROM (
    SELECT DISTINCT
    data->>'id' AS id,
    jsonb_array_elements(data->'entities'->'hashtags' ||
            COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' AS hashtag
    FROM tweets_jsonb
    WHERE to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')) @@
    to_tsquery('english','coronavirus')
    AND data->>'lang' = 'en'
) t
GROUP BY tag
ORDER BY count DESC, tag
LIMIT 1000;

/*
SELECT
    '#' || t.tag,
    count(*) as count

FROM (
    -- case 1
SELECT DISTINCT
data->>'id' AS id_tweets,
jsonb_array_elements(data->'entities'->'hashtags')->>'text' AS tag
FROM tweets_jsonb
WHERE to_tsvector('english',data->>'text') @@ to_tsquery('english','coronavirus') AND data->>'lang' = 'en'

UNION
-- case 2
SELECT DISTINCT
data->>'id' AS id_tweets,
jsonb_array_elements(data->'entities'->'hashtags')->>'text' AS tag
FROM tweets_jsonb
WHERE to_tsvector('english',data->'extended_tweet'->>'full_text') @@ to_tsquery('english','coronavirus') AND data->>'lang' = 'en'
) t
GROUP BY t.tag 
ORDER BY count DESC,t.tag
LIMIT 1000;
*/
