package com.shshop.helper;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.WhitespaceAnalyzer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.analysis.tokenattributes.OffsetAttribute;
import org.apache.lucene.analysis.tokenattributes.PositionIncrementAttribute;
import org.apache.lucene.util.Version;

public class KeywordGuesser {
	public static String getKeywordsWithoutWhiteSpace(String keywordsByUser, String splitToken) throws IOException {
		StringReader stringReader = new StringReader(keywordsByUser);
		Analyzer analyzer = new WhitespaceAnalyzer(Version.LUCENE_32);
		TokenStream tokenStream = analyzer.tokenStream("title", stringReader);

		CharTermAttribute termAtt = tokenStream.getAttribute(CharTermAttribute.class);
		PositionIncrementAttribute posIncrAtt = tokenStream.addAttribute(PositionIncrementAttribute.class);
		OffsetAttribute offsetAtt = tokenStream.addAttribute(OffsetAttribute.class);

		StringBuilder resultBuilder = new StringBuilder();
		while (tokenStream.incrementToken()) {
			String text = termAtt.toString();

			int postIncrAttr = posIncrAtt.getPositionIncrement();
			int startOffSet = offsetAtt.startOffset();
			int endOffSet = offsetAtt.endOffset();

			System.out.println("text : " + text);
			System.out.println("postIncrAttr : " + postIncrAttr);
			System.out.println("startOffSet : " + startOffSet);
			System.out.println("endOffSet : " + endOffSet);

			if (text != null && text != "") {
				resultBuilder.append(text);
				resultBuilder.append(splitToken);
			}
		}

		String result = resultBuilder.toString();
		if (result != null && result != "") {
			return result.substring(0, result.length() - 1);
		}

		return "";
	}

	public static List<String> tokenizeString(Analyzer analyzer, String string) {
		List<String> result = new ArrayList<String>();
		try {
			TokenStream stream = analyzer.tokenStream(null, new StringReader(string));
			stream.reset();
			while (stream.incrementToken()) {
				result.add(stream.getAttribute(CharTermAttribute.class).toString());
			}
		} catch (IOException e) {
			throw new RuntimeException(e);
		}
		return result;
	}
}
