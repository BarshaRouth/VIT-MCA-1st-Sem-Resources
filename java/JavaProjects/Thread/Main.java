package Thread;
// Task 1: Display Even and Odd Numbers
class EvenOddTask extends Thread {
    private int n;
    public EvenOddTask(int n) {
        this.n = n;
    }
    
    public void run() {
        System.out.println("Even Numbers:");
        for (int i = 1; i <= n; i++) {
            if (i % 2 == 0) {
                System.out.println(i);
            }
        }

        System.out.println("Odd Numbers:");
        for (int i = 1; i <= n; i++) {
            if (i % 2 != 0) {
                System.out.println(i);
            }
        }
    }
}

// Task 2: Sum of First N Natural Numbers
class SumTask extends Thread {
    private int n;
    public SumTask(int n) {
        this.n = n;
    }

    public void run() {
        int sum = (n * (n + 1)) / 2;  // Formula for sum of first n natural numbers
        System.out.println("Sum of first " + n + " natural numbers: " + sum);
    }
}

// Task 3: Generate Fibonacci Series
class FibonacciTask extends Thread {
    private int n;
    public FibonacciTask(int n) {
        this.n = n;
    }

    public void run() {
        int a = 0, b = 1;
        System.out.print("Fibonacci Series: ");
        for (int i = 0; i < n; i++) {
            System.out.print(a + " ");
            int next = a + b;
            a = b;
            b = next;
        }
        System.out.println();
    }
}

public class Main {
    public static void main(String[] args) throws InterruptedException {
        int n = 10; // You can change n as per your requirement

        // Create and start threads for each task
        EvenOddTask evenOddTask = new EvenOddTask(n);
        SumTask sumTask = new SumTask(n);
        FibonacciTask fibonacciTask = new FibonacciTask(n);

        // Start all threads
        evenOddTask.start();
        sumTask.start();
        fibonacciTask.start();

        // Wait for all threads to finish
        evenOddTask.join();
        sumTask.join();
        fibonacciTask.join();

        System.out.println("All tasks completed.");
    }
}

