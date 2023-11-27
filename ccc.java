import java.sql.*;

public class RetrievePatientData {
    public static void main(String[] args) {
        // JDBC connection parameters
        String url = "jdbc:postgresql://localhost:5432/your_database"; // Replace with your database URL
        String user = "your_username";
        String password = "your_password";

        // JDBC variables
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            // Establish connection
            connection = DriverManager.getConnection(url, user, password);

            // Create and execute SQL query
            statement = connection.createStatement();
            String sqlQuery = "SELECT * FROM Patient";
            resultSet = statement.executeQuery(sqlQuery);

            // Process the result set
            while (resultSet.next()) {
                int patientId = resultSet.getInt("p_id");
                String gender = resultSet.getString("p_gender");
                String name = resultSet.getString("p_name");
                String address = resultSet.getString("p_address");
                int age = resultSet.getInt("p_age");

                // Display retrieved data
                System.out.println("Patient ID: " + patientId +
                        ", Gender: " + gender +
                        ", Name: " + name +
                        ", Address: " + address +
                        ", Age: " + age);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
