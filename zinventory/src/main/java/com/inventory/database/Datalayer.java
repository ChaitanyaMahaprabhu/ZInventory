package com.inventory.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.inventory.model.Admin;
import com.inventory.model.Device;
import com.inventory.model.Employee;

public class Datalayer {
	private static final String JDBC_URL = "jdbc:mysql://localhost:3306/zinventory";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "root";
	private static String currentVersion = "5";

	private static Datalayer dbConnection;
	private Connection connection = null;

	public static ArrayList<Admin> adminInfo = new ArrayList<Admin>();
	public static ArrayList<Employee> employeeInfo = new ArrayList<Employee>();

	public void setCurrentVersion(String version) {
		currentVersion = version;
	}
	
	public static String getCurrentVersion() {
		return currentVersion;
	}

	public int[] getCount() {
		int c[] = new int[2];
		String sql = "SELECT count(device_id) FROM Devices WHERE available = 0;";
		try {
			PreparedStatement pst = connection.prepareStatement(sql);

			try (ResultSet rs = pst.executeQuery()) {
				if (rs.next()) {
					c[0] = rs.getInt("count(device_id)");
				}
				sql = "SELECT count(device_id) FROM Devices WHERE available = 1;";
				pst = connection.prepareStatement(sql);
				if (rs.next()) {
					c[1] = rs.getInt("count(device_id)");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return c;
	}
	
	public Device userDeviceDetails(int emp_id) {
		String sql = "SELECT * FROM devices where emp_id = ?;";
		Device device = new Device();
		try {
			PreparedStatement st = connection.prepareStatement(sql);
			st.setInt(1, emp_id);
			ResultSet rs = st.executeQuery();
			while (rs.next()) {
				if(rs.getInt("available") == 0) {
					device.setDevice_id(rs.getInt("device_id"));
					device.setEmp_id(rs.getInt("emp_id"));
					device.setOs_version(rs.getString("os_version"));
				}
			}
			return device;
		} catch (SQLException e) {
			return null;
		}
	}
	
	public List<Device> getAllDevices() {
		List<Device> devices = new ArrayList<>();
		String sql = "SELECT * FROM devices";
		try {
			Statement st = connection.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			while (rs.next()) {
				if(rs.getInt("available") == 0) {
					Device device = new Device();
					device.setDevice_id(rs.getInt("device_id"));
					device.setEmp_id(rs.getInt("emp_id"));
					device.setOs_version(rs.getString("os_version"));
					devices.add(device);
				}
			}
			return devices;
		} catch (SQLException e) {
			return null;
		}
	}

//	public String adminLogin(int id, String password, String usertype) {
//		if (usertype.equals("Admin")) {
//
//			return "admin";
//		}
//
//		else {
//			return "employee";
//		}
//	}

	private Datalayer() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			this.connection = DriverManager.getConnection(JDBC_URL, USERNAME, PASSWORD);
			if (connection != null) {
				System.out.println("Connected to the database!");
			} else {
				System.out.println("Failed to make connection!");
			}
		} catch (ClassNotFoundException e) {
			System.out.println("MySQL JDBC Driver not found!");
		} catch (SQLException e) {
			System.out.println("Connection Failed! Check output console");
		}
	}

	public static Datalayer getInstance() {
		if (dbConnection == null) {
			dbConnection = new Datalayer();
		}

		return dbConnection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public Connection getConnection() {
		return connection;
	}

	public boolean validateUser(int id, String usertype, String password) {
		System.out.println("Validate User");
		String sql = "";
		if (usertype.equals("admin")) {
			sql = "SELECT * FROM Admin WHERE admin_id = ? AND password = ?";
			
		} else {
			sql = "SELECT * FROM Employee WHERE emp_id = ? AND password = ?";
			
		}
		try (Connection conn = Datalayer.getInstance().getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, id);
			stmt.setString(2, password);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					int count = rs.getInt(1);
					return count > 0;
				}
			}
		} catch (Exception e) {
			System.out.println("Exception");
			e.printStackTrace();
		}
		
		return false; // Return false in case of any exception
	}
}
