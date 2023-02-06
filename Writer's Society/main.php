
<?php
session_start();
include("database.php");
?>



<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	 

   <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Itim&display=swap" rel="stylesheet">


<link rel="stylesheet" type="text/css" href="style.css">


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


<style type="text/css">
  .content{
   box-shadow: rgba(136, 165, 191, 0.48) 6px 2px 16px 0px, rgba(255, 255, 255, 0.8) -6px -2px 16px 0px;
  }
  .title{
   box-shadow: rgba(3, 102, 214, 0.3) 0px 0px 0px 3px;
  }

  .post{
    box-shadow: rgba(156, 222, 247, 0.80) 0px -50px 36px -28px inset;
  }

  body{
    background-image: url('main.jpg');
  }


</style>




</head>
<body>

<nav class="navbar navbar-expand-lg nav">
  <div class="container-fluid">
    <a class="navbar-brand" href="http://localhost/WRITER'S%20SOCIETY/admin/admin.php"><img src="WS.jpeg"  width="50" height="54"></a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
      <div class="navbar-nav">
        <a class="nav-link active" aria-current="page" href="http://localhost/WRITER'S%20SOCIETY/main.php">Posts</a>
        <a class="nav-link" href="http://localhost/WRITER'S%20SOCIETY/about.php">About Me</a>
        
      </div>
    </div>
  </div>
</nav>

<div class="container text-center">
  
<div class="row">
    <div class="col-12 col-lg-8" style="border: 2px solid black;">

     <?php

$sql="SELECT *FROM posts";
$result=mysqli_query($conn,$sql);

if(mysqli_num_rows($result)>0){
  echo"<br>";

  while($row=mysqli_fetch_assoc($result)){
    
    echo "<div class='post'>";
    echo "<h4 class= 'title'>" .$row["title"]. "</h4>" ;
    echo "<p class= 'content'>".$row["content"]."</p>";
    
    echo"</div>";

  }
}



?>
  
</div>
    

    <div class="col-4" id="side" style="border: 2px solid black;">
       <?php

$sql="SELECT *FROM posts";
$result=mysqli_query($conn,$sql);

 echo "<div class='post'>";
 echo"<br>";
if(mysqli_num_rows($result)>0){
  while($row=mysqli_fetch_assoc($result)){
    
    echo "<h4>" .$row["title"]. "</h4>" ;
    
    
   

  }
}

echo"</div>";
?>
  

    </div>
  </div>


</div>











<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
</body>
</html>