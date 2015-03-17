
 SET SERVEROUTPUT ON [20000]; 
Declare
  xml clob;
  subxml clob;
  subxml_extract xmltype;
  etapa varchar2(4);
  hilo_activo varchar2(7);
  hilo varchar2(6);
  cerrar varchar2(1);
  usuarioelegido varchar2(1);
  plantilla varchar2(3);
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
   
  dbms_output.put_line('subxml:'||subxml);
  
 /* subxml_extract := xmltype.createxml(subxml);
  
etapa := subxml_extract.EXTRACT('//DATA/ROWS/@etapa').getstringval();*/

SELECT extract(xmltype(subxml),'//DATA/ROWS/@etapa').getstringval() Subxml into etapa
   FROM dual;
   
SELECT extract(xmltype(subxml),'//DATA/ROWS/@hilo_activo').getstringval() Subxml into hilo_activo
   FROM dual;
   
SELECT extract(xmltype(subxml),'//DATA/ROWS/@hilo').getstringval() Subxml into hilo
   FROM dual;
   
SELECT extract(xmltype(subxml),'//DATA/ROWS/@cerrar').getstringval() Subxml into cerrar
   FROM dual;
   
SELECT extract(xmltype(subxml),'//DATA/ROWS/@usuarioelegido').getstringval() Subxml into usuarioelegido
   FROM dual;

SELECT extract(xmltype(subxml),'//DATA/ROWS/@plantilla').getstringval() Subxml into plantilla
   FROM dual;
  dbms_output.put_line('Atributos subxml');
  dbms_output.put_line('Etapa:'||etapa);
  dbms_output.put_line('Hilo Activo:'||hilo_activo);
  dbms_output.put_line('Hilo:'||hilo);
  dbms_output.put_line('Cerrar:'||cerrar);
  dbms_output.put_line('Usuario Elegido:'||usuarioelegido);
  dbms_output.put_line('Plantilla:'||plantilla);

end;
   
   
    
   
   
   