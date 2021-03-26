files='
test-data.zip
'

for file in $files; do
    # call the load_tweets.py file to load data into pg_normalized
    python3.6 load_tweets.py --db postgresql://postgres:pass@localhost:21132/ --inputs $file
done

for file in $files; do
    # use SQL's COPY command to load data into pg_denormalized
    unzip -p $file | sed 's/\\u0000//g' | psql postgres://postgres:pass@localhost:11132/ -c "COPY tweets_jsonb (data) FROM STDIN csv quote e'\x01' delimiter e'\x02';"

    #postgresql//username:password@host:port/database

done
