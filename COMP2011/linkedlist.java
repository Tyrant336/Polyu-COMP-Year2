public class linkedlist {
    class Node {
   int data;
   Node next;
   // Constructor to initialize a node
   Node(int data) {
       this.data = data;
       this.next = null;
   }
}
class LinkedList {
   Node head;
   // Add a new node at the end
   public void add(int data) {
       Node newNode = new Node(data);
       if (head == null) {
           head = newNode;
       } else {
           Node current = head;
           while (current.next != null) {
               current = current.next;
           }
           current.next = newNode;
       }
   }
   // Display all nodes
   public void display() {
       Node current = head;
       while (current != null) {
           System.out.print(current.data + " -> ");
           current = current.next;
       }
       System.out.println("null");
   }
   // Delete a node by value
   public void delete(int value) {
       if (head == null) return;
       if (head.data == value) {
           head = head.next;
           return;
       }
       Node current = head;
       while (current.next != null && current.next.data != value) {
           current = current.next;
       }
       if (current.next != null) {
           current.next = current.next.next;
       }
   }
}
public class Main {
   public static void main(String[] args) {
       LinkedList list = new LinkedList();
       // Adding elements to the linked list
       list.add(10);
       list.add(20);
       list.add(30);
       // Displaying the linked list
       System.out.println("Linked List:");
       list.display();
       // Deleting an element
       list.delete(20);
       System.out.println("After Deletion:");
       list.display();
   }
}
}
