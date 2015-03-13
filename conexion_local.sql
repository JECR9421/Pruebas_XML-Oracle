select * from HR.EMPLOYEES;


select * from HR.EMPLOYEES Order by FIRST_NAME;

select XMLELEMENT("Emp",FIRST_NAME)from HR.EMPLOYEES;

SELECT XMLElement("Salario", XMLAttributes (e.salARY AS Salario_Neto),
xmlconcat (
XMLElement("Nombre", e.FIRST_NAME),
XMLElement("Numero", e.PHONE_NUMBER,
XMLElement("Departamento", e.JOB_ID)))).getCLOBval()Empleados        
FROM HR.EMPLOYEES e;

--La diferencia básica entre XMLELEMENT y XMLFOREST es que forest genera un tag automaticamente por cada elemento en el -->()no permite atributos 
--Mientras que cada XMLELEMENT es un tag de la forma XMLELEMENT("ALIAS",columna)
select XMLELEMENT("Emp", 
   XMLFOREST(e.FIRST_NAME, e.PHONE_NUMBER, e.salary))
FROM HR.EMPLOYEES e;

---subquery valido tanto para XMLELMENT como para Forrest

select XMLELEMENT("Emp", 
   XMLFOREST(e.FIRST_NAME, e.PHONE_NUMBER, e.salary,(select count(*)from HR.EMPLOYEES)as total))
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


SELECT XMLElement("job", 
  XMLAttributes(e.EMPLOYEE_ID as id,e.salary AS salario),
     XMLForest(e.First_Name AS "Nombre",
        e.Email  AS "Correo", 
               e.Job_Id AS "Trabajo"))
FROM HR.EMPLOYEES e;

----Impresión de datos XML con encabezado
SELECT XMLRoot(XMLType('<jesus>115620404</jesus>'),
VERSION '1.0', STANDALONE YES) AS xmlroot
FROM DUAL;

--Comentarios
SELECT XMLComment('This is a comment') AS cmnt FROM DUAL; 

---- Sereialize imprime los tags en el formato indicado y no como objetos XMLType soporta varchar,varchar2 y clob
SELECT XMLSerialize(DOCUMENT XMLType('<poid>143598</poid>') AS CLOB)
  AS xmlserialize_doc FROM DUAL; 

---Parse convierte lo que le envién a formato XML a su vez si se usa la keyword wellformed oracle no valida la sintaxis del xml

SELECT XMLParse(CONTENT 
                '124 <purchaseOrder poNo="12435">
                       <customerName> Acme Enterprises</customerName>
                       <itemNo>32987457</itemNo>
                     </purchaseOrder>'
                WELLFORMED)
  AS po FROM DUAL d;

---Extracción de datos---------------------------------------------------------------



   
  
   
   
   




