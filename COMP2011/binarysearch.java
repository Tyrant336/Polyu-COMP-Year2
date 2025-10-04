
public class binarysearch {


     public static int binarySearch (int []a , int key ) {
     int n = a.length ;
     int l = 0 , r = n - 1;
     while ( l <= r ) {
          int mid = ( l + r ) / 2;
          if ( a [mid] == key ) return mid ;
          else if ( a [mid] > key ) r = mid - 1;
          else if ( a [mid] < key ) l = mid + 1;
          }
     return -1;
     }
     public static void main(String[] args) {
         int[] numbers = [1,2,4,4,4,5,6,7];

     }
     
}
