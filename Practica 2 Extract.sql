create  table parametros(p varchar2(50),v varchar2(50));
declare
   cant_nodos NUMBER;
   xml Clob;
   object_id VARCHAR2(125);
   credencial VARCHAR2(125);
   user_name VARCHAR2(125);
   supervisor_name VARCHAR2(125);
   action VARCHAR2(125);
   value1 VARCHAR2(125);
   tag varchar2(100);
   
 begin
 cant_nodos := 0;
 xml:= '<SdtRequest>
  <Header>
    <Object_Id>500</Object_Id>
    <Credencial>150808SX8088</Credencial>
    <UserName>DBPMS</UserName>
    <SupervisorName>DBPMS</SupervisorName>
    <Action>S</Action>
    <Value>1</Value>
  </Header>
  <Parametros>
    <SdtRequest.Parametro>
      <P>PARAM1</P>
      <V>6326</V>
    </SdtRequest.Parametro>
    <SdtRequest.Parametro>
      <P>PARAM2</P>
      <V>14815</V>
    </SdtRequest.Parametro>
    <SdtRequest.Parametro>
      <P>CEDULA</P>
      <V>3434366667</V>
    </SdtRequest.Parametro>
    <SdtRequest.Parametro>
      <P>NOMBRE</P>
      <V>Ademar Diaz</V>
    </SdtRequest.Parametro>
  </Parametros>
</SdtRequest>';
  
  
   SELECT
    extractvalue(xmltype(xml),'//Header/Object_Id') columna into object_id
       FROM dual;   
       
       dbms_output.put_line('Object_Id:' || object_id);
       
     SELECT
    extractvalue(xmltype(xml),'//Header/Credencial') columna into credencial
       FROM dual; 
       
       dbms_output.put_line('Credencial:' || credencial);
       
        SELECT
    extractvalue(xmltype(xml),'//Header/UserName') columna into user_name
       FROM dual;   
       
       dbms_output.put_line('UserName:' || user_name);
       
        SELECT
    extractvalue(xmltype(xml),'//Header/SupervisorName') columna into supervisor_name
       FROM dual;
       
       dbms_output.put_line('SupervisorName:' || supervisor_name);
       
        SELECT
    extractvalue(xmltype(xml),'//Header/Action') columna into action
       FROM dual;   
       
        dbms_output.put_line('Action:' || action);
       
        SELECT
    extractvalue(xmltype(xml),'//Header/Value') columna into value1
       FROM dual;   
         
          dbms_output.put_line('Value:' || value1);
   
   GetRegistrosXML(xml,'//Parametros/SdtRequest.Parametro',cant_nodos);
   DBMS_OUTPUT.PUT_LINE ('Cantidad de Parametros:' || cant_nodos);
   delete  from parametros;
   For i in 1..cant_nodos loop 
     Declare
     P varchar2(50);
     V varchar2(50);
     begin
      tag := '//Parametros/SdtRequest.Parametro['|| to_char(i) ||']';
      SELECT
        extractvalue(
        xmltype( xml),tag ||'/P') p into P
       FROM dual;
       
       SELECT
        extractvalue(
        xmltype( xml),tag ||'/V') v into V
       FROM dual;
       
      Insert into  parametros values(P,V); 
     end; 
 end loop;
  
  DBMS_OUTPUT.PUT_LINE ('Parametros Almencenados correctamente en la tabla');
  Commit;
  
end;
select * from PARAMETROS;  


 