CREATE INDEX CONCURRENTLY one ON tweet_tags(tag, id_tweets);
CREATE INDEX CONCURRENTLY two ON tweet_tags(id_tweets, tag);
CREATE INDEX CONCURRENTLY three ON tweets(id_tweets, lang);
CREATE INDEX CONCURRENTLY four ON tweets(lang);
CREATE INDEX CONCURRENTLY five ON tweets using gin(to_tsvector('english',text));
