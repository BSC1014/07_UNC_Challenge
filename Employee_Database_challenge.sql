
--Deliverable 1

-- retirement titles
DROP TABLE IF EXISTS retirement_titles;
	 
SELECT employees.emp_no,
  employees.first_name,
  employees.last_name,
  titles.title,
  titles.from_date,
  titles.to_date
INTO retirement_titles
FROM employees 
  INNER JOIN titles
    ON (employees.emp_no = titles.emp_no)
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY employees.emp_no;

select * from retirement_titles
-- unique titles
DROP TABLE IF EXISTS unique_titles;

SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO unique_titles
FROM retirement_titles
WHERE (retirement_titles.to_date = '9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

select * from unique_titles

-- retiring titles
DROP TABLE IF EXISTS retiring_titles;

SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

select * from retiring_titles

-- Deliverbale 2 

-- mentorship eligibility
DROP TABLE IF EXISTS mentorship_eligibility;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
  e.first_name,
  e.last_name,
  e.birth_date,
  d.from_date,
  d.to_date,
  t.title
INTO mentorship_eligibility
FROM employees as e
INNER JOIN dept_emp as d
  ON (e.emp_no = d.emp_no)
INNER JOIN titles as t
  ON (e.emp_no = t.emp_no)
WHERE (d.to_date = '9999-01-01')
AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;


select * from mentorship_eligibility 