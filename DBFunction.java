import java.sql.*;

public class DBFunctions {
    public Connection connectToDB(String dbname, String user, String pass)
    {
        Connection connection = null;

        try {
            Class.forName("org.postgresql.Driver");
            connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/"+dbname,user,pass);
            if(connection != null)
                System.out.println("Connection Established");
            else
                System.out.println("Connection failed");

        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return  connection;
    }

    public void PrintAllP(Connection connection)
    {
//        Statement statement ;
//        try {
//            String querry =  "create table " + name + "(empid SERIAL, name varchar(100), address varchar(200), primary key (empid));";
//            statement = conn.createStatement();
//            statement.executeUpdate(querry);
//            System.out.println("Table Created");
//        } catch (Exception e) {
//            System.out.println(e);
//        }

        Statement statement = null;
        ResultSet resultSet = null;
        try {

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
//                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
