# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Setup

1. Clone the repo
2. While inside the project, run the following:
    
    a. ```bundle ``` - to install dependencies
    
    b. ```rails db:setup``` - to setup the DBs for both test/dev envs. Althought this project is not using a DB I just let it there (just in case)
    
    c. Open ```.env.development``` and add your Nomics ```API_KEY```. If you wish you can also use ```.env.development.local``` which is .gitingored
    
    d. Open a rails console ```rails console``` if you want to start playing with the services.

    e. Start the server ```rails s``` to interact with the API directly
    
## Tests

To run the tests just run ```rspec```

## Services

1. Nomics - the Nomics API Wrapper

2. NomicsFilterBuilder - builds and applies the filters (e.g circulating_supply, max_supply, name, symbol, price) on the Nomics API

3. NomicsPauloadBuilder - prepares the query string for the Nomics API

4. CoinConversion - does the conversion of one crypto to another
    
## Showcase if you use rails console

### 1. Retrieve a list of cryptocurrencies given set of tickers

Ie: Given an array of [‘BTC’, ‘XRP’, ‘ETH’]. I want to get the full payload of those cryptocurrencies

#### Result:
```
irb(main):004:0> Nomics.new.currencies_ticker(tickers: ['BTC', 'SOL'])
=> {:response=>[{"id"=>"BTC", "currency"=>"BTC", "symbol"=>"BTC", "name"=>"Bitcoin", "logo_url"=>"https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg", "status"=>"active", "price"=>"61651.86311979", "price_date"=>"2021-10-15T00:00:00Z", "price_timestamp"=>"2021-10-15T17:50:00Z", "circulating_supply"=>"18844581", "max_supply"=>"21000000", "market_cap"=>"1161803528362", "market_cap_dominance"=>"0.4232", "num_exchanges"=>"393", "num_pairs"=>"66386", "num_pairs_unmapped"=>"5169", "first_candle"=>"2011-08-18T00:00:00Z", "first_trade"=>"2011-08-18T00:00:00Z", "first_order_book"=>"2017-01-06T00:00:00Z", "rank"=>"1", "rank_delta"=>"0", "high"=>"63661.50364774", "high_timestamp"=>"2021-04-13T00:00:00Z", "1d"=>{"volume"=>"64893264534.43", "price_change"=>"4288.52805776", "price_change_pct"=>"0.0748", "volume_change"=>"13913294183.56", "volume_change_pct"=>"0.2729", "market_cap_change"=>"80871787786.86", "market_cap_change_pct"=>"0.0748"}, "7d"=>{"volume"=>"356172039966.92", "price_change"=>"7513.79172355", "price_change_pct"=>"0.1388", "volume_change"=>"10816938780.50", "volume_change_pct"=>"0.0313", "market_cap_change"=>"141941444203.50", "market_cap_change_pct"=>"0.1392"}, "30d"=>{"volume"=>"1495792642884.83", "price_change"=>"13440.11063763", "price_change_pct"=>"0.2788", "volume_change"=>"-46361482127.29", "volume_change_pct"=>"-0.0301", "market_cap_change"=>"254615661595.98", "market_cap_change_pct"=>"0.2807"}, "365d"=>{"volume"=>"21470471241155.51", "price_change"=>"50136.55421146", "price_change_pct"=>"4.3539", "volume_change"=>"10761118614887.98", "volume_change_pct"=>"1.0048", "market_cap_change"=>"948563187696.40", "market_cap_change_pct"=>"4.4483"}, "ytd"=>{"volume"=>"18851503380843.86", "price_change"=>"28771.31819621", "price_change_pct"=>"0.8750", "volume_change"=>"10212169256711.73", "volume_change_pct"=>"1.1821", "market_cap_change"=>"550654714058.34", "market_cap_change_pct"=>"0.9010"}}, {"id"=>"SOL", "currency"=>"SOL", "symbol"=>"SOL", "name"=>"Solana", "logo_url"=>"https://nomics-api.s3.us-east-2.amazonaws.com/static/images/currencies/SOL2.jpg", "status"=>"active", "price"=>"161.12035821", "price_date"=>"2021-10-15T00:00:00Z", "price_timestamp"=>"2021-10-15T17:50:00Z", "circulating_supply"=>"300250397", "max_supply"=>"488630611", "market_cap"=>"48376451526", "market_cap_dominance"=>"0.0176", "num_exchanges"=>"75", "num_pairs"=>"457", "num_pairs_unmapped"=>"27", "first_candle"=>"2020-04-07T00:00:00Z", "first_trade"=>"2020-04-10T00:00:00Z", "first_order_book"=>"2020-04-07T00:00:00Z", "rank"=>"8", "rank_delta"=>"0", "high"=>"191.69870886", "high_timestamp"=>"2021-09-08T00:00:00Z", "1d"=>{"volume"=>"5061130891.89", "price_change"=>"9.22422837", "price_change_pct"=>"0.0607", "volume_change"=>"2167518613.45", "volume_change_pct"=>"0.7491", "market_cap_change"=>"2804618476.68", "market_cap_change_pct"=>"0.0615"}, "7d"=>{"volume"=>"21067693080.66", "price_change"=>"2.08921542", "price_change_pct"=>"0.0131", "volume_change"=>"-9686174060.66", "volume_change_pct"=>"-0.3150", "market_cap_change"=>"758306795.11", "market_cap_change_pct"=>"0.0159"}, "30d"=>{"volume"=>"139858812060.81", "price_change"=>"2.22503237", "price_change_pct"=>"0.0140", "volume_change"=>"-68189193926.04", "volume_change_pct"=>"-0.3278", "market_cap_change"=>"1233167700.14", "market_cap_change_pct"=>"0.0262"}, "365d"=>{"volume"=>"528969941699.23", "price_change"=>"158.90556277", "price_change_pct"=>"71.7473", "volume_change"=>"526708807376.19", "volume_change_pct"=>"232.9401", "market_cap_change"=>"48280223869.19", "market_cap_change_pct"=>"501.7292"}, "ytd"=>{"volume"=>"527346496671.33", "price_change"=>"158.94241189", "price_change_pct"=>"72.9781", "volume_change"=>"523461917320.39", "volume_change_pct"=>"134.7538", "market_cap_change"=>"48274965348.53", "market_cap_change_pct"=>"475.6802"}}], :total_items=>"2"}
```

