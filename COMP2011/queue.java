public class queue {
    public class Queue<T> {
        private Object[] data;
        private int front, rear;
    public Queue(int size){
    data = new Object[size];
    front = 0;
    rear = 0;
    }
 }
 public boolean isEmpty() {
    
 }
 public void enqueue(T e) {}
 public T dequeue() {}
}
