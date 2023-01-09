classdef cuckoofilterTest < matlab.unittest.TestCase
    properties
        X = ["apple","ban","can","dog", "eggs", "frogs", "garage", "google", "Amazon", "Jupyter"];
        X_100 = ["ilumnpdsma","bzxvwvygck","lrezgqyzfy","gtoaepuopv","awgvqcfawx","uxnekueguk","lhlealljzd","qtarqtalxs","asagafkxkp","esgyronilx","vqbjwetwgb","yxgabozpbq","ssrggdekuc","jtockudesw","wihgvmqbgg","kayazqcsga","lvrvazglde","hhxucxnfdu","ltfpenpmzp","fzikfummrd","ygggfxgdro","oihmzwwohe","fdtrntqmgv","temefeomrx","yiyoeencuh","mnxwdehqnx","jcaxcrosms","trkihoymlv","llvdmztdiv","syziglcled","ksoqwiufes","twdnrlvgxt","wyzoxvpdkj","grgatedzhi","ydwzomoeja","zmztomdjql","rxkoyhwaez","tomiicqwwq","jrdlsewucq","tvhmmmdpuq","txabxagewt","yykkzhnmfm","ucwattlwqt","ftzdoviaqz","dknjuduccq","gefbrtgded","pikprkywgh","bcuegjbqvx","zcsnugbhvj","odtuthgxll","ibdhikhzkr","djxyyhnhap","xuraauuoja","gwsyakumpc","qkbdybojji","ksqinhyytp","oymzhrbear","vkfclvljzk","hvpmufcylc","tonvbyybod","ksmrwcvchf","lnpwoekpiq","jlqlkfflze","irdueisuha","nygjnsunqf","eyqpmptxhi","ymozpcjkyp","qbmtutzsui","sfnlufqlug","vhzuvdrzpa","igocmlvbjq","ftdeokbtbk","eogsnukuom","gnelsxvtra","olllukfrqy","dvujzqiiqi","cmmyhncyri","hnphffkult","seukvgewti","bzotwxtlln","omsfdrwvli","shavagvlod","yyrgksmunt","vormvyffjc","yxaxddvtlx","edbjrwmvot","qgwrnpypbz","cwszgxtdtl","lxjizxeccw","cietsjvmry","zmlroeqdyb","dnbpkskdxv","txxtrhlflf","axacionhvb","xvewssfdvn","aatxjdbvzb","frdngqrqul","srrbmarfqi","zmcfamzlll","bvavrzgbrr"];
        lookup_exist = 'dog'; 
        lookup_none = 'abnormal';
        maxkick = 20; % the maximum time of kicking item
        bitnum = 8; % number of bit of the hashing value.
        bitnum16 = 16; % number of bit of the hashing value for 16 bits.
        verify_arrsize = 256; % verify the arrsize 256 = 2^8 (8-bit bitnum = 8-bits hashing)
        verify_kickedfingerprint = "c9933dad790e910730fb6f60385eb717"; % for testxorhashIndex
        verify_collideindex = 164; % for testxorhashIndex
        verify_xorlIndex = 228; % for testxorhashIndex
        verify_hashelement = "abound"; % for testhashcuckoo
        verify_hashIndex = 237; %for testhashcuckoo
        verify_hash16Index = 28527; %for testhashcuckoo in 16 bits
        verify_addelement = "garage"; % for testcuckooadd & testaddelement
        verify_addIndex = 93; % for testcuckooadd & testaddelement
        verify_addfgp = "3824795e4e1fbf0f72f1cf99ee90d861"; % for testcuckooadd & testaddelement
    end % end properties

    methods(Test)
        function testconstructor(testCase) % test constructor
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            % checking
            testCase.verifyEqual(length(cf.bucketarr), testCase.verify_arrsize, 'wrong array size')
        end % end function

        function testbinarysearch(testCase) % test it like a normal binarysearch, and it has nothing to do with the cuckoo filter itself
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            found = cf.binarysearch(testCase.lookup_exist, testCase.X); % X should be sorted array
            testCase.verifyEqual(found, true, 'Cant search an Exist element');
            % test the item not exist
            found = cf.binarysearch(testCase.lookup_none,testCase.X);
            testCase.verifyEqual(found, false, 'Found a Non-exist element in the hashtable');
        end % end function 

        function testxorhashIndex(testCase) % to test the calculation of "(collideIndex) XOR hash(fingerprinted of the kicked object)"
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            newindex = cf.xorhashIndex(testCase.verify_kickedfingerprint, testCase.verify_collideindex);
            % checking
            testCase.verifyEqual(newindex, testCase.verify_xorlIndex, 'wrong XOR in 8-bits');
            % for testing 16-bits
            cf = cuckooFilter(testCase.X, testCase.bitnum16, testCase.maxkick);
            newindex = cf.xorhashIndex(testCase.verify_kickedfingerprint, testCase.verify_collideindex);
            % checking
            testCase.verifyLessThanOrEqual(newindex, 2^testCase.bitnum16, 'wrong XOR in 16-bits');

        end % end function.

        function testhashcuckoo(testCase) % check whether the generated index is right in the hashing func
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            newindex = cf.hashcuckoo(testCase.verify_hashelement);
            newindex = bin2dec(newindex)% turn the binary char into value
            % checking
            testCase.verifyEqual(newindex, testCase.verify_hashIndex, '8-bits may hash wrongly');
            %test the 16 bits
            cf = cuckooFilter(testCase.X, 16, testCase.maxkick);
            newindex = cf.hashcuckoo(testCase.verify_hashelement);
            newindex = bin2dec(newindex)% turn the binary char into value
            % checking
            testCase.verifyEqual(newindex, testCase.verify_hash16Index,'16-bits may hash wrongly');
        end % end function 

        function testcuckooadd(testCase) % check if we can add the element into the bucket successfully.
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            [cf,success] = cf.cuckooadd(testCase.verify_addelement) % test to add 1st element "appple".
            % checking
            testCase.verifyEqual(success, true, 'failed to add element'); % whether successfully add
            testCase.verifyEqual(cf.bucketarr(testCase.verify_addIndex), testCase.verify_addfgp,'the bucket might not set up correctly(some index store the wrong fingerprint)') % check wether the index in bucket store the element's fingerprint
        end % end function
        
        
        function testaddelement(testCase) % check if the X is put into the bucket correctly.
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            cf = cf.addelement();
            % checking
            testCase.verifyEqual(cf.bucketarr(93), testCase.verify_addfgp,'the bucket not set up correctly(index store wrong fingerprint)') % check wether the index in bucket store the element's fingerprint
            exceptZero = cf.bucketarr(~cellfun('isempty', cf.bucketarr)); % delete the we want to check the number of element in the bucket
            testCase.verifyEqual(length(exceptZero), length(testCase.X), 'The number of element in bucket is wrong, maybe some is missing or some was added twice');
            % test the condition when the bucket is full.
            cf = cuckooFilter(testCase.X_100, testCase.bitnum, 1); % maxkick =1 to create the scnene of bucket is full.
            cf = cf.addelement();
            % checking
            testCase.verifyEqual(cf.fullyadd, false, 'The bucket suppose to be full');
        end % end function 
        
        function testsearch(testCase) % test if we can find element in the cuckoo filter
            cf = cuckooFilter(testCase.X, testCase.bitnum, testCase.maxkick);
            cf = cf.addelement(); % we need to add element in the bucket
            % checking
            testCase.verifyEqual(cf.search(testCase.lookup_exist), true, 'Cant search an Exist element')
            testCase.verifyEqual(cf.search(testCase.lookup_none), false, 'Found a Non-exist element in the hashtable')
        end
        
    end % end methods
end