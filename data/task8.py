"""Print the students and mentors."""
import psycopg2
import datetime

# connection = psycopg2.connect("dbname=webinars user=postgres")

# cursor = connection.cursor()

# params = {
#     "date": "2021-01-01",
#     "topic": "Django"
# }

# start = datetime.datetime.now()

# cursor.execute("SELECT student.name, student.mentor_id FROM student "
#                "JOIN registration ON student.id = registration.student_id "
#                "JOIN webinar ON webinar.id = registration.webinar_id "
#                f"WHERE date > '{params['date']}' "
#                f"AND webinar.name LIKE '%{params['topic']}%' "
#                "ORDER BY student.id;")

# with open("students_query.csv", "w") as file:
#     file.write("Student,Teacher\n")
#     for student in cursor.fetchall():
#         cursor.execute(f"SELECT name FROM teacher WHERE id={student[1]}")
#         mentor = cursor.fetchone()
#         file.write(f"{student[0]},{mentor[0]}\n")

# end = datetime.datetime.now()
# print(f"It took {end - start}")
# connection.close()


connection = psycopg2.connect("dbname=webinars user=postgres")

cursor = connection.cursor()

params = {
    "date": "2021-01-01",
    "topic": "Django"
}

start = datetime.datetime.now()

cursor.execute("SELECT student.name AS student_name, teacher.name AS teacher_name FROM student "
               "JOIN registration ON student.id = registration.student_id "
               "JOIN webinar ON webinar.id = registration.webinar_id "
               "JOIN teacher ON student.mentor_id = teacher.id "
               f"WHERE date > '{params['date']}' "
               f"AND webinar.name LIKE '%{params['topic']}%' "
               "ORDER BY student.id;")

with open("students_query.csv", "w") as file:
    file.write("Student,Teacher\n")
    for student in cursor.fetchall():
        # cursor.execute(f"SELECT name FROM teacher WHERE id={student[1]}")
        # mentor = cursor.fetchone()
        file.write(f"{student[0]},{student[1]}\n")

end = datetime.datetime.now()
print(f"It took {end - start}")
connection.close()

