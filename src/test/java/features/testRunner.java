package features;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.jupiter.api.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class testRunner {

    public void generateReport(String karateOutputPath, String projectName) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), projectName);
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

    @Test
    public void testAllParallel() {
        Results results = Runner.path(
                "classpath:features/RF321/RF321.feature",
                "classpath:features/AdidasInvoicing/RF442.feature")
                .tags("~@Ignore")
                .outputCucumberJson(true)
                .parallel(5);
        generateReport(results.getReportDir(), "All tests");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }


    //TODO: update tags param to handle multiple values - replace all xTests classes with this runner
    public void runTestParallel(String path, String tags, int threads, String runName) {
        Results results = Runner.path(path)
                .tags(tags)
                .outputCucumberJson(true)
                .parallel(threads);
        generateReport(results.getReportDir(), runName);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}