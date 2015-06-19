package com.shshop.helper.test;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.io.IOException;
import java.io.StringReader;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.TokenStream;
import org.apache.lucene.analysis.WhitespaceAnalyzer;
import org.apache.lucene.analysis.tokenattributes.CharTermAttribute;
import org.apache.lucene.analysis.tokenattributes.OffsetAttribute;
import org.apache.lucene.analysis.tokenattributes.PositionIncrementAttribute;
import org.apache.lucene.util.Version;
import org.junit.Test;

import com.shshop.helper.KeywordGuesser;

public class KeywordsGuesserTest {

	@Test
	public void testWhiteSpaceAnalyzer() throws IOException {
		StringReader stringReader = new StringReader("키워드1 키워드2   키워드3 ");
		Analyzer analyzer = new WhitespaceAnalyzer(Version.LUCENE_32);
		TokenStream tokenStream = analyzer.tokenStream("title", stringReader);

		CharTermAttribute termAtt = tokenStream.getAttribute(CharTermAttribute.class);
		PositionIncrementAttribute posIncrAtt = tokenStream.addAttribute(PositionIncrementAttribute.class);
		OffsetAttribute offsetAtt = tokenStream.addAttribute(OffsetAttribute.class);

		while (tokenStream.incrementToken()) {
			String text = termAtt.toString();
			int postIncrAttr = posIncrAtt.getPositionIncrement();
			int startOffSet = offsetAtt.startOffset();
			int endOffSet = offsetAtt.endOffset();

			System.out.println("text : " + text);
			System.out.println("postIncrAttr : " + postIncrAttr);
			System.out.println("startOffSet : " + startOffSet);
			System.out.println("endOffSet : " + endOffSet);

			assertNotNull("", text);
			assertTrue("", postIncrAttr > 0);
			assertTrue("", startOffSet >= 0);
			assertTrue("", endOffSet > 0);
		}
	}

	@Test
	public void testGet() throws IOException {
		String result = KeywordGuesser.getKeywordsWithoutWhiteSpace("키워드1  키워드2   키워드3.", "|");
		assertTrue("", result.equals("키워드1|키워드2|키워드3."));
	}
}