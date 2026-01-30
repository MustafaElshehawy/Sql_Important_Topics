-----------------------------------Custome Function ----------------
--Scaler --return on vlaue
-- string GetStudentName (int Id){}

create function GetStudentName (@id int)
returns varchar(100)--must return varchar max length 100
begin 
     declare @name varchar(100) -- Functionمتغير محلي يعيش فقط داخل الـ 
	 select @name = St_Fname From Student where St_Id = @id --logic بتاعك
	 return @name--واحده فقط

end

 Select * From Student
--Call 
select dbo.GetStudentName(3)



--=============Funtions =============
---------------Scalar Functions -----------------
--تستقبل مدخلات
--Return a single value (int, string, date, etc.)


CREATE FUNCTION dbo.fn_GetFullName
(
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50)
)
RETURNS VARCHAR(100)
AS
BEGIN
    RETURN @FirstName + ' ' + @LastName  -- Body Fun 
END

---Calling 
SELECT dbo.fn_GetFullName('Ali', 'Ahmed') AS FullName;
 
-----------------------------Inline Table-Valued Function -----------
--Return table
--body select statment onlYYYYYYYYY
-- No BEGIN ... END block 
-- No need variables

create function GetInstInfo (@id int)
returns table 
as
return 
(
   select i.Ins_Name , i.Salary * 12 as annSalary
   from Instructor i
   where i.id = @id
)

--Call 
select * from dbo.GetInstInfo(2)

/* ex.
ربط بحالة واقعية
تحتاج اسم طالب واحد → Scalar
تحتاج كل طلاب قسم معيّن → Table-Valued
*/
-------------------------------------Multi Table-Valued -----------------
--Retrun table
--body Select + Logic
--You can write multiple statements(SELECT, INSERT, IF, DECLARE)
--You define and fill a table variable
--ترجع جدولًا مخزنًا في متغير Table داخلي

CREATE FUNCTION GetStdInfo (@format VARCHAR(20))
RETURNS @t TABLE (
    id INT,
    name VARCHAR(200)
)
AS
BEGIN 
    IF (@format = 'first')
        INSERT INTO @t
        SELECT s.St_Id, s.St_Fname
        FROM Student s;

    ELSE IF (@format = 'last')
        INSERT INTO @t
        SELECT s.St_Id, s.St_Lname
        FROM Student s;

    ELSE IF (@format = 'full')
        INSERT INTO @t
        SELECT s.St_Id, s.St_Fname + ' ' + s.St_Lname
        FROM Student s;

    RETURN;
END;

--Call
select * from dbo.GetStdInfo('full')

 

