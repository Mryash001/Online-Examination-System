package com.exam.dao;

import com.exam.model.AdminStudentPerformance;
import com.exam.model.Result;
import com.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminPerformanceDAO {

    public List<AdminStudentPerformance> getStudentPerformance() {

        List<AdminStudentPerformance> students = new ArrayList<>();

        String sql =
                "SELECT " +
                "u.id, " +
                "u.name, " +
                "u.email, " +
                "COUNT(r.id) AS total_attempts, " +
                "COALESCE(SUM(CASE " +
                "WHEN (r.score * 100.0 / NULLIF(r.total_questions, 0)) >= 40 " +
                "THEN 1 ELSE 0 END), 0) AS passed_attempts, " +
                "COALESCE(SUM(CASE " +
                "WHEN (r.score * 100.0 / NULLIF(r.total_questions, 0)) < 40 " +
                "THEN 1 ELSE 0 END), 0) AS failed_attempts, " +
                "COALESCE(AVG(r.score * 100.0 / NULLIF(r.total_questions, 0)), 0) AS average_percentage " +
                "FROM users u " +
                "LEFT JOIN results r ON u.id = r.user_id " +
                "WHERE u.role = 'STUDENT' " +
                "GROUP BY u.id, u.name, u.email " +
                "ORDER BY u.name";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                AdminStudentPerformance student =
                        new AdminStudentPerformance();

                student.setUserId(
                        resultSet.getInt("id")
                );

                student.setName(
                        resultSet.getString("name")
                );

                student.setEmail(
                        resultSet.getString("email")
                );

                student.setTotalAttempts(
                        resultSet.getInt("total_attempts")
                );

                student.setPassedAttempts(
                        resultSet.getInt("passed_attempts")
                );

                student.setFailedAttempts(
                        resultSet.getInt("failed_attempts")
                );

                student.setAveragePercentage(
                        resultSet.getDouble("average_percentage")
                );

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    public List<Result> getAllResults() {

        List<Result> results = new ArrayList<>();

        String sql =
                "SELECT r.*, u.name, u.email " +
                "FROM results r " +
                "INNER JOIN users u ON r.user_id = u.id " +
                "WHERE u.role = 'STUDENT' " +
                "ORDER BY r.submitted_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                Result result = new Result();

                result.setId(
                        resultSet.getInt("id")
                );

                result.setUserId(
                        resultSet.getInt("user_id")
                );

                result.setScore(
                        resultSet.getInt("score")
                );

                result.setTotalQuestions(
                        resultSet.getInt("total_questions")
                );

                result.setSubmittedAt(
                        resultSet.getTimestamp("submitted_at")
                );

                result.setStudentName(
                        resultSet.getString("name")
                );

                result.setStudentEmail(
                        resultSet.getString("email")
                );

                results.add(result);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }

    public List<AdminStudentPerformance> getStudentsWithoutAttempts() {

        List<AdminStudentPerformance> students =
                new ArrayList<>();

        String sql =
                "SELECT u.id, u.name, u.email " +
                "FROM users u " +
                "LEFT JOIN results r ON u.id = r.user_id " +
                "WHERE u.role = 'STUDENT' " +
                "AND r.id IS NULL " +
                "ORDER BY u.name";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {

                AdminStudentPerformance student =
                        new AdminStudentPerformance();

                student.setUserId(
                        resultSet.getInt("id")
                );

                student.setName(
                        resultSet.getString("name")
                );

                student.setEmail(
                        resultSet.getString("email")
                );

                student.setTotalAttempts(0);
                student.setPassedAttempts(0);
                student.setFailedAttempts(0);
                student.setAveragePercentage(0);

                students.add(student);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }

    public int getTotalStudents() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM users " +
                "WHERE role = 'STUDENT'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getStudentsWithAttempts() {

        String sql =
                "SELECT COUNT(DISTINCT u.id) " +
                "FROM users u " +
                "INNER JOIN results r ON u.id = r.user_id " +
                "WHERE u.role = 'STUDENT'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }

    public int getTotalAttempts() {

        String sql =
                "SELECT COUNT(*) " +
                "FROM results r " +
                "INNER JOIN users u ON r.user_id = u.id " +
                "WHERE u.role = 'STUDENT'";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                return resultSet.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }
}