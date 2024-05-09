CREATE INDEX CONCURRENTLY denorm1 ON tweets_jsonb USING GIN ((data->'entities'->'hashtags'), (data->'extended_tweet'->'entities'->'hashtags'));
CREATE INDEX CONCURRENTLY denorm2 ON tweets_jsonb USING GIN (to_tsvector('english', COALESCE(data->>'text', '')));
CREATE INDEX CONCURRENTLY denorm3 ON tweets_jsonb USING GIN (to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', '')));
CREATE INDEX CONCURRENTLY denorm4 ON tweets_jsonb USING GIN (to_tsvector('english', data->>'text'))
CREATE INDEX CONCURRENTLY denorm5 ON tweets_jsonb USING GIN (to_tsvector('english', data->'extended_tweet'->>'full_text'));
CREATE INDEX query4 ON tweets_jsonb USING GIN(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))) WHERE (data->>'lang'='en');

