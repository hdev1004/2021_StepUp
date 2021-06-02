<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="org.w3c.dom.*"%>
<%@ page import="javax.xml.parsers.*" %>
<%@ page import="java.util.*" %>

<%
//map을 담을 리스트 만들기
List<Map> pubList = new ArrayList();

//xml 데이터 호출하기
String url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=tcxFOnkwx%2FY%2Bx1N38JCOXpS3ITqYOdiM%2FwnC%2B6slZFJtnPkOXjyOKnnNLaxlHgdEO4tMJcHbO7bTX%2BETC0hTKA%3D%3D&bgnde=20200501&endde=20210630&upkind=417000&state=notice&pageNo=1&numOfRows=10&neuter_yn=Y";
DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
DocumentBuilder builder = factory.newDocumentBuilder();
Document document = builder.parse(url);
NodeList items = document.getElementsByTagName("items");

String[] elements = {"age", "careAddr", "careNm", "careTel", "chargeNm", "colorCd",
                "desertionNo", "filename", "happenDt", "happenPlace", "kindCd"};

for(int i=0; i < items.getLength(); i++) {
        Node n = items.item(i);

        Element e = (Element) n;

        Map<String, String> pub = new HashMap();

        //child를 기준으로 for문 만들기
        for(String element : elements) {
                NodeList titleList = e.getElementsByTagName(element);
                Element titleElement = (Element)titleList.item(0);
                Node titleNode = titleElement.getChildNodes().item(0);
                pub.put(element, titleNode.getNodeValue());
        }
        //리스트에 map 담기
        pubList.add(pub);
}

out.print(pubList);

%>

<%!
//쉼표 추가를 위한 메소드 선언
DecimalFormat df = new DecimalFormat("#,##0");
public String myFormat(String str) {
        return df.format( Long.parseLong(str) );
}
%>