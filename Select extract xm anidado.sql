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
  </SdtRequest>'),'//SdtRequest/Parametros/SdtRequest.Parametro/*[2]') hilo
   FROM dual;   
 SET SERVEROUTPUT ON [20000]; 
Declare
  xml clob;
  subxml clob;
  subxml_extract xmltype;
  etapa varchar2(4);
begin 
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
  
  subxml := '';
  
  SELECT
extractvalue(
xmltype(xml),'//SdtRequest/Parametros/SdtRequest.Parametro/*[2]') Subxml into subxml
   FROM dual;   
  --dbms_output.put_line(subxml);
  
  subxml_extract := xmltype.createxml(subxml);
  
etapa := subxml_extract.EXTRACT('//DATA/ROWS/@etapa').getstringval();

  
  dbms_output.put_line(etapa);


end;
   
   
    
   
   
   