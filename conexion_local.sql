select * from HR.EMPLOYEES;


select * from HR.EMPLOYEES Order by FIRST_NAME;

select XMLELEMENT("Emp",FIRST_NAME)from HR.EMPLOYEES;

SELECT XMLElement("Salario", XMLAttributes (e.salARY AS Salario_Neto),
xmlconcat (
XMLElement("Nombre", e.FIRST_NAME),
XMLElement("Numero", e.PHONE_NUMBER,
XMLElement("Departamento", e.JOB_ID)))).getCLOBval()Empleados        
FROM HR.EMPLOYEES e;

--La diferencia básica entre XMLELEMENT y XMLFOREST es que forest impreme los datos tal y como se los manda genera automaticamente los tags
select XMLELEMENT("Emp", 
   XMLFOREST(e.FIRST_NAME, e.PHONE_NUMBER, e.salary))
FROM HR.EMPLOYEES e;

--XMLAGG imprime varias columnas agrupadas en una solo fila se utiliza para manejar sentencias del tipo de 'order by'

SELECT XMLELEMENT("Empleados",
   XMLAGG(XMLELEMENT("Empleado", 
   e.First_Name||' trabaja en '||e.job_id)
   ORDER BY e.First_Name))
   as "Dept_list"     
   FROM HR.EMPLOYEES e;
   
SELECT XMLELEMENT("Departamento",
   XMLAGG(XMLELEMENT("Empleado", 
   e.First_Name||' trabaja en '||e.job_id)
   ORDER BY e.First_Name))
   as "Dept_list"     
   FROM HR.EMPLOYEES e
   where e.JOB_ID = 'SH_CLERK';
---XML ATRIBUTE es igual a XMLELEMENT solo que imprime atributos  denro del tag en vez de crear registros nuevos  
SELECT XMLElement("job", 
  XMLAttributes(e.salary AS salario),
     XMLForest(e.First_Name AS "Nombre",
        e.Email  AS "Correo", 
               e.Job_Id AS "Trabajo"))
FROM HR.EMPLOYEES e;

   
  
   
   
   




