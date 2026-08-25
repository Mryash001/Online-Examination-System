package com.exam.dao;

import com.exam.model.Result;
import com.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    public boolean saveResult(int userId, int score, int totalQuestions) {

        String sql = "INSERT INTO results (user_id, score, total_questions) VALUES (?, ?, ?)";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);
            statement.setInt(2, score);
            statement.setInt(3, totalQuestions);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Result> getResultsByUserId(int userId) {

        List<Result> results = new ArrayList<>();

        String sql = "SELECT * FROM results WHERE user_id = ? ORDER BY submitted_at DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, userId);

            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {

                Result result = new Result();

                result.setId(resultSet.getInt("id"));
                result.setUserId(resultSet.getInt("user_id"));
                result.setScore(resultSet.getInt("score"));
                result.setTotalQuestions(
                        resultSet.getInt("total_questions")
                );
                result.setSubmittedAt(
                        resultSet.getTimestamp("submitted_at")
                );

                results.add(result);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return results;
    }
}