package scraper.FilesToZip;

import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;


public class FilesToZip {


    public void filesToZip(Path sourceFolder, Path zipFilePath) {
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
