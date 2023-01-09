addpath("Datastructure_class/")
suite = testsuite("testFolder")

import matlab.unittest.plugins.CodeCoveragePlugin
import matlab.unittest.plugins.codecoverage.CoverageReport
runner = testrunner("textoutput");
sourceCodeFolder = "Datastructure_class";
reportFolder = "coverageReport";
reportFormat = CoverageReport(reportFolder);
p = CodeCoveragePlugin.forFolder(sourceCodeFolder,"Producing",reportFormat);
runner.addPlugin(p)

results = runner.run(suite)