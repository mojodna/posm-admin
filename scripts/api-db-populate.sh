#!/usr/bin/env bash

osmosis --read-pbf-fast /opt/data/osm/dvizarasekwa.pbf \
  --log-progress \
  --write-apidb password=openstreetmap database=osm validateSchemaVersion=no

psql -d osm -c "select setval('changesets_id_seq', (select max(id) from changesets))"
psql -d osm -c "select setval('current_nodes_id_seq', (select max(node_id) from nodes))"
psql -d osm -c "select setval('current_ways_id_seq', (select max(way_id) from ways))"
psql -d osm -c "select setval('current_relations_id_seq', (select max(relation_id) from relations))"
psql -d osm -c "select setval('users_id_seq', (select max(id) from users))"