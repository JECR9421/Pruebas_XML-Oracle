 SET SERVEROUTPUT ON [20000];
declare
   cant_nodos NUMBER;
   xml Clob;
   valor VARCHAR2(125);
   tag varchar2(100);
   tagname varchar2(100);
 begin
 cant_nodos := 0;
 xml:= '<SdtRequest>
  <Header>
    <Object_Id>299</Object_Id>
    <Credencial>150808SX8088</Credencial>
    <UserName>DBPMS</UserName>
    <SupervisorName>DBPMS</SupervisorName>
    <Action>E</Action>
    <Value>1</Value>
  </Header>
  <Parametros>
    <SdtRequest.Parametro>
      <P>GV_XML</P>
      <X><![CDATA[<DATA><ROWS etapa="18"   hilo_activo="14941"     hilo="6328"    cerrar="S"  usuarioelegido="0"  plantilla="11"> </ROWS></DATA>]]></X>
    </SdtRequest.Parametro>
  </Parametros>
  </SdtRequest>';
  
  GetRegistrosXML(xml,'//SdtRequest/Header/*',cant_nodos);
   DBMS_OUTPUT.PUT_LINE (cant_nodos);
   
   for i in 1..cant_nodos loop 
   tag := '//SdtRequest/Header/*['|| to_char(i) ||']';
   
   SELECT
    xmltype(xml).extract(tag).getrootelement() node into tagname/*,
    extractvalue(xmltype(xml),tag) columna into valor*/
       FROM dual; 
       
   SELECT
    /* xmltype(xml).extract(tag).getrootelement() node into tagname,*/
    extractvalue(xmltype(xml),tag) columna into valor
       FROM dual; 
       
    
   
   dbms_output.put_line(tagname||':'||valor);
   end loop;
  
end;

  
  SELECT value(T).getstringval() Attribute_Value
  FROM table(XMLSequence(extract(xmltype('<SdtRequest>
  <Header>
    <Object_Id>299</Object_Id>
    <Credencial>150808SX8088</Credencial>
    <UserName>DBPMS</UserName>
    <SupervisorName>DBPMS</SupervisorName>
    <Action>E</Action>
    <Value>1</Value>
  </Header>
  <Parametros>
    <SdtRequest.Parametro>
      <P>GV_XML</P>
      <X><![CDATA[<DATA><ROWS etapa="18"   hilo_activo="14941"     hilo="6328"    cerrar="S"  usuarioelegido="0"  plantilla="11"> </ROWS></DATA>]]></X>
    </SdtRequest.Parametro>
  </Parametros>
  </SdtRequest>'),'//SdtRequest/Header/*'))) T;
  
  
  SELECT extractvalue(value(T), '/Header/Object_Id') "objetc_id"
  FROM table(XMLSequence(extract(xmltype('<SdtRequest>
  <Header>
    <Object_Id>299</Object_Id>
    <Credencial>150808SX8088</Credencial>
    <UserName>DBPMS</UserName>
    <SupervisorName>DBPMS</SupervisorName>
    <Action>E</Action>
    <Value>1</Value>
  </Header>
  <Parametros>
    <SdtRequest.Parametro>
      <P>GV_XML</P>
      <X><![CDATA[<DATA><ROWS etapa="18"   hilo_activo="14941"     hilo="6328"    cerrar="S"  usuarioelegido="0"  plantilla="11"> </ROWS></DATA>]]></X>
    </SdtRequest.Parametro>
  </Parametros>
  </SdtRequest>'),'//SdtRequest/Header'))) T;
  
  
  SELECT
extractvalue(
xmltype('<SdtRequest>
  <Header>
    <Object_Id>299</Object_Id>
    <Credencial>150808SX8088</Credencial>
    <UserName>DBPMS</UserName>
    <SupervisorName>DBPMS</SupervisorName>
    <Action>E</Action>
    <Value>1</Value>
  </Header>
  <Parametros>
    <SdtRequest.Parametro>
      <P>GV_XML</P>
      <X><![CDATA[<DATA><ROWS etapa="18"   hilo_activo="14941"     hilo="6328"    cerrar="S"  usuarioelegido="0"  plantilla="11"> </ROWS></DATA>]]></X>
    </SdtRequest.Parametro>
  </Parametros>
  </SdtRequest>'),'//SdtRequest/Header/*[2]') hilo
   FROM dual;   




