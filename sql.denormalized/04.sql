-- Count the number of English tweets containing the word "coronavirus"

-- SELECT
--     count(*)
-- FROM (
-- 	SELECT distinct data->>'id' AS id_tweets, data->>'lang' AS lang
--     FROM tweets_jsonb
--     WHERE to_tsvector('english', coalesce(data->>'text', data->'extended_tweet'->>'full_text')) @@ to_tsquery('english','coronavirus')
-- ) as t 
-- WHERE lang='en'
-- ;

SELECT count(DISTINCT data->>'id')
FROM tweets_jsonb
WHERE to_tsvector('english', coalesce(data->'extended_tweet'->>'full_text', data->>'text')) @@ to_tsquery('english', 'coronavirus')
AND data->>'lang' = 'en'
;

