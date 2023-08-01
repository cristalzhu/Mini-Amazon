Originally created by [Rickard Stureborg](http://www.rickard.stureborg.com) and [Yihao Hu](https://www.linkedin.com/in/yihaoh/) for Fall 2021.
Amended for Fall 2022.

## Installing the Current Skeleton

1. In your VM, change into the repository directory and then run `./install.sh`.
   This will set up a file called `.flashenv`, and create a simple PostgreSQL database named `amazon`.
2. If you are running a Google VM, to view the app in your browser, you may need to edit the firewall rules.
   The [Google VM instructions](https://courses.cs.duke.edu/fall22/compsci316d/instructions/gcp/) on the course page has instructions for how to add rules at the bottom.
   If those for some reason are outdated, here are [instructions provided by Google](https://cloud.google.com/vpc/docs/using-firewalls).
   Create a rule to open up port 5000, which flask will run on.

## Running/Stopping the Website

To run your website, in your VM, go into the repository directory and issue the following commands:
```
source env/bin/activate
flask run
```
The first command will activate a specialized Python environment for running Flask.
While the environment is activated, you should see a `(env)` prefix in the command prompt in your VM shell.
You should only run Flask while inside this environment; otherwise it will produce an error.

If you are running a local Vagrant VM, to view the app in your browser, you simply need to visit [http://localhost:5000/](http://localhost:5000/).
If you are running a Google VM, you will need to point your browser to `http://vm_external_ip_addr:5000/`, where `vm_external_ip_addr` is the external IP address of your Google VM.

To stop your website, simply press <kbd>Ctrl</kbd><kbd>C</kbd> in the VM shell where flask is running.
You can then deactivate the environment using
```
deactiviate
```

## Working with the Database

The Flask server interacts with a PostgreSQL database called `amazon` behind the scene.
As part of the installation procedure above, this database has been created automatically.
You can access the database directly by running the command `psql amazon` in your VM.

The `db/` subdirectory of this repository contains files useful for (re-)initializing the database if needed.
To (re-)initialize the database, first make sure that you are NOT running your Flask server or any `psql` sessions; then, from your repository directory, run `db/setup.sh`.
* You will see lots of text flying by---make sure you go through them carefully and verify there was no errors.
  Any error in (re-)initializing the database will cause your Flask server to fail, so make sure you fix them.
* If you get `ERROR:  database "amazon" is being accessed by other users`, that means you likely have Flask or another `psql` still running; terminate them and re-run `db/setup.sh`.
  If you cannot seem to find where you are running them, a sure way to get rid of them is to restart your VM.

To change the database schema, modify `db/create.sql` and `db/load.sql` as needed.
Make sure you to run `db/setup.sh` to reflect the changes.

Under `db/data/`, you will find CSV files that `db/load.sql` uses to initialize the database contents when you run `db/setup.sh`.
Under `db/generated/`, you will find alternate CSV files that will be used to initialize a bigger database instance when you run `db/setup.sh generated`; these files are automatically generated by running a script (which you can re-run by going inside `db/data/generated/` and running `python gen.py`.
* Note that PostgreSQL does NOT store data inside these CSV files; it store data on disk files using an efficient, binary format.
  In other words, if you change your database contents through your website or through `psql`, you will NOT see these changes reflected in these CSV files (but you can see them through `psql amazon`).
* For safety, a database should never store password in plain text; instead it stores one-way hash of the password.
  This rule applies to the password value in the CSV files too.
  To see what hashed password value you should put in a CSV file, see `db/data/gen.py` for example of how compute the hashed value.
