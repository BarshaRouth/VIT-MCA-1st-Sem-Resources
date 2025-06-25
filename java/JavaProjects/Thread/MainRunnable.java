package Thread;
class MyRunnable implements Runnable {
    private String name;
    
    public MyRunnable(String name) {
        this.name = name;
    }

    public void run() {
        for (int i = 1; i <= 5; i++) {
            System.out.println(name + " is running - " + i);
            try {
                Thread.sleep(6000); // Sleep for 1 second
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

public class MainRunnable {
    public static void main(String[] args) {
        MyRunnable myRunnable1 = new MyRunnable("Thread-1");
        MyRunnable myRunnable2 = new MyRunnable("Thread-2");
        
        Thread thread1 = new Thread(myRunnable1);
        Thread thread2 = new Thread(myRunnable2);
        
        thread1.start();
        thread2.start();
    }
}

