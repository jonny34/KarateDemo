package features.AdidasInvoicing;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import features.testRunner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class Rf442Tests {

    private final testRunner tr = new testRunner();

    //Below test is purely for debugging
    @Test
    public void debugRunner() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@Debug")
                .outputCucumberJson(true)
                .parallel(10);
        tr.generateReport(results.getReportDir(), "Debug runner");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void singleThreadRunner() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@RF-442", "@1Thread", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(1);
        tr.generateReport(results.getReportDir(), "RF-442 - @1Thread run for checking sequential handling of PID");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void multiThreadRunner() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@RF-442", "@MultiThread", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(2);
        tr.generateReport(results.getReportDir(), "RF-442 - @Multithread run for checking parallel handling of PID");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testFeatureParallel() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@RF-442", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-442 - All including @Ignores");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testRegressionParallel() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@Regression", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-442 - Regression");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testSanityParallel() {
        Results results = Runner.path("classpath:features/AdidasInvoicing/RF442.feature")
                .tags("@Sanity", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-442 - Sanity");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
