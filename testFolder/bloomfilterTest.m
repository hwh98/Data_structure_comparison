classdef bloomfilterTest < matlab.unittest.TestCase
    properties
       
        X = ["apple","ban","can","dog", "eggs", "frogs", "garage", "google", "Amazon", "Jupyter"];
        lookup_exist = 'dog'; 
        lookup_none = 'abnormal';
        bsize = 10000; % size of bit array
        hash_num = 10; % number of hash function
        verify_dogIndex = 5041; % one of the hashing index of item 'dog'
        verify_hashingelement = 'mississippi'; % the hashing item for verification
        verify_IndexofMississippi = 8992; % the resulting hashing index for 'verify_hashingelement'
        %X_100 = ["ilumnpdsma","bzxvwvygck","lrezgqyzfy","gtoaepuopv","awgvqcfawx","uxnekueguk","lhlealljzd","qtarqtalxs","asagafkxkp","esgyronilx","vqbjwetwgb","yxgabozpbq","ssrggdekuc","jtockudesw","wihgvmqbgg","kayazqcsga","lvrvazglde","hhxucxnfdu","ltfpenpmzp","fzikfummrd","ygggfxgdro","oihmzwwohe","fdtrntqmgv","temefeomrx","yiyoeencuh","mnxwdehqnx","jcaxcrosms","trkihoymlv","llvdmztdiv","syziglcled","ksoqwiufes","twdnrlvgxt","wyzoxvpdkj","grgatedzhi","ydwzomoeja","zmztomdjql","rxkoyhwaez","tomiicqwwq","jrdlsewucq","tvhmmmdpuq","txabxagewt","yykkzhnmfm","ucwattlwqt","ftzdoviaqz","dknjuduccq","gefbrtgded","pikprkywgh","bcuegjbqvx","zcsnugbhvj","odtuthgxll","ibdhikhzkr","djxyyhnhap","xuraauuoja","gwsyakumpc","qkbdybojji","ksqinhyytp","oymzhrbear","vkfclvljzk","hvpmufcylc","tonvbyybod","ksmrwcvchf","lnpwoekpiq","jlqlkfflze","irdueisuha","nygjnsunqf","eyqpmptxhi","ymozpcjkyp","qbmtutzsui","sfnlufqlug","vhzuvdrzpa","igocmlvbjq","ftdeokbtbk","eogsnukuom","gnelsxvtra","olllukfrqy","dvujzqiiqi","cmmyhncyri","hnphffkult","seukvgewti","bzotwxtlln","omsfdrwvli","shavagvlod","yyrgksmunt","vormvyffjc","yxaxddvtlx","edbjrwmvot","qgwrnpypbz","cwszgxtdtl","lxjizxeccw","cietsjvmry","zmlroeqdyb","dnbpkskdxv","txxtrhlflf","axacionhvb","xvewssfdvn","aatxjdbvzb","frdngqrqul","srrbmarfqi","zmcfamzlll","bvavrzgbrr"];
        %loookup_100_exist = 'lnpwoekpiq';
        %lookup_100_none = 'josha';
    end % end properties

    methods(Test)
        function testConstructor(testCase)
            bf = bloomFilter(testCase.X, testCase.bsize, testCase.hash_num);
            testCase.verifyEqual(length(bf.bitarr), testCase.bsize, 'size of bit array is wrong') % verify the initialize of bit array
            testCase.verifyEqual(class(bf.bitarr), 'logical','bit array may not be logical') % verify if the bit array is logical
        end % end function

        function testaddelement(testCase)
            bf = bloomFilter(testCase.X, testCase.bsize, testCase.hash_num);
            bf = bf.addelement();
            testCase.verifyEqual(bf.bitarr(testCase.verify_dogIndex), true, 'Some bit in the array might not be set properly.') % Given bsize = 100 and element 'dog' is in the bloom filter, we want to check if one of dog's index is set.
            
        end % end function 

        function testhashingbloom(testCase)
            bf = bloomFilter(testCase.X, testCase.bsize, testCase.hash_num);
            % test the FIRST hashing index of the item.
            hashingreulst = bf.hashingbloom(testCase.verify_hashingelement, testCase.bsize, 1);
            testCase.verifyEqual(hashingreulst, testCase.verify_IndexofMississippi)
        end % end function
        
        function testsearch(testCase)
            bf = bloomFilter(testCase.X, testCase.bsize, testCase.hash_num);
            bf = bf.addelement();
            testCase.verifyEqual(bf.search(testCase.lookup_exist), true, 'Cant search an Exist element')
            testCase.verifyEqual(bf.search(testCase.lookup_none), false, 'Found a Non-exist element in the hashtable')
        end % end function 
    end % end methods
end 