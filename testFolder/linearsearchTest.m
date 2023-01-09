%% Test Class Definition
classdef linearsearchTest < matlab.unittest.TestCase

    properties
        X = ["apple","ban","can","dog", "eggs", "frogs", "garage", "google", "Amazon", "Jupyter"];
        lookup_exist = 'dog'; 
        lookup_none = 'abnormal';
    end 
    %% Test Method Block
    methods(Test)
        function testConstructor(testCase)
            ls = linearSearch(testCase.X, testCase.lookup_exist);
            testCase.verifyEqual(ls.lookup, 'dog');
        end

        function testsearch(testCase) % test the search() function check if it can lookup correctly
            % test the item exist
            ls = linearSearch(testCase.X, testCase.lookup_exist);
            found = ls.search();
            testCase.verifyEqual(found, true);
            % tes the item not exist
            ls = linearSearch(testCase.X, testCase.lookup_none);
            found = ls.search();
            testCase.verifyEqual(found, false);
        end
    end
end