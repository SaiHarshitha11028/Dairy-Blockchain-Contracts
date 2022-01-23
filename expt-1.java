import 

class Solution {
    public int solution(int[] A) {
        // write your code in Java SE 8
        int N= A.length;
        Set<Integers> set=new HashSet();
        for(int a : A){
            if(a>0){
                set.add(a);
            }
        }
        for(int i=1; i<=N+1; i++){
            if(!set.contains(i)){
                return i;
            }
        }
    }
}
