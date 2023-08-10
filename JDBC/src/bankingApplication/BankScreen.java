package bankingApplication;

import java.sql.*;
import java.util.Scanner;

public class BankScreen {

	public static void main(String[] args) throws ClassNotFoundException, SQLException {
		
	while(true) {
		
		BankDisplay display1=new BankDisplay();
		display1.welcome();
		display1.menu();
		  Scanner inputget=new Scanner(System.in);
		System.out.println("================================");
		System.out.println("Select the option = ");
		int option=inputget.nextInt();
		System.out.println("================================");
		System.out.println("\n");
		
		if (option == 1) {//Account Creation
			BackEndBank accountCreation=new BackEndBank();
			accountCreation.createAccount();
		}
		else if (option == 2) {//Check Balance
			
			BackEndBank accountCreation=new BackEndBank();
			accountCreation.balance();
		}
		else if (option == 3) {//deposit
			BackEndBank accountCreation=new BackEndBank();
			accountCreation.deposit();
		}
		else if (option == 4) {//withdrawal
			BackEndBank accountCreation=new BackEndBank();
			accountCreation.withdrwal();
		}
		else if (option == 5) {//exit
			System.out.println("Thank You");
			break;
			
		}
		else {
			System.out.println("Invalid Option!.. \nTry again");
		}
	}
	}
}