package scraper;


import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import java.io.InputStream;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


public class Scraper {

    public Set<String> getPdf(String url) {
        Set<String> pdfLinks = new HashSet<>();

        try {
            // conectar no site
            Document doc = Jsoup.connect(url).get();

            Elements links = doc.select("a[href$=.pdf]");

            for (Element link : links) {
                String fileUrl = link.absUrl("href");
                pdfLinks.add(fileUrl);
            }
            for (String link : pdfLinks) {
                System.out.println("PDF encontrado: " + link);
            }

        } catch (IOException e) {
            System.err.println("Ocorreu um erro: Erro ao acessar o site: " + e.getMessage());
        }

        return pdfLinks;
    }

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

    public void FilesToZip(Path sourceFolder, Path zipFilePath) {
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(Files.newOutputStream(zipFilePath))) {
            Files.walk(sourceFolder)
                    .filter(Files::isRegularFile)
                    .forEach(file -> {
                        try (InputStream inputStream = Files.newInputStream(file)) {
                            ZipEntry zipEntry = new ZipEntry(sourceFolder.relativize(file).toString());
                            zipOutputStream.putNextEntry(zipEntry);

                            byte[] buffer = new byte[1024];
                            int length;
                            while ((length = inputStream.read(buffer)) >= 0) {
                                zipOutputStream.write(buffer, 0, length);
                            }

                            zipOutputStream.closeEntry();
                        } catch (IOException e) {
                            System.err.println("Ocorreu um erro: Erro ao adicionar arquivo ao ZIP: " + file + ": " + e.getMessage());
                        }
                    });
            System.out.println("Arquivos compactados em: " + zipFilePath.toAbsolutePath());
        } catch (IOException e) {
            System.err.println("Ocorreu um erro; Erro ao criar arquivo ZIP: " + e.getMessage());
        }
    }
}