### 2. Retrieve a (list) specific crypto currency and specific values based on the ticker and any other dynamic params

Ie: We want to view the [circulating_supply, max_supply, name, symbol, price] for [ETH,BTC]

#### Result

```
irb(main):001:0> Nomics.new.currencies_ticker(tickers: ['ETH', 'BTC', 'XRP'], filters: ['circulating_supply', 'max_supply', 'name'])
=> {:response=>[{"circulating_supply"=>"18844581", "max_supply"=>"21000000", "name"=>"Bitcoin"}, {"circulating_supply"=>"117939318", "name"=>"Ethereum"}, {"circulating_supply"=>"46878114887", "max_supply"=>"100000000000", "name"=>"XRP"}], :total_items=>"3"}

```

### 3. Retrieve a specific cryptocurrency to specific fiat. 
Ie: BTC in ZAR or ETH in USD

#### Result

```
irb(main):002:0> Nomics.new.currencies_ticker(tickers: ['BTC'], options: { currency: 'ZAR' })
=> {:response=>[{"id"=>"BTC", "currency"=>"BTC", "symbol"=>"BTC", "name"=>"Bitcoin", "logo_url"=>"https://s3.us-east-2.amazonaws.com/nomics-api/static/images/currencies/btc.svg", "status"=>"active", "price"=>"910969.94656532", "price_date"=>"2021-10-15T00:00:00Z", "price_timestamp"=>"2021-10-15T17:57:00Z", "circulating_supply"=>"18844581", "max_supply"=>"21000000", "market_cap"=>"17166846946616", "market_cap_dominance"=>"0.4240", "num_exchanges"=>"393", "num_pairs"=>"66386", "num_pairs_unmapped"=>"5169", "first_candle"=>"2011-08-18T00:00:00Z", "first_trade"=>"2011-08-18T00:00:00Z", "first_order_book"=>"2017-01-06T00:00:00Z", "rank"=>"1", "rank_delta"=>"0", "high"=>"927637.23425261", "high_timestamp"=>"2021-04-13T00:00:00Z", "1d"=>{"volume"=>"963094181271.88", "price_change"=>"62703.31936859", "price_change_pct"=>"0.0739", "volume_change"=>"206797416231.74", "volume_change_pct"=>"0.2734", "market_cap_change"=>"1182449930371.62", "market_cap_change_pct"=>"0.0740"}, "7d"=>{"volume"=>"5315772472577.97", "price_change"=>"99536.62210277", "price_change_pct"=>"0.1227", "volume_change"=>"151479357652.31", "volume_change_pct"=>"0.0293", "market_cap_change"=>"1880929659591.90", "market_cap_change_pct"=>"0.1230"}, "30d"=>{"volume"=>"22274534528535.89", "price_change"=>"216802.67080145", "price_change_pct"=>"0.3123", "volume_change"=>"-248211559516.16", "volume_change_pct"=>"-0.0110", "market_cap_change"=>"4104883884560.68", "market_cap_change_pct"=>"0.3143"}, "365d"=>{"volume"=>"314355052664915.16", "price_change"=>"724413.65122794", "price_change_pct"=>"3.8831", "volume_change"=>"137325866108876.25", "volume_change_pct"=>"0.7757", "market_cap_change"=>"13712198775452.29", "market_cap_change_pct"=>"3.9692"}, "ytd"=>{"volume"=>"274615346440392.36", "price_change"=>"407784.50016001", "price_change_pct"=>"0.8104", "volume_change"=>"128817577458463.71", "volume_change_pct"=>"0.8835", "market_cap_change"=>"7814167735850.72", "market_cap_change_pct"=>"0.8355"}}], :total_items=>"1"}

```

