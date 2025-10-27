import org.w3c.dom.Node;

public class reverselinkedlist {
    class Node 
    {
        int data;
        Node next;

        Node(int data)
        {
            this.data = data;
            this.next = null;
        }
    }
    public void add(Node head) {
       Node cur = head;
       if (head == null) {
           head = cur;
       } else {
           Node current = head;
           while (current.next != null) {
               current = current.next;
           }
           current.next = newNode;
       }
   }
    
}
