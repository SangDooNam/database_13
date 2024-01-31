## task 1
```
webinars=# \i data.sql
INSERT 0 105020
Time: 543.461 ms
INSERT 0 1295840
Time: 14467.314 ms (00:14.467)
INSERT 0 284310
Time: 3459.530 ms (00:03.460)
INSERT 0 1569746
Time: 28899.318 ms (00:28.899)
```

## task 2

```
\copy teacher TO 'teacher.csv' WITH (FORMAT csv)
\copy student TO 'student.csv' WITH (FORMAT csv)
\copy webinar TO 'webinar.csv' WITH (FORMAT csv)
\copy registration TO 'registration.csv' WITH (FORMAT csv)

COPY 105020
Time: 25.714 ms
COPY 1295840
Time: 360.527 ms
COPY 284310
Time: 186.205 ms
COPY 1569746
Time: 547.917 ms
```

## task 3

```
TRUNCATE TABLE registration CASCADE;
TRUNCATE TABLE student CASCADE;
TRUNCATE TABLE teacher CASCADE;
TRUNCATE TABLE webinar CASCADE;



\copy teacher FROM 'teacher.csv' WITH (FORMAT csv)
\copy student FROM 'student.csv' WITH (FORMAT csv)
\copy webinar FROM 'webinar.csv' WITH (FORMAT csv)
\copy registration FROM 'registration.csv' WITH (FORMAT csv)


TRUNCATE TABLE
Time: 3.372 ms
psql:reload.sql:2: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 6.174 ms
psql:reload.sql:3: NOTICE:  truncate cascades to table "webinar"
psql:reload.sql:3: NOTICE:  truncate cascades to table "student"
psql:reload.sql:3: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 4.722 ms
psql:reload.sql:4: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 1.082 ms
COPY 105020
Time: 200.925 ms
COPY 284310
Time: 2282.192 ms (00:02.282)
COPY 1295840
Time: 8873.172 ms (00:08.873)
COPY 1569746
Time: 23210.581 ms (00:23.211)

```

## task 4

```

TRUNCATE TABLE registration CASCADE;
TRUNCATE TABLE student CASCADE;
TRUNCATE TABLE teacher CASCADE;
TRUNCATE TABLE webinar CASCADE;


ALTER TABLE registration DROP CONSTRAINT registration_student_id_fkey;
ALTER TABLE registration DROP CONSTRAINT registration_webinar_id_fkey;
ALTER TABLE student DROP CONSTRAINT student_mentor_id_fkey; 
ALTER TABLE webinar DROP CONSTRAINT webinar_teacher_id_fkey; 


\copy teacher FROM 'teacher.csv' WITH (FORMAT csv)
\copy webinar FROM 'webinar.csv' WITH (FORMAT csv)
\copy student FROM 'student.csv' WITH (FORMAT csv)
\copy registration FROM 'registration.csv' WITH (FORMAT csv)


ALTER TABLE registration ADD CONSTRAINT registration_student_id_fkey FOREIGN KEY (student_id) REFERENCES student(id);
ALTER TABLE registration ADD CONSTRAINT registration_webinar_id_fkey FOREIGN KEY (webinar_id) REFERENCES webinar(id);
ALTER TABLE student ADD CONSTRAINT student_mentor_id_fkey FOREIGN KEY (mentor_id) REFERENCES teacher(id);
ALTER TABLE webinar ADD CONSTRAINT webinar_teacher_id_fkey FOREIGN KEY (teacher_id) REFERENCES teacher(id);


TRUNCATE TABLE
Time: 4.656 ms
psql:reload.sql:15: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 5.210 ms
psql:reload.sql:16: NOTICE:  truncate cascades to table "webinar"
psql:reload.sql:16: NOTICE:  truncate cascades to table "student"
psql:reload.sql:16: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 5.158 ms
psql:reload.sql:17: NOTICE:  truncate cascades to table "registration"
TRUNCATE TABLE
Time: 1.418 ms
ALTER TABLE
Time: 0.370 ms
ALTER TABLE
Time: 0.351 ms
ALTER TABLE
Time: 0.312 ms
ALTER TABLE
Time: 0.322 ms
COPY 105020
Time: 205.960 ms
COPY 284310
Time: 902.225 ms
COPY 1295840
Time: 2598.901 ms (00:02.599)
COPY 1569746
Time: 1403.378 ms (00:01.403)
ALTER TABLE
Time: 1029.530 ms (00:01.030)
ALTER TABLE
Time: 363.306 ms
ALTER TABLE
Time: 219.657 ms
ALTER TABLE
Time: 62.022 ms

```

