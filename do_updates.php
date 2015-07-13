<?php
 
      define("DB_NAME", "drupal");
      $conn = mysql_connect('localhost','root','pass');
 
      $action = '';
      if(isset($_POST["action"]))
            $action = $_POST["action"];
 
 
 
      if($action=='full'){
            $sql = 'call '.DB_NAME.'.solr_taxonomies_reload()';
            $result = mysql_query($sql,$conn);
      }
 
      if($action=='incremental'){
            $sql = 'call  '.DB_NAME.'.solr_taxonomies_update()';
            $result = mysql_query($sql,$conn);
      }
 
      if($result)
            echo 'Success.  Hooray.';
      else
            echo 'Failure.  Boo.';
 
?>
