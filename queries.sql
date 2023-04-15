-- 1. Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT s.fullname, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 5;

--2. Знайти студента із найвищим середнім балом з певного предмета.

SELECT d.name, s.fullname, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN disciplines d ON d.id = g.discipline_id
WHERE d.id = 5
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 1;

--3. Знайти середній бал у групах з певного предмета.

SELECT gr.name, d.name, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN disciplines d ON d.id = g.discipline_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE d.id = 1
GROUP BY gr.id
ORDER BY avg_grade DESC;

--4. Знайти середній бал на потоці (по всій таблиці оцінок).

SELECT ROUND(AVG(grade), 2) as avg_grade
FROM grades g

-- 5. Знайти які курси читає певний викладач.

SELECT name
FROM disciplines d
WHERE teacher_id = 2

-- 6. Знайти список студентів у певній групі.

SELECT fullname
FROM students s
WHERE group_id = 3

-- 7. Знайти оцінки студентів у окремій групі з певного предмета.

SELECT *
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
where s.group_id = 1 AND g.discipline_id = 1

-- 8. Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT d.name, ROUND(AVG(g.grade), 2) as avg_grade
FROM grades g
LEFT JOIN disciplines d ON d.id = g.discipline_id
WHERE d.teacher_id = 2
GROUP BY g.discipline_id

-- 9. Знайти список курсів, які відвідує студент.

SELECT d.name
FROM grades g
JOIN disciplines d ON d.id = g.discipline_id
WHERE  g.student_id = 2
GROUP BY g.discipline_id

-- 10. Список курсів, які певному студенту читає певний викладач.

SELECT d.name
FROM grades g
LEFT JOIN disciplines d ON d.id = g.discipline_id
WHERE  d.teacher_id = 2 AND g.student_id = 2
GROUP BY g.discipline_id