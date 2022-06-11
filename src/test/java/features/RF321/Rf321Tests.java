package features.RF321;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import features.testRunner;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class Rf321Tests {

    private final testRunner tr = new testRunner();

    //Below test is purely for debugging
    @Test
    public void debugRunner() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@Debug")
                .outputCucumberJson(true)
                .parallel(1);
        tr.generateReport(results.getReportDir(), "JDBC - Single thread JDBC connection test");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void singleThreadRunner() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@RF-321", "@1Thread", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(1);
        tr.generateReport(results.getReportDir(), "RF-321 - @1Thread run for checking sequential handling of PID");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void multiThreadRunner() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@RF-321", "@MultiThread", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-321 - @Multithread run for checking parallel handling of PID");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testFeatureParallel() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@RF-321", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-321 - All including @Ignores");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testRegressionParallel() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@Regression", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-321 - Regression");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

    @Test
    public void testSanityParallel() {
        Results results = Runner.path("classpath:features/RF321/RF321.feature")
                .tags("@Sanity", "~@Ignore", "~@Bug")
                .outputCucumberJson(true)
                .parallel(5);
        tr.generateReport(results.getReportDir(), "RF-321 - Sanity");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
