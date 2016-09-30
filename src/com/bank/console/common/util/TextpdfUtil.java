package com.bank.console.common.util;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;

public class TextpdfUtil {
	public static PdfPCell createCell(Paragraph p, int rowspan, int colspan) {
		PdfPCell cell = new PdfPCell();
		cell.setRowspan(rowspan);
		cell.setColspan(colspan);
		cell.addElement(p);

		cell.setNoWrap(false);

		return cell;
	}

	public static PdfPCell createCell(Paragraph p, int rowspan, int colspan, int horizontal, int vertical) {
		PdfPCell cell = new PdfPCell(p);
		cell.setRowspan(rowspan);
		cell.setColspan(colspan);
		cell.setHorizontalAlignment(horizontal);
		cell.setVerticalAlignment(vertical);
		cell.setNoWrap(false);

		return cell;
	}

	public static Paragraph createParagraph(String content, Font font) {
		Paragraph p = new Paragraph();
		p.setFont(font);
		p.add(content);
		return p;
	}

	public static Paragraph createParagraphWithTab(Font font, String key, String value, float tab) {
		Paragraph p = new Paragraph();
		p.setFont(font);
		p.add(key);
//		p.setTabSettings(new TabSettings(tab));
//		p.add(Chunk.TABBING);
		p.add(value);
		return p;
	}

	public static Paragraph addChunk(Paragraph p, Font font, String value) {
		Chunk chunk = new Chunk(value);
		chunk.setFont(font);
		p.add(chunk);
		return p;
	}
}
