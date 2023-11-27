import java.sql.Connection;
import java.util.Scanner;
// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {
    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        DBFunctions dbFunction = new DBFunctions();
        Connection connection = dbFunction.connectToDB("finalDatabase","postgres","Shiva1234");

        System.out.println("Welcome to our Hospital Management System Project");
        System.out.println("Here are the various controls :");
        System.out.println("Press");
        System.out.println("0 : Exit");
        System.out.println("1 : Insert Doctor");
        System.out.println("2 : Insert Patient");
        System.out.println("3 : Insert Patient along with medical history");
        System.out.println("4 : See available appointments");
        System.out.println("5 : See a particular doctor schedule");
        System.out.println("6 : See entire hospital schedule");
        System.out.println("7 : See all doctors");
        System.out.println("8 : See all patients");
        System.out.println("9 : See a particular patient medical history");
boolean flag=true;
while(flag){
    System.out.println();
    System.out.println("Enter your choice please");
        int choice = scanner.nextInt();
        switch (choice) {
            case 0:
                System.out.println("Exiting the program. Goodbye!");
//                System.exit(0);
                flag=false;
                break;
            case 1: {
                System.out.println("Enter Doctor Details:");
                System.out.print("Registration ID: ");
                int reg_id = scanner.nextInt();
                System.out.print("Doctor Name: ");
                String d_name = scanner.next();
                System.out.print("Cabin Number: ");
                int start = scanner.nextInt();
                System.out.print("Start time ");
                int cabin_no = scanner.nextInt();
                System.out.print("End Time: ");
                int end = scanner.nextInt();
                dbFunction.insertDocWithSchedule(connection, reg_id, d_name, cabin_no, start, end);
                System.out.println("Doctor inserted successfully!");
                break;
            }
            case 2: {
                System.out.println("Enter Patient Details:");
                System.out.print("Patient ID: ");
                int p_id = scanner.nextInt();
                scanner.nextLine(); // Consume the newline character left by nextInt()
                System.out.print("Gender: ");
                String p_gender = scanner.nextLine();
                System.out.print("Name: ");
                String p_name = scanner.nextLine();
                System.out.print("Address: ");
                String p_address = scanner.nextLine();
                System.out.print("Age: ");
                int p_age = scanner.nextInt();
                dbFunction.executeInsertPatient(connection, p_id, p_gender, p_name, p_address, p_age);
                System.out.println("Patient inserted successfully!");
                break;
            }
            case 3: {
                System.out.println("Enter Patient Details:");
                System.out.print("Patient ID: ");
                int patientId = scanner.nextInt();
                scanner.nextLine(); // Consume the newline character left by nextInt()

                System.out.print("Gender: ");
                String gender = scanner.nextLine();

                System.out.print("Name: ");
                String patientName = scanner.nextLine();

                System.out.print("Address: ");
                String address = scanner.nextLine();

                System.out.print("Age: ");
                int age = scanner.nextInt();
                scanner.nextLine(); // Consume the newline character left by nextInt()

                // Enter Medical History Details
                System.out.println("Enter Medical History Details:");
                System.out.print("History ID: ");
                int historyId = scanner.nextInt();
                scanner.nextLine(); // Consume the newline character left by nextInt()

                System.out.print("Date (YYYY-MM-DD): ");
                String date = scanner.nextLine();

                System.out.print("Condition: ");
                String condition = scanner.nextLine();

                System.out.print("Surgery: ");
                String surgery = scanner.nextLine();

                System.out.print("Link: ");
                String link = scanner.nextLine();

                // Execute InsertPatient and InsertHistory
                dbFunction.executeInsertPatient(connection, patientId, gender, patientName, address, age);
                dbFunction.executeInsertHistory(connection, historyId, patientId, date, condition, surgery, link);

                System.out.println("Patient and Medical History inserted successfully!");

                break;
            }
            case 4: {
                System.out.println("Available Appointments:");
                dbFunction.PrintAllAppointments(connection);
                break;
            }
            case 5: {
                System.out.println("Enter Doctor ID:");
                int doctorId = scanner.nextInt();

                System.out.println("Doctor Schedule for ID " + doctorId + ":");
                dbFunction.printDoctorSchedule(connection, doctorId);
                break;
            }
            case 6: {
                System.out.println("Entire Hospital Schedule:");
                dbFunction.PrintAllSchedules(connection);
                break;
            }
            case 7: {
                System.out.println("All Doctors:");
                dbFunction.PrintAllDocTor(connection);
                break;
            }
            case 8: {
                System.out.println("All Patients:");
                dbFunction.PrintAllP(connection);
                break;
            }
            case 9:
                System.out.println("Enter Patient ID:");
                int patientIdForHistory = scanner.nextInt();

                System.out.println("Patient Medical History for ID " + patientIdForHistory + ":");
                dbFunction.ExecuteMedicalHistoryQuery(connection, patientIdForHistory);
                break;

        }








        }

    }
}