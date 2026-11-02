CREATE DATABASE HR_Analytics;
USE HR_Analytics;

CREATE TABLE Departments (
    Department_ID VARCHAR(10) PRIMARY KEY,
    Department_Name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Jobs (
    Job_ID VARCHAR(10) PRIMARY KEY,
    Job_Title VARCHAR(100) NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    
    FOREIGN KEY (Department_ID)
        REFERENCES Departments(Department_ID)
);

CREATE TABLE Employees (
    Employee_ID VARCHAR(10) PRIMARY KEY,
    Employee_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(20),
    Date_of_Birth DATE,
    Hire_Date DATE,
    Department_ID VARCHAR(10),
    Job_ID VARCHAR(10),
    Location VARCHAR(50),
    Education_Level VARCHAR(50),
    Employment_Status VARCHAR(30),

    FOREIGN KEY (Department_ID)
        REFERENCES Departments(Department_ID),

    FOREIGN KEY (Job_ID)
        REFERENCES Jobs(Job_ID)
);

CREATE TABLE Salary (
    Salary_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID VARCHAR(10) NOT NULL,
    Annual_Salary DECIMAL(12,2) NOT NULL,
    Effective_Date DATE NOT NULL,

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

CREATE TABLE Attendance (
    Attendance_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID VARCHAR(10) NOT NULL,
    Year INT NOT NULL,
    Month INT NOT NULL,
    Working_Days INT NOT NULL,
    Present_Days INT NOT NULL,
    Absent_Days INT NOT NULL,
    Leave_Days INT NOT NULL,

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

CREATE TABLE `Leave` (
    Leave_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID VARCHAR(10) NOT NULL,
    Leave_Date DATE NOT NULL,
    Leave_Days INT NOT NULL,
    Leave_Type VARCHAR(50),
    Approval_Status VARCHAR(20),

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

CREATE TABLE Performance (
    Performance_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID VARCHAR(10) NOT NULL,
    Review_Year INT NOT NULL,
    Rating INT NOT NULL,
    Performance_Level VARCHAR(50),

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

CREATE TABLE Exits (
    Exit_ID VARCHAR(10) PRIMARY KEY,
    Employee_ID VARCHAR(10) NOT NULL,
    Exit_Date DATE NOT NULL,
    Exit_Reason VARCHAR(100),
    Exit_Type VARCHAR(30),

    FOREIGN KEY (Employee_ID)
        REFERENCES Employees(Employee_ID)
);

CREATE TABLE Recruitment (
    Recruitment_ID VARCHAR(10) PRIMARY KEY,
    Month DATE NOT NULL,
    Department_ID VARCHAR(10) NOT NULL,
    Open_Positions INT NOT NULL,
    Applications INT NOT NULL,
    Hires INT NOT NULL,
    Avg_Time_to_Hire_Days DECIMAL(5,1),

    FOREIGN KEY (Department_ID)
        REFERENCES Departments(Department_ID)
);

select * from departments;
select * from jobs;
select * from employees;
select * from salary;
select * from attendance;
SELECT * FROM `Leave`;
select * from performance;
select * from exits;
select * from Recruitment;

#1. Workforce Overview----------------------------------------------------

/*Q1: What is the total number of employees?*/
select count(*) as total_employees from employees;

/*q2: How many employees are currently active?*/
select * from employees where employment_status="active";

/*Q3. How many employees have exited the organization?*/
select count(*) as employees_exited from exits;

/*What is the gender distribution of employees?*/
select gender,count(gender)as employee_count from employees group by gender;

/*Q5. What is the employee distribution by department?*/
select d.department_name,count(e.employee_id)as employee_count from employees e join departments d using(department_id) 
group by d.department_name order by employee_count desc;

/*What is the employee distribution by location?*/
select location as city,count(employee_id)as employee_count from employees group by location order by employee_count desc;

/*What is the employee distribution by education level?*/
select education_level,count(employee_id)as employee_count from employees group by education_level order by employee_count desc;

/*What is the employee distribution by employment status?*/
select employment_status,count(employee_id)as employee_count from employees group by employment_status order by employee_count desc;

/*What is the average age of employees?*/
select round(avg(timestampdiff(year,date_of_birth,curdate())))as average_age from employees;

/*Q10. What is the average employee tenure in years?*/
select round(avg(timestampdiff(year,hire_date,curdate())))as average_tenure from employees;

#2. Hiring Analysis----------------------------------------------------
/*Q11. How many employees were hired each year?*/
select year(hire_date)as year,count(employee_id)as employee_count from employees group by year(hire_date) order by employee_count desc;

/*Q12. Which year had the highest number of hires?*/
select year(hire_date)as year,count(employee_id)as employee_count from employees group by year(hire_date) order by employee_count desc limit 1;
 
/*Q13. Which department hired the most employees?*/
select d.department_name,count(year(e.hire_date))as employee_count from employees e join departments d using(department_id) 
group by d.department_name order by employee_count desc limit 1;

/*Q14. What is the monthly hiring trend?*/
select monthname(hire_date)as month,count(monthname(hire_date))as monthly_trend from employees group by monthname(hire_date) order by monthly_trend desc;

/*Q15. Which month had the highest number of hires?*/
select monthname(hire_date)as month,count(monthname(hire_date))as monthly_trend from employees group by monthname(hire_date) order by monthly_trend desc limit 1;

/*What is the average age of employees when they joined?*/
select round(avg(age_when_joined)) as avg_age_when_joined from (select timestampdiff(year,date_of_birth,hire_date)as age_when_joined from employees)x;

#3. Department Analysis-----------------------------------------------------------------------
/*Q17. Which department has the highest number of employees?*/
select d.department_name,count(employee_id)as highest_emp_count from employees e join departments d using(department_id) 
group by d.department_name order by highest_emp_count desc limit 1;

/*Q18. Which department has the lowest number of employees?*/
select d.department_name,count(employee_id)as lowest_emp_count from employees e join departments d using(department_id) 
group by d.department_name order by lowest_emp_count limit 1;

/*Q19. What is the average salary by department?*/
select d.department_name,round(avg(s.annual_salary))as avg_dept_salary 
from salary s join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by avg_dept_salary desc;

/*Q20. Which department has the highest average salary?*/
select d.department_name,round(avg(s.annual_salary))as high_avg_dept_salary 
from salary s join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by high_avg_dept_salary desc limit 1;

/*Q21. What is the gender distribution within each department?*/
select d.department_name,e.gender,count(employee_id)as employee_count from employees e join departments d using(department_id) group by d.department_name,e.gender;

/*Q22. What is the average performance rating by department?*/
select d.department_name,avg(rating)as avg_rating from performance p join employees e using(employee_id) join departments d using(department_id) group by d.department_name;

/*Q23. Which department has the highest absence rate?*/
select d.department_name,count(leave_days)as absence_rate 
from `Leave` l join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by absence_rate desc limit 1;

/*Q24. Which department has the highest attrition rate?*/
select d.department_name,round(((count(e.exit_id)/count(em.employee_id))*100),2)as attrition_rate 
from employees em left join exits e using(employee_id) join departments d using(department_id) group by d.department_name order by attrition_rate desc limit 1;

#4. Salary Analysis------------------------------------------------------------------------------
/*Q25. What is the total annual salary expenditure?*/
select sum(annual_salary)as total_salary from salary;

/*Q26. What is the overall average salary?*/
select avg(annual_salary)as average_salary from salary;

/*Q27. What are the minimum and maximum salaries?*/
select min(annual_salary) as min,max(annual_salary)as max from salary;

/*Q28. What is the average salary by job title?*/
select j.job_title,round(avg(s.annual_salary))as avg_salary 
from jobs j join employees e using(job_id) join salary s using(employee_id) group by j.job_title order by avg_salary desc;

/*Q29. Which job title has the highest average salary?*/
select j.job_title,round(avg(s.annual_salary))as high_avg_salary 
from jobs j join employees e using(job_id) join salary s using(employee_id) group by j.job_title order by high_avg_salary desc limit 1;

/*Q30. Which job title has the lowest average salary?*/
select j.job_title,round(avg(s.annual_salary))as low_avg_salary 
from jobs j join employees e using(job_id) join salary s using(employee_id) group by j.job_title order by low_avg_salary limit 1;

/*Q31. Which department has the highest total salary expenditure?*/
select d.department_name,sum(s.annual_salary)as total_salary_expense 
from departments d join employees e using(department_id) join salary s using(employee_id) group by d.department_name order by total_salary_expense desc limit 1;

/*Q32. How are employees distributed across salary ranges?*/
select case WHEN annual_salary < 30000 THEN '0k-30k'
			WHEN annual_salary < 60000 THEN '30k-60k'
			WHEN annual_salary < 100000 THEN '60-1Lakhs'
			ELSE '1+ Lakhs'
		end as salary_range,
        count(*) as empl_count from salary group by salary_range order by empl_count desc;

#5. Attendance Analysis---------------------------------------------------------------------------------
/*Q33. What are the total working days, present days, and absent days?*/
select employee_id,sum(working_days)as working_days,sum(present_days)as present_days,sum(absent_days)as absent_days from attendance group by employee_id;

/*Q34. What is the overall attendance rate?*/
select round((sum(present_days)/sum(working_days)*100),2)as attendance_rate from attendance;

/*Q35. What is the overall absence rate?*/
select round((sum(absent_days)/sum(working_days)*100),2)as abesence_rate from attendance;

/*Q36. Which department has the highest attendance rate?*/
select d.department_name,round((sum(present_days)/sum(working_days)*100),2)as attendance_rate 
from attendance join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by attendance_rate desc limit 1;

/*Q37. Which department has the highest absence rate?*/
select d.department_name,round((sum(absent_days)/sum(working_days)*100),2)as absence_rate 
from attendance join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by absence_rate desc limit 1;

/*Q38. Which month has the highest absence rate?*/
select month as month_name,round((sum(absent_days)/sum(working_days)*100),2)as absence_rate from attendance group by month order by absence_rate desc limit 1;

/*Q39. Which employees have the highest number of absences?*/
select e.employee_name,sum(absent_days)as absence from attendance a join employees e using(employee_id) group by e.employee_name order by absence desc limit 1;

#6. Leave Analysis------------------------------------------------------------------------------------------------
/*Q40. What is the total number of leave days taken?*/
select sum(leave_days)as ttl_nummber_leavetaken from `Leave`;

/*Q41. How many leave requests were approved and rejected?*/
select approval_status,sum(leave_days)as leavess from `Leave` group by approval_status;

/*Q42. What is the distribution of leave by leave type?*/
select leave_type,sum(leave_days)as leavess from `Leave` group by leave_type;

/*Q43. Which department has the highest leave usage?*/
select d.department_name,sum(leave_days)as leaves_usage 
from `Leave` join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by leaves_usage desc limit 1;

/*Q44. Which month has the highest leave usage?*/
select monthname(leave_date)as month_name,sum(leave_days)as leave_usage from `Leave` group by monthname(leave_date) order by leave_usage desc limit 1;

/*Q45. Which employees have taken the most leave?*/
select employee_id,e.employee_name,sum(leave_days)as leave_usage from `Leave` 
join employees e using(employee_id) group by employee_id,e.employee_name order by leave_usage desc limit 1;

#7. Performance Analysis------------------------------------------------------------------------------------------------------------
/*Q46. What is the overall average performance rating?*/
select round(avg(rating),2) as avg_performance_rating from performance;

/*Q47. How many employees are in each performance level?*/
select rating,count(employee_id)as employee_count from performance group by rating order by employee_count;

/*Q48. What percentage of employees are high performers?*/
select round(((sum(case when rating=5 then 1 else 0 end)/count(rating))*100),2)as high_performers from performance;

/*Q49. Which department has the highest average performance rating?*/
select d.department_name,round(avg(rating),2) as top_avg_per_rating 
from performance p join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by top_avg_per_rating desc limit 1;

/*Q50. Which department has the lowest average performance rating?*/
select d.department_name,round(avg(rating),2) as least_avg_per_rating 
from performance p join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by least_avg_per_rating limit 1;

/*Q51. Which job titles have the highest average performance rating?*/
select j.job_title,round(avg(p.rating),2)as top_avg_per_rating 
from performance p join employees e using(employee_id) join jobs j using(job_id) group by j.job_title order by top_avg_per_rating desc limit 1;

/*Q52. Is there a relationship between salary and performance rating?*/
select p.rating,round(avg(s.annual_salary),2)as avg_salary from salary s join performance p using(employee_id) group by p.rating order by avg_salary;

#8. Attrition / Exit Analysis-----------------------------------------------------------------------------------------------------------------------------
/*Q53. What is the total number of employee exits?*/
select count(*)as employee_exits from exits;

/*Q54. What is the overall attrition rate?*/
 select round(((count(ex.employee_id)/count(e.employee_id))*100),2) as attrition_rate from employees e left join exits ex using(employee_id);

/*Q55. Which department has the highest attrition rate?*/
select d.department_name,round(((count(ex.employee_id)/count(e.employee_id))*100),2) as highest_attrition_rate 
from exits ex right join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by highest_attrition_rate desc limit 1;

/*Q56. Which department has the lowest attrition rate?*/
select d.department_name,round(((count(ex.employee_id)/count(e.employee_id))*100),2) as lowest_attrition_rate 
from exits ex right join employees e using(employee_id) join departments d using(department_id) group by d.department_name order by lowest_attrition_rate limit 1;

/*Q57. What are the most common reasons for employee exits?*/
select exit_reason,count(exit_reason)as exit_reasons from exits group by exit_reason order by exit_reasons desc;

/*Q58. What is the distribution of exits by exit type?*/
select exit_type,count(exit_type)as exit_count from exits group by exit_type;

/*Q59. Which year had the highest number of employee exits?*/
select year(exit_date)as year,count(exit_id)as exits from exits group by year(exit_date) order by exits desc limit 1;

/*Q60. Which job titles have the highest number of exits?*/
with xyz as 
(select j.job_title,count(ex.exit_id)as exits_count from exits ex join employees e using(employee_id) join jobs j using(job_id) group by j.job_title)
select * from xyz where exits_count=(select max(exits_count) from xyz);

/*Q61. What is the average tenure of employees who exited?*/
select round(avg(timestampdiff(month,e.hire_date,ex.exit_date))/12,2)as avg_tenure from exits ex join employees e using(employee_id);

#9. Recruitment Analysis-----------------------------------------------------------------------------------------------------------------------------------------
select * from Recruitment;
/*Q62. What is the total number of open positions?*/
select sum(open_positions)as ttl_open_positions from Recruitment;

/*Q63. What is the total number of applications received?*/
select sum(applications)as applications from Recruitment;

/*Q64. What is the total number of candidates hired?*/
select sum(hires)as ttl_hires from Recruitment;

/*Q65. Which department has the highest number of open positions?*/
with abc as 
(select d.department_name,sum(r.open_positions)as open_positions from Recruitment r join departments d using(department_id) group by d.department_name)
select * from abc where open_positions=(select max(open_positions) from abc);

/*Q66. Which department received the most applications?*/
with abcd as 
(select d.department_name,sum(r.applications)as applications from Recruitment r join departments d using(department_id) group by d.department_name order by applications desc)
select * from abcd where applications=(select max(applications) from abcd);

/*Q67. Which department hired the most candidates?*/
with x as 
(select d.department_name,sum(r.hires)as hires from Recruitment r join departments d using(department_id) group by d.department_name order by hires desc)
select * from x where hires=(select max(hires) from x);

/*Q68. What is the average time to hire?*/
select round(avg(avg_time_to_hire_days))as avg_time_to_hire from Recruitment;

/*Q69. Which department has the highest average time to hire?*/
with a as 
(select d.department_name,round(avg(avg_time_to_hire_days),2)as avg_time_to_hire 
from Recruitment r join departments d using(department_id) group by d.department_name)
select department_name,concat(avg_time_to_hire,"  Days")as avg_time_to_hire from a where avg_time_to_hire=(select max(avg_time_to_hire) from a);

/*Q70. What is the application-to-hire conversion rate?*/
select round(((sum(hires)/sum(applications))*100),2) as application_to_hire_conversion_rate from Recruitment;

/*Q71. Which month had the highest recruitment activity?*/
with m as 
(select monthname(month)as month_name,count(recruitment_id)as recruitments from Recruitment group by monthname(month))
select * from m where recruitments=(select max(recruitments) from m);

#(or)---

with m as 
(select monthname(month)as month_name,sum(open_positions)as ttl_open_position,sum(applications)as ttl_applications,sum(hires)as ttl_hires
from Recruitment group by monthname(month))
select * from m where (ttl_open_position,ttl_applications,ttl_hires)=(select max(ttl_hires),max(ttl_open_position),max(ttl_applications) from m);

