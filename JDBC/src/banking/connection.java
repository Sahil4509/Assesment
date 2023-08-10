package banking;
	import java.sql.*;
	public class connection {
	    public static void main(String[] args) {
	    
	       try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            Connection con =     DriverManager.getConnection("jdbc:mysql://localhost:3306/bank","root", "Sahil@2244");
                System.out.println("sahil");
	       }catch (Exception e) {
	        // TODO: handle exception
	    }

	    }

		public static Connection getConnection() {
	         System.out.println("get connected");
			return null;
		}
	}

		