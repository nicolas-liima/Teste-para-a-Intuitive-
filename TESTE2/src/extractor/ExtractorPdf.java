package extractor;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

import java.io.File;
import java.io.IOException;

public class ExtractorPdf {

    public static String extractTextFromPdf(String pdfPath) {
        String extractedText = "";
        try (PDDocument document = PDDocument.load(new File(pdfPath))) {
            PDFTextStripper pdfStripper = new PDFTextStripper();
            extractedText = pdfStripper.getText(document);
        } catch (IOException e) {
            System.err.println("Erro ao extrair texto do PDF: " + e.getMessage());
        }
        return extractedText;
    }

}
