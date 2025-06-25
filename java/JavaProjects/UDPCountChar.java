import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;

public class UDPCountChar {
    public static DatagramSocket ds;
    public static byte buffer[] = new byte[1024];
    public static void server() {
        System.out.println("SERVER is up");
        try {
            int pos = 0;
            while(true) {
                int ch = System.in.read();
                switch(ch) {
                    case '\n' : ds.send(new DatagramPacket(buffer, pos, InetAddress.getLocalHost(),6666));
                        pos = 0;
                        break;
                    default : buffer[pos++] = (byte)ch;
                        break;
                }
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }
    public static void client() {
        System.out.println("CLIENT is up");
        try {
            int pos = 0;
            while(true) {
                DatagramPacket p = new DatagramPacket(buffer, buffer.length);
                ds.receive(p);
                String str = new String(p.getData(), 0 ,p.getLength()).trim();
                System.out.println("Received : "+ str);
                int cnt[] = new int[26];
                for(int i=0; i<str.length(); i++) {
                    if(str.charAt(i) - 'a' < 26){
                        cnt[str.charAt(i) - 'a']++;
                    }
                }
                System.out.println("Character counts :- ");
                for(int i=0; i<26; i++) {
                    if(cnt[i]!= 0)
                        System.out.println((char)(i+'a') + " : " + cnt[i]);
                }
            } 
        } catch (Exception e) {
            e.printStackTrace();
        } 
    }

    public static void main(String[] args) throws SocketException {
        if (args.length == 1){
            ds = new DatagramSocket(5555);
            server();
        } else {
            ds = new DatagramSocket(6666);
            client();
        }
    }
}