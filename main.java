import java.sql.Connection;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {

        DBFunctions dbFunction = new DBFunctions();

        Connection connection = dbFunction.connectToDB("finalDatabase","postgres","Shiva1234");

        dbFunction.PrintAllP(connection);

    }
}