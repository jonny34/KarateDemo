package features;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class regressionRunner {
    private testRunner tr = new testRunner();

    @Test
    public void testAllRegressionParallel() {
        Results results = Runner.path(
                "classpath:features/RF321/RF321.feature",
                "classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@Regression", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "@Regression tests across all features");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}