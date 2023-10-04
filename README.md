# Register Sources PSC

Register Sources PSC is designed for inclusion as a library for use with the People with significant control (PSC) data published by Companies House in the UK. See http://download.companieshouse.gov.uk/en_pscdata.html for an example of their latest snapshot data.

There are two primary purposes for this library:

- Providing typed objects for the JSON-line data. It makes use of the dry-types and dry-struct gems to specify the different object types allowed in the data returned.
- For use with an Elasticsearch database for
persisting the PSC records. This functionality includes creating a mapping for indexing the possible fields observed as well as functions for storage and retrieval.

This library does not perform any ingestion of the PSC records, which is the purpose of the register_ingester_psc gem.

## Configuration

Install and boot [register-v2](https://github.com/openownership/register-v2).

Configure your environment using the example file:

```sh
cp .env.example .env
```

As an initial setup stage, the index should be created:
```
require 'register_sources_psc/services/es_index_creator'

index_creator = RegisterSourcesPsc::Services::EsIndexCreator.new
index_creator.create_index RegisterSourcesPsc::Config::ELASTICSEARCH_INDEX_COMPANY
index_creator.create_index RegisterSourcesPsc::Config::ELASTICSEARCH_INDEX_OVERSEAS
```

## Testing

Run the tests:

```sh
docker compose run sources-psc test
```
