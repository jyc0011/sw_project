package swr;

import java.io.*;
import java.util.Date;
import lombok.*;

@Data
public class Counter implements Serializable {
    private int count;
    private Date recentDate;

    public Counter() {
        this.count = 0;
        this.recentDate = new Date();
    }

    //getter
    public int getCount() {
        return count;
    }
    //setter
    public void setCount(int count) {
        this.count = count;
    }
    //getter
    public Date getRecentDate() {
        return recentDate;
    }
    //setter
    public void setRecentDate(Date recentDate) {
        this.recentDate = recentDate;
    }
    // 카운터 증가 후 시간 갱신
    public void incrementCount() {
        this.count++;
        this.recentDate = new Date();
    }

    //카운터를 저장
    public void saveToFile(String filePath) {
        try (ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream(filePath))) {
            out.writeObject(this);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    //카운터를 로드
    public static Counter loadFromFile(String filePath) {
        File file = new File(filePath);
        if (!file.exists()) {
            return new Counter();
        }

        try (ObjectInputStream in = new ObjectInputStream(new FileInputStream(filePath))) {
            return (Counter) in.readObject();
        } catch (IOException | ClassNotFoundException e) {
            e.printStackTrace();
            return new Counter();
        }
    }

}
