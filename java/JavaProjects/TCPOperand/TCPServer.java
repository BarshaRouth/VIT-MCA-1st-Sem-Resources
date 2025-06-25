package TCPOperand;

import java.io.*;
import java.net.*;

public class TCPServer {
    public static void main(String[] args) {
        try (ServerSocket serverSocket = new ServerSocket(1234)) {
            // System.out.println("Server is listening on port 1234");
            while (true) {
                try (Socket socket = serverSocket.accept();
                     DataInputStream dis = new DataInputStream(socket.getInputStream());
                     DataOutputStream dos = new DataOutputStream(socket.getOutputStream())) {

                    String expression = dis.readUTF();
                    String[] tokens = expression.split(" ");
                    int operand1 = Integer.parseInt(tokens[0]);
                    String operator = tokens[1];
                    int operand2 = Integer.parseInt(tokens[2]);

                    int result = 0;
                    switch (operator) {
                        case "+":
                            result = operand1 + operand2;
                            break;
                        case "-":
                            result = operand1 - operand2;
                            break;
                        case "*":
                            result = operand1 * operand2;
                            break;
                        case "/":
                            if (operand2 != 0) {
                                result = operand1 / operand2;
                            } else {
                                dos.writeUTF("Error: Division by zero");
                                continue;
                            }
                            break;
                        default:
                            dos.writeUTF("Error: Unknown operator");
                            continue;
                    }

                    dos.writeUTF("Result: " + result);
                } catch (Exception e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            System.out.println("Server exception: " + e.getMessage());
        }
    }
}
