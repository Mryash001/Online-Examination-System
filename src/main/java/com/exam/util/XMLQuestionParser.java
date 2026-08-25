package com.exam.util;

import com.exam.model.Question;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

public class XMLQuestionParser {

    public static List<Question> parse(InputStream inputStream) {

        List<Question> questions = new ArrayList<>();

        try {

            DocumentBuilderFactory factory =
                    DocumentBuilderFactory.newInstance();

            DocumentBuilder builder =
                    factory.newDocumentBuilder();

            Document document =
                    builder.parse(inputStream);

            document.getDocumentElement().normalize();

            NodeList nodeList =
                    document.getElementsByTagName("question");

            for (int i = 0; i < nodeList.getLength(); i++) {

                Node node = nodeList.item(i);

                if (node.getNodeType() == Node.ELEMENT_NODE) {

                    Element element = (Element) node;

                    Question question = new Question();

                    question.setQuestionText(
                            getValue(element, "questionText")
                    );

                    question.setOptionA(
                            getValue(element, "optionA")
                    );

                    question.setOptionB(
                            getValue(element, "optionB")
                    );

                    question.setOptionC(
                            getValue(element, "optionC")
                    );

                    question.setOptionD(
                            getValue(element, "optionD")
                    );

                    question.setCorrectOption(
                            getValue(element, "correctOption")
                    );

                    questions.add(question);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return questions;
    }

    private static String getValue(Element element, String tagName) {

        NodeList nodes =
                element.getElementsByTagName(tagName);

        if (nodes.getLength() == 0) {
            return "";
        }

        return nodes.item(0)
                .getTextContent()
                .trim();
    }
}