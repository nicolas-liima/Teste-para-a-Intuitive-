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


}
