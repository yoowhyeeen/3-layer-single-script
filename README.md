# 3-layer-single-script

Testing Lab

In this Lab you will be providede a module that has 3 layers, combining 3 different behaviours into one file.

The purpose of the lab is to explore a 3 layer script (module/tests/execute), by:
using the module as an import to execute a function
execute the script directly as an executable to view a tiny sqlite3 database
write proper documentation for the tests
refactor the tests to use a pytest fixture
set up a makefile to create short cuts for all three uses of the file
there are sereval possiblities for extra credit for a little extra challenge

Overall the main point is to make sure
The file will work as a module that can be imported into a project
The file will have tests that only activate when run with pytest and verify the code in the file
The file will run when called directly
Along the way, we'll also get a simple intro and use to makefiles.

Setup for this assignment

1 pt: Create a new github public repo (you'll send in the link) and call it '3-layer-single-script'
Clone the repo to your local machine
1 pt: Create a requirements.txt file with 'pytest' in it
Copy the file provided HERE "db_viewer.py" into the repo (so at this point, there should be only two files, except maybe a readme if you added one)
1 pt: Create a .gitignore file in your repo and add env in the file (this will keep our environment from getting checked into github.
After the setup above, you should run python3 -m venv env to create the virtual environment, activate it and then run pip install -r requiremts.txt to install pytest.

Checkpoint:

You should be able to run python db_viewer.py and see DB NOT found! run intialize_datase first, this is normal. Just type quit and you should be back to the command line.
1 pt At this point you should also be able to run pytest -vvx db_viewer.py and see green come through the console for the passing tests.
If the last two steps worked, then youre ready for hte next steps
NB: If you ran the steps backwards, that is to say, ran the tests first before executing the script you'll notice the database message above doesn't show up. That is because the tests create the database, this is actually a bug we'd like to fix, but that is later in this lab. At this point, do an ls and if you see aquarium.db go ahead and delete/remove it before going onto the next step.

Using the script as a module

We just saw that the script acts as a test module since we can run pytest with it and run the tests. The message you got earlier, about the database not existing is because we have not created one. Let's create another script that uses our main script as a module to initiaze the database.

1 pt - Create a small script initialize_database.py, and it should literally contain 2 lines
The first line should import the file db_viewer
the second line should call the modules initialize_database function, and that should do it.
1 pt - Verify that python initialize_database.py generates the aquarium.py file mentioned before. If it does, now try running the main script python db_viewer.py and you should see a new message, DB found, getting cursor. If you now type select * from fish; at the cursor and enter, you should see two lines show up with names and two types of fish.
If this section worked, good, you've setup the script as a module and we're ready for a quick tangent on makefiles

Side trip to makefiles

Makefiles are some of the original automation provided by linux. It was intended for assisting in compiling tedouls multi file interactions for large programs written in c and c++. It is a bit archaic and can have some loopy syntax. However, if you keep things simple this functionality can serve as a shortcut and as documentation to how to use your script.

Setting up the Makefile
1 pt: Add a file named makefile to your project.
I'll give you the contents here and your task for this section will be to verify these work. These will be run when we test your repo contents in the end.
default:
    @cat makefile

view:
    python db_viewer.py

init:
    python initialize_database.py

test:
    pytest -vvx db_viewer.py

clean:
    rm aquarium.py

Now let's test it out

Type make and you should see the contents of the file on the console. The command make executes a section of the makefile, which by default it will be the first instruction. I got into the habit of always addint the default: at the top so I would not accientaly trigger anything, and this way it just shows me the contents and thus the commands available. By the way, ...

IMPORTANT words starting on the left with the : are the commands. No spaces on the left of those words like default, view, init, and clean. AND DOUBLY important, the space in the executing lines, that first space are before @cat makefile for example HAS TO BE A TAB character. Those are some idiosicrasies of the the makefile.

The @ symbol in @cat makefile means execute cat makefile but do not echo the command to the console, otherwise you'd see cat makefile every time you execute. Just keeps things neater on the command output.

Now let's try make view, make init, make test, and make clean. You can probably tell from the simple commands what they do.
Why of makefiles

You now have shortcuts to your most common commands you'll be using
Another dev/Data-Scientist now using your repo has a view of how to use it, in real life there may be all sorts of flags -x.... -file .... etc, so you may even have a few ways of running it. In this way the file serves as documentation.

Also

clean is very typical as you can use it "reset" to some initial conditions etc
test is very common in makefiles

You can 'chain' the commands. If you wanted to load the database fresh every time you may do something like this
clean_view: clean init view

1 pt And that's it, a make clean_view should run the clean, init and then view for you.

Using a pytest fixture

2 pt Use a pytest fixture to provide the data used to create the test database (The CREATE TABLE... INSERT INTO... INSERT INTO... lines)

At this point we've got 10 pts for the lab possible. And if everything works good, we'll be running the make file commands, and looking at the Given/When/Then, plus the implementation of a fixture. The rest of this lab is for extra credit, or to possibly cover any points missed above.

Going further

1 pt Set up your makefile so the tests always run when you use make view
2 pt use a pytest decorator so only one tests for the db runs, say you consider this a smoke test. What you're simulating here is running all the fast, or most important tests quickly. Add a makefile entry so we can run make test_smoke and make test. test_smoke should run a subset only.
3 pt As mentioned earlier, there is a bug here. If we run the tests, they leave the test intantiation of aquarium.db behind. Fix the bug and make sure all your tests still pass.
3 pt Modify the script so you pass it the name of a pre-existing database, while keeping all the tests running with our test database aquarium.db. After all the utlity of the file is looking at any sqlite3 db, not just that one.
4 pt Modify the file further and

Part 3 Adding an if __name__=="__main__": section to script
This will allow for both using the script standalone to inspect a sqlite database, but also can be used to explore or do some exploratory testing.
