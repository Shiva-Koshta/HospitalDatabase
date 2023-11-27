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

    public  void PrintAllDocTor(Connection connection)
    {
        Statement statement = null;
        ResultSet resultSet = null;

        try {

            // Creating a statement
            statement = connection.createStatement();

            // Executing the query
            String query = "SELECT * FROM Doctors";
            resultSet = statement.executeQuery(query);

            // Processing the result set
            while (resultSet.next()) {
                // Retrieve data from each row
                int doctorId = resultSet.getInt("d_reg_id");
                String doctorName = resultSet.getString("d_name");
                int cabinNumber = resultSet.getInt("d_cabin_no");

                // Print or process the retrieved data
                System.out.println("Doctor ID: " + doctorId);
                System.out.println("Doctor Name: " + doctorName);
                System.out.println("Cabin Number: " + cabinNumber);
                System.out.println("------------------------");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Closing the resources
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void PrintAllSchedules(Connection connection) {
        Statement statement = null;
        ResultSet resultSet = null;
        try {
            statement = connection.createStatement();
            String sqlQuery = "SELECT * FROM Schedule"; // Query modified to select from the Schedule table
            resultSet = statement.executeQuery(sqlQuery);

            // Process the result set
            while (resultSet.next()) {
                int scheduleId = resultSet.getInt("s_id");
                Time startTime = resultSet.getTime("Start_Time");
                Time endTime = resultSet.getTime("End_Time");

                // Display retrieved data
                System.out.println("Schedule ID: " + scheduleId +
                        ", Start Time: " + startTime +
                        ", End Time: " + endTime);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void PrintAllAppointments(Connection connection) {
        Statement statement = null;
        ResultSet resultSet = null;

        try {
            statement = connection.createStatement();
            String sqlQuery = "SELECT * FROM Appointments"; // Query modified to select from the Appointments table
            resultSet = statement.executeQuery(sqlQuery);

            // Process the result set
            while (resultSet.next()) {
                int patientId = resultSet.getInt("p_id");
                int scheduleId = resultSet.getInt("s_id");
                int doctorId = resultSet.getInt("reg_id");

                // Display retrieved data
                System.out.println("Patient ID: " + patientId +
                        ", Schedule ID: " + scheduleId +
                        ", Doctor ID: " + doctorId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void executeInsertPatient(Connection connection, int p_id, String p_gender, String p_name, String p_address, int p_age) {
        CallableStatement callableStatement = null;

        try {
            // Assuming InsertPatient is a stored procedure or function
            String storedProcedure = "{CALL InsertPatient(?, ?, ?, ?, ?)}";
            callableStatement = connection.prepareCall(storedProcedure);

            // Set parameters
            callableStatement.setInt(1, p_id);
            callableStatement.setString(2, p_gender);
            callableStatement.setString(3, p_name);
            callableStatement.setString(4, p_address);
            callableStatement.setInt(5, p_age);

            // Execute the stored procedure
            callableStatement.execute();

            System.out.println("InsertPatient executed successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (callableStatement != null) callableStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void executeInsertDoctor(Connection connection, int d_reg_id, String d_name, int d_cabin_no) {
        CallableStatement callableStatement = null;

        try {
            // Assuming InsertDoctor is a stored procedure or function
            String storedProcedure = "{CALL InsertDoctor(?, ?, ?)}";
            callableStatement = connection.prepareCall(storedProcedure);

            // Set parameters
            callableStatement.setInt(1, d_reg_id);
            callableStatement.setString(2, d_name);
            callableStatement.setInt(3, d_cabin_no);

            // Execute the stored procedure
            callableStatement.execute();

            System.out.println("InsertDoctor executed successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (callableStatement != null) callableStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void executeInsertHistory(Connection connection, int h_id, int p_id, String date, String p_condition, String p_surgery, String p_link) {
        CallableStatement callableStatement = null;

        try {
            // Assuming InsertHistory is a stored procedure or function
            String storedProcedure = "{CALL InsertHistory(?, ?, ?, ?, ?, ?)}";
            callableStatement = connection.prepareCall(storedProcedure);

            // Set parameters
            callableStatement.setInt(1, h_id);
            callableStatement.setInt(2, p_id);
            callableStatement.setDate(3, Date.valueOf(date));
            callableStatement.setString(4, p_condition);
            callableStatement.setString(5, p_surgery);
            callableStatement.setString(6, p_link);

            // Execute the stored procedure
            callableStatement.execute();

            System.out.println("InsertHistory executed successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (callableStatement != null) callableStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void initSchedule(Connection connection) {
        CallableStatement callableStatement = null;

        try {
            // Assuming InsertSchedule is a stored procedure or function
            String storedProcedure = "{CALL InsertSchedule()}";
            callableStatement = connection.prepareCall(storedProcedure);

            // Execute the stored procedure
            callableStatement.execute();

            System.out.println("Schedule initialized using InsertSchedule successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (callableStatement != null) callableStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public void fillFollow(Connection connection, int s_id, int reg_id) {
        CallableStatement callableStatement = null;

        try {
            // Assuming FillFollow is a stored procedure or function
            String storedProcedure = "{CALL FillFollow(?, ?)}";
            callableStatement = connection.prepareCall(storedProcedure);

            // Set parameters
            callableStatement.setInt(1, s_id);
            callableStatement.setInt(2, reg_id);

            // Execute the stored procedure
            callableStatement.execute();

            System.out.println("FillFollow executed successfully!");

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (callableStatement != null) callableStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public  void insertDocWithSchedule(Connection connection, int d_reg_id, String d_name, int d_cabin_no, int startTime,int Endtime)
    {
        executeInsertDoctor(connection,d_reg_id,d_name,d_cabin_no);

        for (int i = startTime+1; i <=Endtime ; i++) {
                fillFollow(connection,i,d_reg_id);
        }

    }

    public void ExecuteMedicalHistoryQuery(Connection connection, int patientId) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            String sqlQuery = "SELECT * FROM Medical_History WHERE p_id = ?";
            preparedStatement = connection.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, patientId);
            resultSet = preparedStatement.executeQuery();

            // Process the result set
            while (resultSet.next()) {
                int hId = resultSet.getInt("h_id");
                int pId = resultSet.getInt("p_id");
                Date date = resultSet.getDate("date");
                String condition = resultSet.getString("p_condition");
                String surgery = resultSet.getString("p_surgery");
                String link = resultSet.getString("p_link");

                // Display retrieved data
                System.out.println("H_ID: " + hId +
                        ", P_ID: " + pId +
                        ", Date: " + date +
                        ", Condition: " + condition +
                        ", Surgery: " + surgery +
                        ", Link: " + link);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public void printDoctorSchedule(Connection connection, int regId) {
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        try {
            String sqlQuery = "SELECT * FROM Follow WHERE reg_id = ?";
            preparedStatement = connection.prepareStatement(sqlQuery);
            preparedStatement.setInt(1, regId);
            resultSet = preparedStatement.executeQuery();

            // Process the result set
            while (resultSet.next()) {
                int sId = resultSet.getInt("s_id");
                int doctorRegId = resultSet.getInt("reg_id");

                // Display retrieved data
                System.out.println("S_ID: " + sId +
                        ", REG_ID: " + doctorRegId);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close JDBC resources in the reverse order of their creation
            try {
                if (resultSet != null) resultSet.close();
                if (preparedStatement != null) preparedStatement.close();
                // Close the connection should be done outside this method where it's being used
                // if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}

