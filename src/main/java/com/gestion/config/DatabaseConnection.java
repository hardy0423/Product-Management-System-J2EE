package com.gestion.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
	private static DatabaseConnection instance;
	private Connection connection;

	private static final String URL = "jdbc:postgresql://localhost:5432/table_name";
	private static final String USER = "user_name";
	private static final String PASSWORD = "";
	private static final String DRIVER = "org.postgresql.Driver";

	private DatabaseConnection() throws SQLException {
		try {
			Class.forName(DRIVER);
			this.connection = DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("Connexion à PostgreSQL établie avec succès");
		} catch (ClassNotFoundException e) {
			throw new SQLException("Driver PostgreSQL non trouvé", e);
		}
	}

	public static DatabaseConnection getInstance() throws SQLException {
		if (instance == null || instance.getConnection().isClosed()) {
			synchronized (DatabaseConnection.class) {
				if (instance == null || instance.getConnection().isClosed()) {
					instance = new DatabaseConnection();
				}
			}
		}
		return instance;
	}

	public Connection getConnection() {
		return connection;
	}

	public void closeConnection() {
		if (connection != null) {
			try {
				connection.close();
				System.out.println("Connexion fermée");
			} catch (SQLException e) {
				System.err.println("Erreur lors de la fermeture : " + e.getMessage());
			}
		}
	}
}