## task 5

```
Questions
How much time is the query estimated to take? how many rows will it return?
cost=1000.00..2162860969.48 
rows=2023210755 width=54
                                                                    QUERY PLAN                                                                    
--------------------------------------------------------------------------------------------------------------------------------------------------
 Gather  (cost=1000.00..2162860969.48 rows=2023210755 width=54)
   Workers Planned: 2
   ->  Nested Loop  (cost=0.00..1960538893.98 rows=843004481 width=54)
         Join Filter: (((student.mentor_id = teacher.id) AND ((student.city)::text = 'Berlin'::text)) OR ((teacher.city)::text = 'Berlin'::text))
         ->  Parallel Seq Scan on student  (cost=0.00..15174.33 rows=539933 width=29)
         ->  Seq Scan on teacher  (cost=0.00..1793.20 rows=105020 width=25)

What is the query doing and what do you think it was meant to do?

this query will read and display every columns which student and teacher tables contain
under the condition if mentor id of student table is equal to id of teacher table
and student.city is 'Berlin'. additionlly, there is the condition teacher's city is Berlin,
which will be operated regardless of the previous conditions.  

it would be meant to take data from student and teacher tables
under the condition if student.mentor id is equal to teacher.id
AND (student.city = Berlin or teacher.city = Berlin)


SELECT * FROM student, teacher
WHERE student.mentor_id = teacher.id
AND (student.city = 'Berlin' OR teacher.city = 'Berlin');

```

## task 6

```
CREATE INDEX idx_student_city ON studen(city);

EXPLAIN ANALYZE SELECT * FROM registration
    JOIN student
    ON student.id = registration.student_id
WHERE city = 'Berlin' AND date > '2019-01-01';

Planning Time: 0.231 ms
Execution Time: 59.526 ms

```



## task 7

```
EXPLAIN ANALYZE SELECT * FROM student
WHERE city IN (SELECT DISTINCT city FROM teacher);

Planning Time: 0.107 ms
Execution Time: 389.000 ms
```

```
EXPLAIN ANALYZE SELECT * FROM student WHERE city IN ('Las Vegas',
'Paris',
'Bern',
'Sydney',
'New York',
'Metz',
'Leeds',
'Donetsk',
'Dijon',
'Berlin',
'Bilbao',
'Lyon',
'Mildura',
'Salzburg',
'Ottawa',
'Porto Alegre',
'Chicago',
'Stuttgart',
'San Marino',
'Tubingen',
'Dresden',
'Auckalnd',
'Barcelona',
'Leipzig',
'Rosario',
'Antwerp',
'Seattle',
'Brussels',
'Malmö',
'Roma',
'Cardiff',
'Marseille',
'Melbourne',
'Xiamen',
'Kiev',
'Guangzhou',
'Toulouse',
'Sarajevo',
'Hallein',
'Budapest',
'Naples',
'Prague',
'Dortmund',
'Basel',
'Munich',
'Stockholm',
'Graz',
'Moscow',
'San Diego',
'Los Angeles',
'Madrid',
'Adelaide',
'Sheffield',
'Vancouver',
'Dublin',
'Salt',
'Kunimng',
'Johannesburg',
'Lausanne',
'Girona',
'Venice',
'Muscat',
'Frankfurt',
'Viena');

Planning Time: 0.197 ms
Execution Time: 224.887 ms
```

```
CREATE INDEX idx_student_city ON student(city);
CREATE INDEX idx_teacher_city ON teacher(city);

EXPLAIN ANALYZE SELECT * FROM student
WHERE city = ANY(ARRAY(SELECT DISTINCT city FROM teacher));

Planning Time: 0.106 ms
Execution Time: 208.459 ms

```


**With IN clause without INDEX**

```
225.887 / 389.000 * 100 = 58,07

100 - 58,07 = 41,93

41,93 %

```
**With INDEX and ANY keyword with array**

```
208,459 / 389.000 * 100 = 53,6

100 - 53,6 = 46,4

46,4 %
```