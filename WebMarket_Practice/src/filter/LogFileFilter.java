package filter;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

public class LogFileFilter implements Filter {

	PrintWriter writer;
	
	public void init(FilterConfig fileConfig) throws ServletException {
		String filename = fileConfig.getInitParameter("filename");
		
		if (filename == null) throw new ServletException("�α� ������ �̸��� ã�� �� �����ϴ�.");
		
		try {
			writer = new PrintWriter(new FileWriter(filename, true), true);
		} catch (IOException e) {
			throw new ServletException("�α� ������ �� �� �����ϴ�.");
		}
	}
	
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws java.io.IOException, ServletException {
		writer.println(" ������ Ŭ���̾�Ʈ IP : " + request.getRemoteAddr());
		long start = System.currentTimeMillis();
		writer.println(" ������ URL ��� : " + getURLPath(request));
		writer.println(" ��û ó�� ���� �ð� : " + getCurrentTime());
		
		filterChain.doFilter(request, response);
		
		long end = System.currentTimeMillis();
		writer.println(" ��û ó�� ���� �ð� : " + getCurrentTime());
		writer.println(" ��û ó�� �ҿ� �ð� : " + (end - start) + "ms ");
		writer.println("====================================================");
	}
	
	public void destroy() {
		writer.close();
	}
	
	private String getURLPath(ServletRequest request) {
		HttpServletRequest req;
		String currentPath = "";
		String queryString = "";
		if (request instanceof HttpServletRequest) {
			req = (HttpServletRequest)request;
			currentPath = req.getRequestURI();
			queryString = req.getQueryString();
			queryString = queryString == null ? "" : "?" + queryString;
		}
		return currentPath + queryString;
	}
	
	private String getCurrentTime() {
		DateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Calendar calendar = Calendar.getInstance();
		calendar.setTimeInMillis(System.currentTimeMillis());
		return formatter.format(calendar.getTime());
	}
}