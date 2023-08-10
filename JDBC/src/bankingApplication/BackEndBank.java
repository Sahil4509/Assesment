package bankingApplication;

	import java.util.Scanner;
	import java.sql.*;
	import java.util.Random;
	import java.util.Date;

	public class BackEndBank {
		
		Scanner inputget=new Scanner(System.in);
		
		public void createAccount() throws ClassNotFoundException, SQLException {		
			
			//Account Number
			Random random=new Random();
			final long min =1000000000000L;
			final long max = 9999999999999L;
			long accountNumber=(long)(random.nextDouble()*(max-min));
		
			
			//Name
			System.out.println("Enter your Name = ");
			String name=inputget.nextLine();
			
			//Location
			System.out.println("Enter your Location = ");
			String location=inputget.nextLine();
			
			//Phone Number
			System.out.println("Enter your Phone Number = ");
			long phone_Number=inputget.nextLong();
			
			System.out.println("\n");

			//Connection
			Connection con=JdbcConnections.connection();
			
			//Query1 Create Account
			con.setAutoCommit(false);
			
			//insert the values in user_details table
			PreparedStatement ps1 = con.prepareStatement("insert into user_details values(?,?,?,?)");
			ps1.setLong(1,accountNumber);
			ps1.setString(2, name);
			ps1.setString(3, location);
			ps1.setLong(4, phone_Number);
			
			//preview
			int row;
			do{
			System.out.println("================================");
			System.out.println("Please review and confirm by pressing 1");
			System.out.println("Account created successfully...");
			System.out.println("Account Holder Name = " + name);
			System.out.println("Account number = " + accountNumber);
			System.out.println("Account Branch Location = " + location);
			System.out.println("Account Holder Phone Number = " + phone_Number);
			System.out.println("Please confirm by pressing 1");
			System.out.println("================================");
			System.out.println("\n");
			row=inputget.nextInt();
			if(row!=1) {
				System.out.println("================================");
				System.out.println("Try Again");
				System.out.println("================================");
				System.out.println("\n");
			}
			}while(row!=1);
			
			ps1.executeUpdate();
			
			if (row==1) {
				con.commit();
				System.out.println("================================");
				System.out.println("Account created successfully...");
				System.out.println("================================");
				System.out.println("\n");
			}
			
			//Query2 To create Money Status for Account
			String query = "create table "+name+"_"+accountNumber+" (Statement_No INT PRIMARY KEY AUTO_INCREMENT,Date DATETIME,Credited DOUBLE DEFAULT '0.0' ,Withdrawal DOUBLE DEFAULT '0.0',Balance DOUBLE);";
			Statement stm = con.createStatement();
			
			stm.executeUpdate(query);
			
			//Money to initial deposit
			con.setAutoCommit(false);
			System.out.println("================================");
			System.out.println("What is your initial deposit amount = ");
			int deposit=inputget.nextInt();
			double initialDeposit=(double)deposit;
			PreparedStatement ps2 = con.prepareStatement("insert into "+name+"_"+accountNumber+" (Date,Credited,Balance) value(now(),?,?);");
			ps2.setDouble(1,initialDeposit);
			ps2.setDouble(2, initialDeposit);
		
			int row1 = ps2.executeUpdate();
			if (row1>0) {
				con.commit();
			System.out.println("================================");
			System.out.println("\n");
			}
			
			//Connection Close
			con.close();
		}
		
		public void balance() {
			
			//To view Balance
			System.out.println("================================");
			System.out.println("Enter your Name = ");
			String name=inputget.nextLine();
			System.out.println("Enter your account number = ");
			long accountNumber=inputget.nextLong();
			System.out.println("================================");
			System.out.println("\n");
			
			//Connection
			try{
				Connection con=JdbcConnections.connection();
			
				Statement stm= con.createStatement();
			
				String Query="select Balance from "+name+"_"+accountNumber+" order by Balance desc limit 1;";
			
				ResultSet rs=stm.executeQuery(Query);
			
				rs.next();
				System.out.println("================================");
				System.out.println("Name: "+name);
				System.out.println("Account Number: "+accountNumber);
				System.out.println("Your Account Balance = " +rs.getDouble(1));
				System.out.println("================================");
				System.out.println("\n");
				
				//Connection Close
				con.close();
			}
			catch(Exception e) {
			System.out.println("================================");
			System.out.println("Error: User not found");
			System.out.println("================================");
			System.out.println("\n");
			}
		}
		
		public void deposit() {

			System.out.println("================================");
			System.out.println("Enter your Name = ");
			String name = inputget.nextLine();
			System.out.println("Enter your Account Number = ");
			long accountNumber = inputget.nextLong();
			System.out.println("Enter amount to deposit = ");
			int Amount = inputget.nextInt();
			double depositAmount = (double)Amount;
			System.out.println("================================");
			System.out.println("\n");
			
			try{
				//Connection
				Connection con=JdbcConnections.connection();
				con.setAutoCommit(false);
				
				Statement stm= con.createStatement();
				
				//get the balance and added with deposit money	
				String Query="select balance from "+ name + "_" + accountNumber + " order by Statement_No desc limit 1;";
								
				ResultSet rs=stm.executeQuery(Query);
				rs.next();
				double balance = rs.getInt(1)+depositAmount;
				
				//update the balance in the table
				PreparedStatement ps = con.prepareStatement("insert into "+name+"_"+accountNumber+" (Date,Credited,Balance) value(now(),?,?);");
				ps.setDouble(1,depositAmount);
				ps.setDouble(2, balance);
					
				int row = ps.executeUpdate();
				if (row>0) {
				con.commit();
				System.out.println("================================");
				System.out.println("Amount Credited Successfully");
				System.out.println("================================");
				System.out.println("\n");
				}	
				//Connection Close
				con.close();
			}
			catch(Exception e) {
				System.out.println("================================");
				System.out.println("Error: User not found");
				System.out.println("================================");
				System.out.println("\n");
				}
		}
		
		public void withdrwal() {
			
			System.out.println("================================");
			System.out.println("Enter your Name = ");
			String name = inputget.nextLine();
			System.out.println("Enter your Account Number = ");
			long accountNumber = inputget.nextLong();
			System.out.println("Enter amount to withdrawal = ");
			int Amount = inputget.nextInt();
			double withdrawalAmount = (double)Amount;
			System.out.println("================================");
			System.out.println("\n");
			
			
			try{
				//Connection
				Connection con=JdbcConnections.connection();
				con.setAutoCommit(false);
				do {
				Statement stm= con.createStatement();
				
				//get the balance and subtract with deposit money
				String Query="select balance from "+ name + "_" + accountNumber + " order by Statement_No desc limit 1;";
						
				ResultSet rs=stm.executeQuery(Query);
				rs.next();
				double balance = rs.getInt(1);
				
				if (balance>withdrawalAmount) {
				balance-=withdrawalAmount;
				
				//update the balance in the table
				PreparedStatement ps = con.prepareStatement("insert into "+name+"_"+accountNumber+" (Date,Withdrawal,Balance) value(now(),?,?);");
				ps.setDouble(1,withdrawalAmount);
				ps.setDouble(2, balance);
			
				int row = ps.executeUpdate();
				if (row>0) {
					con.commit();
					System.out.println("================================");
					System.out.println("Amount Withdrawal Successfully");
					System.out.println("================================");
					System.out.println("\n");
				}
			break;
				}
				else
					System.out.println("Balance is low try again");
					withdrwal();
					
		}while (true);
				
				
				//Connection Close
				con.close();
			}
			catch(Exception e) {
				System.out.println("================================");
				System.out.println("Error: User not found");
				System.out.println("================================");
				System.out.println("\n");
				}
		}
		
	}

