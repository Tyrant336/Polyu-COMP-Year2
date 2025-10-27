
 class LinkedList2<T> {
 static class Node<T> {T element; Node<T> next;}
 Node<T> head;
 void insertFirst(T e) {}
 void insertLast(T a){
    Node<T> newNode = new Node<T>(a);

    Node<T> cur = head;
    while(cur.next != null)
    {
        cur = cur.next;
        cur.next = newNode;
    }
 }
 public T removefirstNode()
 {
    Node<T> cur = head, tail;
    Node<T> lastNode = tail;
    head = head.next;
    cur.next =null;
    return head.element; 

 }
 public T removelastNode()
 {
    Node<T> cur = head;
    while(cur.next.next != null)
    {
        cur = cur.next;
    }
    T element = cur.next.element;
    cur.next = null;
    
    return element;
 }
}
 