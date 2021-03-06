CREATE TABLE issue253 (
  id serial8,
  geom postgis.geometry,
  polygons postgis.geometry(MultiPolygon,2278),
  points postgis.geometry(Point,2278)
);

INSERT INTO issue253 (geom) VALUES ('0101000020E610000087A19B1E104053C079CE71C9CC7F4340');
INSERT INTO issue253 (polygons) VALUES (postgis.ST_GeometryFromText('MULTIPOLYGON(((3051677.25739039 13849651.0406969,3051611.94059189 13849649.498049,3051609.16828773 13849771.434813,3051674.49296022 13849772.6723434,3051677.25739039 13849651.0406969)))', 2278));
INSERT INTO issue253 (points) VALUES ('0101000020E6080000A069D47836CA474180C918C771656A41');

CREATE INDEX idxissue253 ON issue253 USING zombodb ((issue253.*));

SELECT * FROM issue253 WHERE issue253 ==> dsl.geo_shape('geom', '{"type":"Point","coordinates":[-77.00098386,38.9984371]}', 'INTERSECTS');
SELECT * FROM issue253 WHERE issue253 ==> dsl.geo_shape('geom', '{"type":"Point","coordinates":[-77.00098386,38.9984371]}', 'WITHIN');
SELECT * FROM issue253 WHERE issue253 ==> dsl.geo_shape('geom', '{"type":"Point","coordinates":[-77.00098386,38.9984371]}', 'DISJOINT');

-- not supported in ES 6.6+
-- SELECT * FROM issue253 WHERE issue253 ==> dsl.geo_shape('geom', '{"type":"Point","coordinates":[-77.00098386,38.9984371]}', 'CONTAINS');

DROP TABLE issue253;