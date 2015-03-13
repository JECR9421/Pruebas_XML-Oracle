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

---XMLGEN es similar a XMLELEMENT o inclusive XMLFORREST solo que devuelve un doc completo con la estructura xml y no solo un conjunto de tags
SELECT SYS_XMLGen(XMLELEMENT("Emp", 
   XMLFOREST(e.FIRST_NAME, e.PHONE_NUMBER, e.salary)))
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
/*SELECT EXTRACT(warehouse_spec, '/Warehouse') as "Warehouse"
   FROM warehouses WHERE warehouse_name = 'San Francisco';*/
--Extrat saca los nodos que le son indicados  de la forma extract (xml_file,'nodos que quiero sacar //nodo_padre/nodo_hijo')
SELECT
extract(
xmltype('<DATA>
  <ROWS etapa="2"     hilo_activo="14804"    hilo="6325"    cerrar="S"  usuarioelegido="0"  plantilla="8">
    <ROW  secuencia="18351">ESTO PRUEBA</ROW>
  </ROWS>
</DATA>'),'//ROWS/ROW') hilo
   FROM dual;   
   
-- En caso de existir más de un elemento dentro del mismo nodo o tag es necesario especificar cual se desea sacar 
--Como si fuera un arreglo [#] # --> iniciando en 1 del modo //nodo_padre/nodo[#]

SELECT
extract(
xmltype('<DATA>
  <ROWS etapa="2"     hilo_activo="14804"    hilo="6325"    cerrar="S"  usuarioelegido="0"  plantilla="8">
    <ROW  secuencia="18351">ESTO PRUEBA</ROW>
    <ROW  secuencia="18352"/>
  </ROWS>
</DATA>'),'//ROWS/ROW[2]') hilo
   FROM dual;   
   
--ExtractValue esta función es más avanzada ya que extrae el valor en medio de los <tag> y </tag> en implementación es igual a extract

SELECT
extractvalue(
xmltype('<DATA>
  <ROWS etapa="2"     hilo_activo="14804"    hilo="6325"    cerrar="S"  usuarioelegido="0"  plantilla="8">
    <ROW  secuencia="18351">ESTO PRUEBA</ROW>
    <ROW  secuencia="18352"/>
  </ROWS>
</DATA>'),'//ROWS/ROW[1]') hilo
   FROM dual;   
  
--Para extraer múltiples valores es necesario utilizar XMLSEQUENCE que genera algo similar a un array de con los elementos contenidos en 
--el /nodo especificado al generar un varray necesita utilizar la sentencia from
--extract value no soporta multiples valores 
--extract por su parte si pero los imprime como una fila unica
--Por estos motivos es recomendable utilizar XMLSequence para el manejo de múltiples datos dentro de un nodo o tag

SELECT value(T).getstringval() Attribute_Value
  FROM table(XMLSequence(extract(XMLType('<A><B>V1</B><B>V2</B><B>V3</B></A>'),
                                 '/A/B'))) T;
                                 
--Aplicado al ejemplo anterior
--Comparando ejecución de extract con secuencia y sin la misma
SELECT value(T).getstringval() Attribute_Value
  FROM table(XMLSequence(extract(
xmltype('<DATA>
  <ROWS etapa="2"     hilo_activo="14804"    hilo="6325"    cerrar="S"  usuarioelegido="0"  plantilla="8">
    <ROW  secuencia="18351">ESTO PRUEBA</ROW>
    <ROW  secuencia="18352"/>
  </ROWS>
</DATA>'),'//ROWS/ROW'))) T;

SELECT
extract(
xmltype('<DATA>
  <ROWS etapa="2"     hilo_activo="14804"    hilo="6325"    cerrar="S"  usuarioelegido="0"  plantilla="8">
    <ROW  secuencia="18351">ESTO PRUEBA</ROW>
    <ROW  secuencia="18352"/>
  </ROWS>
</DATA>'),'//ROWS/ROW') hilo
   FROM dual; 
   





   
  
   
   
   




