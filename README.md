# dctl-synthesis-proto

To use the tool do the following:

1. Compile Parser & Lexer

	 happy -o src/parser/Parser.hs src/parser/Grammar.y

	 alex -o src/parser/Lexer.hs src/parser/Tokens.x 

1. Compile

        ghc -XNPlusKPatterns -isrc -outputdir build -o main src/Main.hs

2. Run the tool    

        ./main <path-to-test>
        
        The test specs are located in tests/
        
3. Convert output to .jpegs

        ./dot2jpeg.sh
        
        This will convert the dot files generated by the tool to jpeg format. Please 
        note that the output of the tool is placed in output/
