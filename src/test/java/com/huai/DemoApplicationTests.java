package com.huai;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.*;

@RunWith(SpringRunner.class)
@SpringBootTest
public class DemoApplicationTests {

    @Test
    public void contextLoads() {
    }

    @Test
    public void qc(){
        List<String> list = new ArrayList<>();
        list.add("1");
        list.add("2");
        list.add("3");
        list.add("4");
        list.add("5");
        list.add("6");
        list.add("7");
        list.add("1");
        list.add("2");
        list.add("3");
        list.add("4");
        list.add("1");
        list.add("5");
        list.add("2");
        list.add("3");
        removeDuplicateWithOrder(list);
        System.out.println(list);

    }
    public   static List removeDuplicate(List list)  {
        for  ( int  i  =   0 ; i  <  list.size()  -   1 ; i ++ )  {
            for  ( int  j  =  list.size()  -   1 ; j  >  i; j -- )  {
                if  (list.get(j).equals(list.get(i)))  {
                    list.remove(j);
                }
            }
        }
        return list;
    }

    public static List removeDuplicate2(List list) {
        HashSet h = new HashSet(list);
        list.clear();
        list.addAll(h);
        return list;
    }

    // 删除ArrayList中重复元素，保持顺序
    public static void removeDuplicateWithOrder(List list) {
        Set set = new HashSet();
        List newList = new ArrayList();
        for (Iterator iter = list.iterator(); iter.hasNext();) {
            Object element = iter.next();
            if (set.add(element))
                newList.add(element);
        }
        list.clear();
        list.addAll(newList);
        System.out.println( " remove duplicate " + list);
    }

    public static List removeDuplicate4(List list){
        List listTemp = new ArrayList();
        for(int i=0;i<list.size();i++){
            if(!listTemp.contains(list.get(i))){
                listTemp.add(list.get(i));
            }
        }
        return listTemp;
    }
}
