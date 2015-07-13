# solryum
********************************************************************************
                                                                                 
     .o00o.   .o0o.   ll      |||li.   \\    //  UU    UU  MM     MM             
    .*       o     o  ll      ||  ||    \\  //   UU    UU  MMM   MMM             
     .0o.    0     0  ll      ||  ||     \\//    UU    UU  MMMM MMMM             
      **.o   0     0  ll      ||OO*       ||     UU    UU  MM MMM MM             
         ..  o     o  ll      ||  \\      ||     UU    UU  MM  M  MM             
     *000*    *000*   lllllll ||   \\     ||       UUUU    MM     MM             
                                                                                 
********************************************************************************
                       cminor9@gmail.com


this whole thing is used to get SOLR to index taxonomies for author and 
year published.  Since SOLR does index taxonomies as we need them to, 
this is a cheap way to get it to work without rewriting SOLR or Biblio or 
anything crazy like that.  It is external to Drupal in that it doesn't touch 
Drupal's API.  It just operates on the tables themselves.  The assumption 
is made that you are using taxonomies, which is a module within Drupal.

I just gave it fancy name for fun.  It has nothing to do with Yum.



To install this:

1) put this dir in the scripts dir within Drupal

2) run the procedure.  You will need to change the DB name in the 
      use statement in the SQL script to your schema's name. 
      (this should be in the first line of code in procs.sql)
      
3) go into do_updates.php and change your servername, uid, passwd to the 
      appropriate values.  These are found in the mysql_connect statement.  
      Here is the documentation for that: http://us3.php.net/manual/en/function.mysql-connect.php
      
4) in do_updates.php, set the constant DB_NAME to whatever your database 
      name is (the same value you put into the use statement in the SQL script in step 2)

5) optional, schedule this to run as a job, run it in cron in *nix or Drupal.  
      Or run it manually using the index.html file in this dir.  For more 
      info on scheduling as a job, read the index.html file.
