Lexery
======

Lexery is all about lexical trickery, transforming words into new words.
This was actually a Christmas present for my mother.

Playing
-------
Start the game with:
    ruby bin/lexery

Each round starts with a random word.
To make you new word, you can:

* Add a letter
* Remove a letter
* Replace a letter
* Swap two letters

You may never reuse a word, and you are allowed a limited number of 
'imaginary' as long as you make them using one of the moves listed above.

That's it.  Try to make as many words as you can from the given word.

Examples
--------

Turn Grass into Salt:

      grass => glass => lass => last => salt

Find your Dinner:

      find => fine => dine => diner => dinner
      
Hackery Details
---------------
Lexery uses Gosu for its game interface.  This is my second game 
built on Gosu, and I think it might be possible to extract a fair amount of 
the code into a small game framework.

See 'wordlists/' for more information on the wordlist Lexery uses.

Known Issues and Workarounds
----------------------------
Gosu does not work on MacOSX 10.6 in 64bit mode at the moment, you can run
Lexery with the following command instead:
    arch -i386 ruby bin/lexery

Fonts may look less than awesome on Windows and perhaps Linux.

Contact
-------
      Adam Sanderson
      netghost@gmail.com