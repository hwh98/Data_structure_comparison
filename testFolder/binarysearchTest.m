classdef binarysearchTest < matlab.unittest.TestCase
    properties
        X = ["apple","ban","can","dog", "eggs", "frogs", "garage", "google", "Amazon", "Jupyter"];
        lookup_exist = 'dog'; 
        lookup_none = 'abnormal';
        %X_100 = ["ilumnpdsma","bzxvwvygck","lrezgqyzfy","gtoaepuopv","awgvqcfawx","uxnekueguk","lhlealljzd","qtarqtalxs","asagafkxkp","esgyronilx","vqbjwetwgb","yxgabozpbq","ssrggdekuc","jtockudesw","wihgvmqbgg","kayazqcsga","lvrvazglde","hhxucxnfdu","ltfpenpmzp","fzikfummrd","ygggfxgdro","oihmzwwohe","fdtrntqmgv","temefeomrx","yiyoeencuh","mnxwdehqnx","jcaxcrosms","trkihoymlv","llvdmztdiv","syziglcled","ksoqwiufes","twdnrlvgxt","wyzoxvpdkj","grgatedzhi","ydwzomoeja","zmztomdjql","rxkoyhwaez","tomiicqwwq","jrdlsewucq","tvhmmmdpuq","txabxagewt","yykkzhnmfm","ucwattlwqt","ftzdoviaqz","dknjuduccq","gefbrtgded","pikprkywgh","bcuegjbqvx","zcsnugbhvj","odtuthgxll","ibdhikhzkr","djxyyhnhap","xuraauuoja","gwsyakumpc","qkbdybojji","ksqinhyytp","oymzhrbear","vkfclvljzk","hvpmufcylc","tonvbyybod","ksmrwcvchf","lnpwoekpiq","jlqlkfflze","irdueisuha","nygjnsunqf","eyqpmptxhi","ymozpcjkyp","qbmtutzsui","sfnlufqlug","vhzuvdrzpa","igocmlvbjq","ftdeokbtbk","eogsnukuom","gnelsxvtra","olllukfrqy","dvujzqiiqi","cmmyhncyri","hnphffkult","seukvgewti","bzotwxtlln","omsfdrwvli","shavagvlod","yyrgksmunt","vormvyffjc","yxaxddvtlx","edbjrwmvot","qgwrnpypbz","cwszgxtdtl","lxjizxeccw","cietsjvmry","zmlroeqdyb","dnbpkskdxv","txxtrhlflf","axacionhvb","xvewssfdvn","aatxjdbvzb","frdngqrqul","srrbmarfqi","zmcfamzlll","bvavrzgbrr"];
        %loookup_100_exist = 'lnpwoekpiq';
        %lookup_100_none = 'josha';
    end

    methods(Test)
        function testConstructor(testCase)
            bs = binarySearch(testCase.lookup_exist,testCase.X);
            testCase.verifyEqual(bs.lookup, 'dog');
            testCase.verifyEqual(length(bs.sortX), 10);
        end

        function testsearch(testCase)
            % test the item exist
            bs = binarySearch(testCase.lookup_exist,testCase.X);
            found = bs.search();
            testCase.verifyEqual(found, true);
            % tes the item not exist
            bs = binarySearch(testCase.lookup_none,testCase.X);
            found = bs.search();
            testCase.verifyEqual(found, false);
        end
    end
    
end