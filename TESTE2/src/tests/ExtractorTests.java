package tests;

import extractor.ExtractorPdf;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.io.File;


public class StractorTests {

    @Test
    public void testExtractTextFromPdf() {
        String pdfPath = "src\\downloads\\Anexo_I.pdf";

        File file = new File(pdfPath);
        assertTrue(file.exists(), "O arquivo PDF não foi encontrado!");

        String extractedText = ExtractorPdf.extractTextFromPdf(pdfPath);

        assertTrue(extractedText.contains("Rol de Procedimentos"), "O texto extraído deve conter 'Rol de Procedimentos'");
    }
}


