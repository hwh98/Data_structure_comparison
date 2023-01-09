classdef hashtableTest < matlab.unittest.TestCase
    properties
       
        X = ["apple","ban","can","dog", "eggs", "frogs", "garage", "google", "Amazon", "Jupyter"];
        lookup_exist = 'dog'; 
        lookup_none = 'abnormal';
        verify_X_length = 10; % for verifying
        verify_keyForban = '3712744971268364110168754611410839565112';
        %X_100 = ["ilumnpdsma","bzxvwvygck","lrezgqyzfy","gtoaepuopv","awgvqcfawx","uxnekueguk","lhlealljzd","qtarqtalxs","asagafkxkp","esgyronilx","vqbjwetwgb","yxgabozpbq","ssrggdekuc","jtockudesw","wihgvmqbgg","kayazqcsga","lvrvazglde","hhxucxnfdu","ltfpenpmzp","fzikfummrd","ygggfxgdro","oihmzwwohe","fdtrntqmgv","temefeomrx","yiyoeencuh","mnxwdehqnx","jcaxcrosms","trkihoymlv","llvdmztdiv","syziglcled","ksoqwiufes","twdnrlvgxt","wyzoxvpdkj","grgatedzhi","ydwzomoeja","zmztomdjql","rxkoyhwaez","tomiicqwwq","jrdlsewucq","tvhmmmdpuq","txabxagewt","yykkzhnmfm","ucwattlwqt","ftzdoviaqz","dknjuduccq","gefbrtgded","pikprkywgh","bcuegjbqvx","zcsnugbhvj","odtuthgxll","ibdhikhzkr","djxyyhnhap","xuraauuoja","gwsyakumpc","qkbdybojji","ksqinhyytp","oymzhrbear","vkfclvljzk","hvpmufcylc","tonvbyybod","ksmrwcvchf","lnpwoekpiq","jlqlkfflze","irdueisuha","nygjnsunqf","eyqpmptxhi","ymozpcjkyp","qbmtutzsui","sfnlufqlug","vhzuvdrzpa","igocmlvbjq","ftdeokbtbk","eogsnukuom","gnelsxvtra","olllukfrqy","dvujzqiiqi","cmmyhncyri","hnphffkult","seukvgewti","bzotwxtlln","omsfdrwvli","shavagvlod","yyrgksmunt","vormvyffjc","yxaxddvtlx","edbjrwmvot","qgwrnpypbz","cwszgxtdtl","lxjizxeccw","cietsjvmry","zmlroeqdyb","dnbpkskdxv","txxtrhlflf","axacionhvb","xvewssfdvn","aatxjdbvzb","frdngqrqul","srrbmarfqi","zmcfamzlll","bvavrzgbrr"];
        %loookup_100_exist = 'lnpwoekpiq';
        %lookup_100_none = 'josha';
    end

    methods(Test)
        function testConstructor(testCase)
            ht = hashTable(testCase.X); % instanized ht
            testCase.verifyEqual(length(ht.X), testCase.verify_X_length);
        end % end function

        function testXtohashtable(testCase)
            ht = hashTable(testCase.X); % instanized ht
            testCase.verifyEqual(javaMethod('isEmpty',ht.ht),true, 'how come hashtable is not empty before adding thing') % test if the hashtable is empty before putting X in
            ht.Xtohashtable() % put the X into the hashtable
            testCase.verifyEqual(javaMethod('isEmpty',ht.ht),false, 'failed to add key-value into hashtabl') % the hashtable is NOT empty after putting X in
            
            % test for certain key-value with the key of 'ban'
            testCase.verifyEqual(javaMethod('get',ht.ht, testCase.verify_keyForban),'ban','some key-value set is wrong')
        end % end function

        function testhashingfun(testCase)
            ht = hashTable(testCase.X); % instanized ht
            testCase.verifyEqual(ht.hashingfun('ban'),testCase.verify_keyForban)
        end % end function

        function testsearch(testCase)
            ht = hashTable(testCase.X); % instanized ht
            ht.Xtohashtable() % put the X into the hashtable
            testCase.verifyEqual(ht.search(testCase.lookup_exist), true, 'Cant search an Exist element')
            testCase.verifyEqual(ht.search(testCase.lookup_none), false, 'Found a Non-exist element in the hashtable')
        end % end function
    end % end method
end