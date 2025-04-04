package tests.scraper;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import org.junit.jupiter.api.Test;
import scraper.FilesToZip.FilesToZip;
import scraper.GetPdf.GetPdf;
import scraper.downloadPdf.DownloadPdf;

import java.util.Set;
import static org.junit.jupiter.api.Assertions.*;

class ScraperTest {

    @Test
    void testGetPdf() {
        GetPdf getPdf = new GetPdf();
        String url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos";

        Set<String> links = getPdf.getPdf(url);

        assertNotNull(links);
        assertFalse(links.isEmpty());

        links.forEach(link -> assertTrue(link.endsWith(".pdf")));

        links.forEach(link -> assertTrue(link.startsWith("http")));
    }

    @Test
    void testDownloadPdfs() {
        DownloadPdf downloadPdf = new DownloadPdf();
        Path downloadFolder = Paths.get("src\\downloader\\download");

        try {
            Files.createDirectories(downloadFolder);


            downloadPdf.downloadPdf(
                    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf",
                    downloadFolder.resolve("Anexo_I.pdf").toString()
            );

            Path filePath1 = downloadFolder.resolve("Anexo_I.pdf");
            assertTrue(Files.exists(filePath1));
            assertTrue(Files.size(filePath1) > 0);


            downloadPdf.downloadPdf(
                    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_RN628.2025_RN629.2025.pdf",
                    downloadFolder.resolve("Anexo_II.pdf").toString()
            );

            Path filePath2 = downloadFolder.resolve("Anexo_II.pdf");
            assertTrue(Files.exists(filePath2));
            assertTrue(Files.size(filePath2) > 0);


        } catch (Exception e) {
            fail("Ocorreu um erro: Erro no teste de download: " + e.getMessage());
        }
    }

    @Test
    void testFilesToZip() {
        FilesToZip filesToZip = new FilesToZip();
        DownloadPdf downloadPdf = new DownloadPdf();
        Path downloadFolder = Paths.get("src\\downloader\\downloads");
        Path zipFile = Paths.get("src\\zipper\\anexos.zip");

        try {
            Files.createDirectories(downloadFolder);


            downloadPdf.downloadPdf(
                    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf",
                    downloadFolder.resolve("Anexo_I.pdf").toString()
            );

            downloadPdf.downloadPdf(
                    "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos/Anexo_II_DUT_2021_RN_465.2021_RN628.2025_RN629.2025.pdf",
                    downloadFolder.resolve("Anexo_II.pdf").toString()
            );


            filesToZip.filesToZip(downloadFolder, zipFile);


            assertTrue(Files.exists(zipFile));
            assertTrue(Files.size(zipFile) > 0);

        } catch (Exception e) {
            fail("Ocorreu um erro: Erro no teste de compactação: " + e.getMessage());
        }
    }

}
