-- create type for next function
create type user_type as (fname text, lname text, username text);

create or replace function test_spi_tup(arg1 text) returns setof user_type as $$
#container: plc_r
pg.spi.exec(arg1)
$$ language plcontainer;

create or replace function test_spi_ta(arg1 text) returns text[] as $$
#container: plc_r
pg.spi.exec(arg1)
$$ language plcontainer;

/* really stupid function just to get the module loaded
*/
CREATE OR REPLACE FUNCTION rlog100() RETURNS text AS $$
# container: plc_r
return(log10(100))
$$ LANGUAGE plcontainer;

create or replace function pg_spi_exec(arg1 text) returns text as $$
#container: plc_r
(pg.spi.exec(arg1))[[1]]
$$ language plcontainer;

CREATE OR REPLACE FUNCTION writeFile() RETURNS text AS $$
# container: plc_python
f = open("/tmp/foo", "w")
f.write("foobar")
f.close
return 'wrote foobar to /tmp/foo'
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pylog100() RETURNS double precision AS $$
# container: plc_python
import math
return math.log10(100)
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pybool(b bool) RETURNS bool AS $$
# container: plc_python
return b
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pyint(i int2) RETURNS int2 AS $$
# container: plc_python
return i
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pyint(i int4) RETURNS int4 AS $$
# container: plc_python
return i
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pyint(i int8) RETURNS int8 AS $$
# container: plc_python
return i
$$ LANGUAGE plcontainer;


CREATE OR REPLACE FUNCTION pyfloat(f float4) RETURNS float4 AS $$
# container: plc_python
return f
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pyfloat(f float8) RETURNS float8 AS $$
# container: plc_python
return f
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pylog(a integer, b integer) RETURNS double precision AS $$
# container: plc_python
import math
return math.log(a, b)
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION concat(a text, b text) RETURNS text AS $$
# container: plc_python
import math
return a + b
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION concatall() RETURNS text AS $$
# container: plc_python
res = plpy.execute('select fname from users order by 1')
names = map(lambda x: x['fname'], res)
return reduce(lambda x,y: x + ',' + y, names)
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION invalid_function() RETURNS double precision AS $$
# container: plc_python
import math
return math.foobar(a, b)
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION invalid_syntax() RETURNS double precision AS $$
# container: plc_python
import math
return math.foobar(a,
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION nested_call_one(a text) RETURNS text AS $$
# container: plc_python
q = "SELECT nested_call_two('%s')" % a
r = plpy.execute(q)
return r[0]
$$ LANGUAGE plcontainer ;

CREATE OR REPLACE FUNCTION nested_call_two(a text) RETURNS text AS $$
# container: plc_python
q = "SELECT nested_call_three('%s')" % a
r = plpy.execute(q)
return r[0]
$$ LANGUAGE plcontainer ;

CREATE OR REPLACE FUNCTION nested_call_three(a text) RETURNS text AS $$
# container: plc_python
return a
$$ LANGUAGE plcontainer ;

CREATE OR REPLACE FUNCTION rlog100_shared() RETURNS text AS $$
# container: plc_r_shared
return(log10(100))
$$ LANGUAGE plcontainer;

CREATE OR REPLACE FUNCTION pylog100_shared() RETURNS double precision AS $$
# container: plc_python_shared
import math
return math.log10(100)
$$ LANGUAGE plcontainer;
