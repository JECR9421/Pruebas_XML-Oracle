 SET SERVEROUTPUT ON [20000];
declare
   cant_nodos NUMBER;
   xml Clob;
   valor VARCHAR2(125);
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
  
  GetRegistrosXML(xml,'//SdtRequest/Header',cant_nodos);
   DBMS_OUTPUT.PUT_LINE (cant_nodos);
  FOR i IN 1..cant_nodos LOOP
    SELECT into valor
extractvalue(
/*xmltype(xml),'//SdtRequest/Header'||'['||i||']') hilo*/
xmltype(xml),'//SdtRequest/Header/Object_Id') hilo
   FROM dual;
   DBMS_OUTPUT.PUT_LINE (valor);
  END LOOP;
end;

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
  </SdtRequest>'),'//SdtRequest/Header/Object_Id') hilo
   FROM dual;




