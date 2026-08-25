package com.exam.dao;

import com.exam.model.Question;
import com.exam.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    public boolean addQuestion(Question question) {

        String sql = "INSERT INTO questions " +
                "(question_text, option_a, option_b, option_c, option_d, correct_option, source) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'MANUAL')";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, question.getQuestionText());
            statement.setString(2, question.getOptionA());
            statement.setString(3, question.getOptionB());
            statement.setString(4, question.getOptionC());
            statement.setString(5, question.getOptionD());
            statement.setString(6, question.getCorrectOption());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Question> getAllQuestions() {

        List<Question> questions = new ArrayList<>();

        String sql = "SELECT * FROM questions ORDER BY id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql);
             ResultSet resultSet =
                     statement.executeQuery()) {

            while (resultSet.next()) {

                Question question = createQuestionFromResultSet(resultSet);

                questions.add(question);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    public Question getQuestionById(int id) {

        String sql = "SELECT * FROM questions WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            ResultSet resultSet =
                    statement.executeQuery();

            if (resultSet.next()) {

                return createQuestionFromResultSet(resultSet);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateQuestion(Question question) {

        String sql = "UPDATE questions SET " +
                "question_text = ?, " +
                "option_a = ?, " +
                "option_b = ?, " +
                "option_c = ?, " +
                "option_d = ?, " +
                "correct_option = ? " +
                "WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, question.getQuestionText());
            statement.setString(2, question.getOptionA());
            statement.setString(3, question.getOptionB());
            statement.setString(4, question.getOptionC());
            statement.setString(5, question.getOptionD());
            statement.setString(6, question.getCorrectOption());
            statement.setInt(7, question.getId());

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteQuestion(int id) {

        String sql = "DELETE FROM questions WHERE id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, id);

            return statement.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Question> getRandomQuestions(int limit) {

        List<Question> questions = new ArrayList<>();

        String sql = "SELECT * FROM questions ORDER BY RAND() LIMIT ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setInt(1, limit);

            ResultSet resultSet =
                    statement.executeQuery();

            while (resultSet.next()) {

                Question question =
                        createQuestionFromResultSet(resultSet);

                questions.add(question);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    public boolean addQuestions(List<Question> questions) {

        String checkSql =
                "SELECT id FROM questions WHERE question_text = ?";

        String insertSql =
                "INSERT INTO questions " +
                "(question_text, option_a, option_b, option_c, option_d, correct_option, source) " +
                "VALUES (?, ?, ?, ?, ?, ?, 'XML')";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement checkStatement =
                     connection.prepareStatement(checkSql);
             PreparedStatement insertStatement =
                     connection.prepareStatement(insertSql)) {

            for (Question question : questions) {

                checkStatement.setString(
                        1,
                        question.getQuestionText()
                );

                ResultSet resultSet =
                        checkStatement.executeQuery();

                if (resultSet.next()) {
                    continue;
                }

                insertStatement.setString(
                        1,
                        question.getQuestionText()
                );

                insertStatement.setString(
                        2,
                        question.getOptionA()
                );

                insertStatement.setString(
                        3,
                        question.getOptionB()
                );

                insertStatement.setString(
                        4,
                        question.getOptionC()
                );

                insertStatement.setString(
                        5,
                        question.getOptionD()
                );

                insertStatement.setString(
                        6,
                        question.getCorrectOption()
                );

                insertStatement.executeUpdate();
            }

            return true;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteXMLQuestions() {

        String sql =
                "DELETE FROM questions WHERE source = 'XML' AND id > 0";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            return statement.executeUpdate() >= 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Question> getQuestionsBySource(String source) {

        List<Question> questions = new ArrayList<>();

        String sql =
                "SELECT * FROM questions " +
                "WHERE source = ? " +
                "ORDER BY id DESC";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement =
                     connection.prepareStatement(sql)) {

            statement.setString(1, source);

            ResultSet resultSet =
                    statement.executeQuery();

            while (resultSet.next()) {

                Question question =
                        createQuestionFromResultSet(resultSet);

                questions.add(question);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    private Question createQuestionFromResultSet(
            ResultSet resultSet) throws Exception {

        Question question = new Question();

        question.setId(
                resultSet.getInt("id")
        );

        question.setQuestionText(
                resultSet.getString("question_text")
        );

        question.setOptionA(
                resultSet.getString("option_a")
        );

        question.setOptionB(
                resultSet.getString("option_b")
        );

        question.setOptionC(
                resultSet.getString("option_c")
        );

        question.setOptionD(
                resultSet.getString("option_d")
        );

        question.setCorrectOption(
                resultSet.getString("correct_option")
        );

        question.setSource(
                resultSet.getString("source")
        );

        return question;
    }
}