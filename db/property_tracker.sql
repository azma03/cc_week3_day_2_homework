DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL8 PRIMARY KEY,
  address varchar(255),
  value INTEGER,
  number_of_bedrooms INT2,
  status VARCHAR
);
