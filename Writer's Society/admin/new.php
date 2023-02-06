
<?php
session_start();
include("database.php");
if(isset($_SESSION["admin"]) && $_SESSION["admin"]=="akul"){
if(isset($_GET["success"])){
  echo "new post published";
}

?>


<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>



<link rel="stylesheet" type="text/css" href="adminstyle.css">




	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">


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
        <a class="nav-link active" aria-current="page" href="post.php">Posts</a>
        <a class="nav-link" href="new.php">New</a>
        
      </div>
    </div>
  </div>
</nav>


<div class="container">
  <form method="get">
  <div class="mb-3">
  <label for="exampleFormControlInput1" class="form-label">Title</label>
  <input type="text" class="form-control" name="title">
</div>
<div class="mb-3">
  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
  <textarea class="form-control" rows="3" name="content"></textarea>
  <br>

  <input type="submit" class="btn btn-primary" name="publish" value="Publish"></button>
</div>
</div>
</form>

<?php

if(isset($_GET["publish"])){
  $title=$_GET["title"];
  $content=$_GET["content"];

if($title=="" && $content==""){
  echo "invalid entries!!!!";
}
else{

$sql = "INSERT INTO posts (title,content) VALUES('".$title."','".$content."')";
if(!mysqli_query($conn,$sql)){
  echo "blog creation failed";
}else{
  header("Locaton: new.php?success");
}

}

}

}
else{
  header("Location: http://localhost/WRITER'S%20SOCIETY/admin/admin.php");
}
?>


