-- Calculates the hashtags that are commonly used with the hashtag #coronavirus
-- Find the top 1000 hashtags that are used with #coronavirus


SELECT
    '#' || t.tag as tag,
    count(*) as count

FROM (
    -- case 1
SELECT DISTINCT
data->>'id' AS id_tweets,
jsonb_array_elements(tweets_jsonb.data->'entities'->'hashtags')->>'text' AS tag
FROM tweets_jsonb
WHERE data->'entities'->'hashtags'  @@ '$[*].text=="coronavirus"'

UNION
-- case 2
SELECT DISTINCT
data->>'id' AS id_tweets,
jsonb_array_elements(tweets_jsonb.data->'extended_tweet'->'entities'->'hashtags')->>'text' AS tag
FROM tweets_jsonb
WHERE data->'extended_tweet'->'entities'->'hashtags'  @@ '$[*].text=="coronavirus"'

) as t
GROUP BY t.tag 
ORDER BY count DESC,t.tag
LIMIT 1000;

