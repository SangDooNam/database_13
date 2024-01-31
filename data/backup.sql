-- COPY { table_name [ ( column_name [, ...] ) ] | ( query ) }
--     TO { 'filename' | PROGRAM 'command' | STDOUT }
--     [ [ WITH ] ( option [, ...] ) ]

\copy teacher TO 'teacher.csv' WITH (FORMAT csv)
\copy student TO 'student.csv' WITH (FORMAT csv)
\copy webinar TO 'webinar.csv' WITH (FORMAT csv)
\copy registration TO 'registration.csv' WITH (FORMAT csv)

