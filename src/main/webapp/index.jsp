<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.text.*" %>

<%!
    void write(List<String> contentList, String fileName, boolean append, String enc) {
        OutputStreamWriter out = null;
        try {
            out = new OutputStreamWriter(new FileOutputStream(fileName, append),enc);
            for (String str : contentList) {
                out.write(str);
            }
            out.flush();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    public String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if(null == ip || 0 == ip.length() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if(null == ip || 0 == ip.length() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if(null == ip || 0 == ip.length() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if(null == ip || 0 == ip.length() || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }



%>


<%
    String currentTime = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss,S").format(new Date());
    String ip = getIpAddr(request);

    List<String> list = new ArrayList<String>();
    list.add(currentTime + " " + "INFO" + " com.jd.jdos.Test " + " " + ip + " this content is for INFO log test!" +" \r\n");
    list.add(currentTime + " " + "ERROR" + " com.jd.jdos.Test " + " " + ip + " this content is for ERROR log test!" +" \r\n");
    list.add(currentTime + " " + "DEBUG" + " com.jd.jdos.Test " + " " + ip + " this content is for DEBUG log test!" +" \r\n");
    write(list, "/export/Logs/cijd.log", true,"UTF-8");

%>
<html>
<title>welcom haha!</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">　
<body>
<div align="center">
<h1>welcom haha!</h1></div>
<div align="center"><h2><% out.print(currentTime); %></h2></div>
<div align="center">
    VIP：<%
        out.print(ip);
    %><br/>Docker IP：
   <%
        out.print(request.getLocalAddr());
  %>
  



</div>
</body>
</html>
