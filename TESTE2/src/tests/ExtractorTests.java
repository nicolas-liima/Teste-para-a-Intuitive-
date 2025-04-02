package tests;

import extractor.ExtractorPdf;
import org.junit.jupiter.api.Test;
import scraper.downloadPdf.DownloadPdf;

import static org.junit.jupiter.api.Assertions.*;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;


public class ExtractorTests {

    @Test
    public void testExtractTextFromPdf() {
        DownloadPdf downloadPdf = new DownloadPdf();
        Path downloadFolder = Paths.get("src\\downloads");

            downloadPdf.downloadPdf(
                    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf",
                    downloadFolder.resolve("Anexo_I.pdf").toString()
            );


        String pdfPath = "src\\downloads\\Anexo_I.pdf";


        try {
            File file = new File(pdfPath);
            assertTrue(file.exists(), "O arquivo PDF de teste não foi encontrado!");

            String extractedText = ExtractorPdf.extractTextFromPdf(pdfPath);
            assertTrue(extractedText.contains("Texto esperado no PDF"), "O PDF não contém o texto esperado.");

        }catch(Exception e) {
            System.out.println("Erro ao ler o arquivo PDF!" + e.getMessage());
        }

    }



}
