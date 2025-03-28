package tests.scraper;

import org.junit.jupiter.api.Test;
import scraper.Scraper;


import java.util.Set;

import static org.junit.jupiter.api.Assertions.*;

class ScraperTest {

    @Test
    void testGetPdf() {
        Scraper scraper = new Scraper();
        String url = "https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos";

        Set<String> links = scraper.getPdf(url);

        assertNotNull(links);
        assertFalse(links.isEmpty());

        links.forEach(link -> assertTrue(link.endsWith(".pdf")));

        links.forEach(link -> assertTrue(link.startsWith("http")));
    }



}
