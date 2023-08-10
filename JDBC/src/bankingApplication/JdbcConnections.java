package bankingApplication;
	import java.sql.*;
	public class JdbcConnections {
			private static final String url = "jdbc:mysql://localhost:3306/bank";
			private static final String userName = "root";
			private static final String password = "Sahil@2244";
			
			public static  Connection connection() throws SQLException, ClassNotFoundException {
			Class.forName("com.mysql.cj.jdbc.Driver");
			return DriverManager.getConnection(url,userName,password);
			}
	}


