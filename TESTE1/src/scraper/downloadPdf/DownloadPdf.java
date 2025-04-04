package scraper.downloadPdf;


import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.io.IOException;



public class DownloadPdf {


    public void downloadPdf(String fileUrl, String fileName) {

        try (InputStream in = new URL(fileUrl).openStream()) {
            Path downloadPath = Path.of(fileName);
            Files.createDirectories(downloadPath.getParent());

            Files.copy(in, downloadPath, StandardCopyOption.REPLACE_EXISTING);

            System.out.println("O download foi concluído: " + downloadPath.toAbsolutePath());
        } catch (IOException e) {
            System.err.println("Ocorreu um erro: Erro ao baixar o arquivo " + fileUrl + ": " + e.getMessage());
        }
    }

}
