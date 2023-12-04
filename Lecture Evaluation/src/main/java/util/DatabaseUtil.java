package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {
	
	private DatabaseUtil() {}
		
		private static class LazyHolder {
			public static final DatabaseUtil INSTANCE = new DatabaseUtil();
		}
		
		public static DatabaseUtil getInstance() {
			return LazyHolder.INSTANCE;
	}

	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			return DriverManager.getConnection(dbURL,dbID,dbPassword);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
	