### 4. Calculate the price of one cryptocurrency from another, in relation to their dollar value

Ie: 1BTC = $100, 1ETH = $50, therefore 1ETH == 0.5BTC

#### Result

```
irb(main):003:0> Nomics.new.convert(from: 'BTC', to: 'ETH')
=> {:response=>"1 BTC = 15.95999341335582 ETH"}
```

### Pagination

```
irb(main):003:0> Nomics.new.currencies_ticker(tickers: ['ETH', 'BTC', 'XRP'],  filters: ['id', 'name'], options: { per_page: 100, page: 1 })
=> {:response=>[{"id"=>"BTC", "name"=>"Bitcoin"}, {"id"=>"ETH", "name"=>"Ethereum"}, {"id"=>"XRP", "name"=>"XRP"}], :total_items=>"3"}
```
```
irb(main):004:0> Nomics.new.currencies_ticker(tickers: ['ETH', 'BTC', 'XRP'],  filters: ['id', 'name'], options: { per_page: 1, page: 2 })
=> {:response=>[{"id"=>"ETH", "name"=>"Ethereum"}], :total_items=>"3"}
```


## Showcase - if you want to use the app's API

### 1. Retrieve a list of cryptocurrencies given set of tickers

Ie: Given an array of [‘BTC’, ‘XRP’, ‘ETH’]. I want to get the full payload of those cryptocurrencies

#### API call:

```
GET /currencies?ids=ETH,BTC,XRP
```

### 2. Retrieve a (list) specific crypto currency and specific values based on the ticker and any other dynamic params

Ie: We want to view the [circulating_supply, max_supply, name, symbol, price] for [ETH,BTC]

#### API call:

```
GET /currencies?ids=ETH,BTC,XRP&filter=circulating_supply,max_supply,name,symbol,price
```


### 3. Retrieve a specific cryptocurrency to specific fiat. 
Ie: BTC in ZAR or ETH in USD

#### API call:

```
GET /currencies?ids=ETH&currency=ZAR
```

### 4. Calculate the price of one cryptocurrency from another, in relation to their dollar value

Ie: 1BTC = $100, 1ETH = $50, therefore 1ETH == 0.5BTC

#### API call:

```
GET /convert?from=ETH&to=BTC
```

### Pagination

```
GET /currencies?ids=ETH,BTC,XRP&per_page=1&page=2
```

```
GET /currencies?ids=ETH,BTC,XRP&per_page=100&page=1
```


## API Documentation

### GET /currencies

#### Params:

1. ids (mandatory) - a list of comma separated ids (see the examples above)

2. filters (optional) - a list of comma separated attributes e.g circulating_supply,max_supply,name,symbol,price

3. currency (optional, defaults to USD) - String e.g USD, GBP.

4. per_page (optional, defaults to 100) - Integer - amount of results per page

5. page (optional) - Integer - page number

#### Response

200: {response: , total_items: }, where the response is an Array of hashes with the payloads coming from Nomics, and total_items is the amount of total items - needed for pagination

Errors codes are inherited from Nomics API

### GET /convert

#### Params:

1. from (mandatory) - the id of the crypto you want to convert from (e.g BTC)
2. to (mandatory) - the id of the crypto you want to convert into (e.g ETH)

200: {response: }, where the response is a String that shows the conversion

Errors codes are inherited from Nomics API