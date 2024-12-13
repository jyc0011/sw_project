package swr;

import java.sql.Connection;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ConnectionContext {
    private static final String JNDI_NAME = "java:comp/env/jdbc/mysql";
    private static DataSource dataSource;

    static {
        try {
            Context initContext = new InitialContext();
            dataSource = (DataSource) initContext.lookup(JNDI_NAME);
            System.out.println("데이터베이스 연결 풀 초기화 성공");
        } catch (NamingException e) {
            System.err.println("JNDI 리소스를 찾을 수 없습니다: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            if (dataSource != null) {
                conn = dataSource.getConnection();
                System.out.println("데이터베이스 연결 성공");
            } else {
                System.err.println("DataSource가 초기화되지 않았습니다.");
            }
        } catch (Exception e) {
            System.err.println("데이터베이스 연결 오류: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
