package commons;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
	public Connection getConnection() throws ClassNotFoundException, SQLException {
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.01:3306/shop", "root", "java1004");
		//Connection conn = DriverManager.getConnection("jdbc:mariadb://15.165.194.216/shop", "root", "java1004");
		return conn;
	}
}
