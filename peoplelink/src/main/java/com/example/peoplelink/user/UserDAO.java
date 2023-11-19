package com.example.peoplelink.user;

import javax.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;

public class UserDAO {

    // 데이터베이스에 접근하게 해주는 객체
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    // 실제로 mysql에 접속하게 해주는 부분 == DAO
    public UserDAO() {
        try {
            String dbURL = "jdbc:mysql://localhost:3306/PL";
            String dbID = "root";
            String dbPassword = "1234";
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int login(String userID, String userPassword) {
        String SQL1 = "SELECT userPassword FROM USER WHERE userID = ?";
        try {
            pstmt = conn.prepareStatement(SQL1);
            pstmt.setString(1, userID);
            rs= pstmt.executeQuery();  // 결과 담기
            if (rs.next()) {
                if (rs.getString(1).equals(userPassword)) {
                    return 1;  // 로그인 성공
                }
                else
                    return 0;  // 비밀번호 불일치
            }
            return -1;  // 아이디가 없음
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -2;  // 데이터베이스 오류
    }

    public int join(User user) {
        String SQL2 = "INSERT INTO USER VALUES (?,?,?,?)";
        // INSERT 문 일 경우 0보다 큰 값이 나오기 때문에 return 값 -1 일 때만 오류 처리
        try {
            pstmt = conn.prepareStatement(SQL2);
            pstmt.setString(1, user.getUserID());
            pstmt.setString(2, user.getUserPassword());
            pstmt.setString(3, user.getUserNickname());
            pstmt.setString(4, user.getUserEmail());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;  // 데이터베이스 오류
    }
}