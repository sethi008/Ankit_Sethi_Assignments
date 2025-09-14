import java.util.Iterator;
import java.util.LinkedList;
import java.util.Scanner;

public class A1 {
    public static void main(String[] args) {
        LinkedList<String> ll = new LinkedList<>();
        ll.add("May");
        ll.add("June");
        ll.add("July");
        ll.add("August");
        ll.add("April");
        ll.add("November");
        ll.addLast("December");
        ll.addFirst("January");
        ll.add("March");
        ll.add(1, "February");
        ll.add("September");
        ll.add(9, "October");

        String[] months = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"};
        for (int i = 0; i < 12; i++) {
            int idx = ll.indexOf(months[i]);
            String obj = ll.get(idx);
            ll.remove(idx);
            ll.add(i, obj);
        }

        System.out.println(ll);

        Iterator<String> itr = ll.iterator();

        // Even Months
        if (itr.hasNext()) {
            itr.next();
        }
        while (itr.hasNext()) {
            System.out.println(itr.next());
            if (itr.hasNext()) {
                itr.next();
            }
        }

        // Odd Months
        itr = ll.iterator();
        while (itr.hasNext()) {
            System.out.println(itr.next());
            if (itr.hasNext()) {
                itr.next();
            }
        }

        // All months
        itr = ll.iterator();
        while (itr.hasNext()) {
            System.out.println(itr.next());
        }

        // first and last month
        System.out.println(ll.getFirst() + " " + ll.getLast());

        // birthday month
        Scanner sc = new Scanner(System.in);
        System.out.println("Enter your birthday month number: ");
        int birthdayMonth = sc.nextInt();
        sc.close();
        
        System.out.println("Birthday Month: " + ll.get(birthdayMonth - 1));
        ll.remove(birthdayMonth - 1);

        // Winter months
        String[] winterMonths = {"November", "December", "January", "February", "March"};
        boolean containsWinter = false;
        for (String m : winterMonths) {
            if (ll.contains(m)) {
                System.out.println("Contains winter months");
                containsWinter = true;
                break;
            }
        }

        if (!containsWinter) {
            System.out.println("Doesn't contain winter months");
        }

        // first and last peeks
        System.out.println(ll.peekFirst());
        System.out.println(ll.peekLast());

        // first and last removal
        ll.pollFirst();
        ll.pollLast();
    }
}
